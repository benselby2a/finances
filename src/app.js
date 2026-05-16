const STORAGE_KEYS = {
  lastOpenedAt: "finance.lastOpenedAt",
  lastSummaryWindow: "finance.lastSummaryWindow",
  lastSyncResult: "finance.lastSyncResult"
};
const RECURRING_MAX_BACKFILL_PER_TEMPLATE = 240;

const SUPABASE_CONFIG = window.FINANCE_CONFIG || {};
const SUPABASE_URL = SUPABASE_CONFIG.supabaseUrl || "";
const SUPABASE_ANON_KEY = SUPABASE_CONFIG.supabaseAnonKey || "";

const state = {
  currentUser: null,
  householdId: null,
  syncResult: null,
  supabase: null,
  members: [],
  paymentsPageSize: 20,
  paymentsOffset: 0,
  paymentsHasMore: false,
  editingPaymentId: null,
  titleCategoryIndex: [],
  categoryManuallySet: false,
  splitMode: "preset_you_equal"
};

const GBP_FORMAT = new Intl.NumberFormat("en-GB", {
  style: "currency",
  currency: "GBP"
});

function showToast(message) {
  const toast = document.getElementById("toast");
  toast.textContent = message;
  toast.classList.remove("hidden");
  window.setTimeout(() => toast.classList.add("hidden"), 5000);
}

function setAuthHelp(message) {
  const el = document.getElementById("auth-help");
  if (el) el.textContent = message || "";
}

function setSignInEnabled(enabled) {
  const btn = document.getElementById("sign-in-btn");
  if (btn) btn.disabled = !enabled;
  const form = document.getElementById("sign-in-form");
  if (form) {
    const inputs = form.querySelectorAll("input, button");
    for (const el of inputs) el.disabled = !enabled;
  }
}

function formatError(error) {
  if (!error) return "Unknown error";
  if (typeof error === "string") return error;
  const parts = [];
  if (error.message) parts.push(error.message);
  if (error.code) parts.push(`code=${error.code}`);
  if (error.details) parts.push(`details=${error.details}`);
  if (error.hint) parts.push(`hint=${error.hint}`);
  return parts.join(" | ") || JSON.stringify(error);
}

function setAuthedUI(isAuthed) {
  document.getElementById("auth-gate").classList.toggle("hidden", isAuthed);
  document.getElementById("app").classList.toggle("hidden", !isAuthed);
}

function setupAccordion() {
  const accordions = Array.from(document.querySelectorAll(".accordion"));
  accordions.forEach((section, index) => {
    const key = section.dataset.section;
    const content = section.querySelector(".accordion-content");
    const toggle = section.querySelector(".accordion-toggle");
    const saved = localStorage.getItem(`finance.section.${key}`);
    const open = saved === null ? index === 0 : saved === "open";
    content.classList.toggle("hidden", !open);
    toggle.addEventListener("click", () => {
      const nowOpen = content.classList.contains("hidden");
      content.classList.toggle("hidden", !nowOpen);
      localStorage.setItem(`finance.section.${key}`, nowOpen ? "open" : "closed");
    });
  });
}

function setupModals() {
  const paymentModal = document.getElementById("payment-modal");
  const settingsModal = document.getElementById("settings-modal");
  document.getElementById("add-payment").addEventListener("click", () => {
    if (!state.editingPaymentId) {
      setDefaultPaymentDateIfEmpty();
      setDefaultSplitPreset();
    }
    paymentModal.showModal();
  });
  document.getElementById("open-settings").addEventListener("click", () => settingsModal.showModal());
  document.getElementById("open-settings").addEventListener("click", async () => {
    await renderSyncLogs();
  });

  const recurringToggle = document.getElementById("is-recurring");
  const recurringFields = document.getElementById("recurring-fields");
  const currencySelect = document.querySelector("#payment-form select[name='currency_code']");
  const titleInput = document.querySelector("#payment-form input[name='title']");
  const amountInput = document.querySelector("#payment-form input[name='amount']");
  const categorySelect = document.getElementById("category-select");
  const quickDateButtons = document.querySelectorAll("[data-quick-date]");
  const advancedSplitFields = document.getElementById("advanced-split-fields");
  recurringToggle.addEventListener("change", () => {
    recurringFields.classList.toggle("hidden", !recurringToggle.checked);
    if (recurringToggle.checked && !state.editingPaymentId) {
      setDefaultRecurringDates();
    }
  });
  currencySelect?.addEventListener("change", () => {
    toggleFxFields(currencySelect.value);
  });
  categorySelect?.addEventListener("change", () => {
    state.categoryManuallySet = true;
  });
  titleInput?.addEventListener("blur", () => {
    maybeAutofillCategoryFromTitle();
  });
  amountInput?.addEventListener("input", () => {
    updatePaymentNetEffectPreview();
  });
  quickDateButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const form = document.getElementById("payment-form");
      if (!form) return;
      const today = new Date();
      const mode = btn.getAttribute("data-quick-date");
      if (mode === "today") form.payment_date.value = toIsoDate(today);
      if (mode === "yesterday") {
        const d = new Date(today);
        d.setUTCDate(d.getUTCDate() - 1);
        form.payment_date.value = toIsoDate(d);
      }
      if (mode === "month-start") {
        const d = new Date(today);
        d.setUTCDate(1);
        form.payment_date.value = toIsoDate(d);
      }
    });
  });
  document.getElementById("toggle-advanced-split")?.addEventListener("click", () => {
    if (!advancedSplitFields) return;
    const nowOpen = advancedSplitFields.classList.contains("hidden");
    advancedSplitFields.classList.toggle("hidden", !nowOpen);
    if (nowOpen) state.splitMode = "custom";
    updatePaymentNetEffectPreview();
  });
  toggleFxFields(currencySelect?.value || "GBP");

  document.getElementById("payment-form").addEventListener("submit", async (event) => {
    event.preventDefault();
    const formEl = event.currentTarget;
    try {
      await savePaymentFromForm(formEl);
      showToast(state.editingPaymentId ? "Payment updated." : "Payment saved.");
      paymentModal.close();
      formEl?.reset();
      document.getElementById("recurring-fields").classList.add("hidden");
      toggleFxFields("GBP");
      state.editingPaymentId = null;
      state.categoryManuallySet = false;
      state.splitMode = "preset_you_equal";
      document.querySelector("#payment-modal h3").textContent = "Add Payment";
      setDefaultPaymentDateIfEmpty();
      setDefaultSplitPreset();
      updatePaymentNetEffectPreview();
    } catch (error) {
      console.error(error);
      showToast(`Failed to save payment: ${error.message}`);
    }
  });

  document.getElementById("cancel-payment")?.addEventListener("click", () => {
    const form = document.getElementById("payment-form");
    form?.reset();
    document.getElementById("recurring-fields")?.classList.add("hidden");
    toggleFxFields("GBP");
    state.editingPaymentId = null;
    state.categoryManuallySet = false;
    state.splitMode = "preset_you_equal";
    document.querySelector("#payment-modal h3").textContent = "Add Payment";
    setDefaultPaymentDateIfEmpty();
    setDefaultSplitPreset();
    updatePaymentNetEffectPreview();
    paymentModal.close();
  });

  document.getElementById("run-sync").addEventListener("click", async () => {
    const result = await processRecurringPayments();
    state.syncResult = result;
    localStorage.setItem(STORAGE_KEYS.lastSyncResult, JSON.stringify(result));
    document.getElementById("sync-status").textContent = syncResultLabel(result);
    showToast(`Recurring sync complete: ${result.generated} added, ${result.failed} failed.`);
    await loadDashboardData();
    await renderSyncLogs();
  });
}

function toggleFxFields(currencyCode) {
  const show = String(currencyCode || "").toUpperCase() !== "GBP";
  document.getElementById("fx-rate-to-gbp-row")?.classList.toggle("hidden", !show);
  document.getElementById("fx-rate-date-row")?.classList.toggle("hidden", !show);
}

function toIsoDate(date) {
  return date.toISOString().slice(0, 10);
}

function setDefaultPaymentDateIfEmpty() {
  const form = document.getElementById("payment-form");
  if (!form) return;
  if (!form.payment_date.value) {
    form.payment_date.value = toIsoDate(new Date());
  }
}

function setDefaultRecurringDates() {
  const form = document.getElementById("payment-form");
  if (!form) return;
  const today = new Date();
  const oneYearLater = new Date(today);
  oneYearLater.setUTCFullYear(oneYearLater.getUTCFullYear() + 1);

  if (!form.start_date.value) form.start_date.value = toIsoDate(today);
  if (!form.end_date.value) form.end_date.value = toIsoDate(oneYearLater);
}

function getOtherMember() {
  if (!state.currentUser?.id) return null;
  return state.members.find((m) => m.user_id !== state.currentUser.id) || null;
}

function applyPaidBySingleUser(userId) {
  state.members.forEach((m) => {
    const c = document.querySelector(`[data-paid-by-user='${m.user_id}']`);
    const pct = document.querySelector(`[data-paid-by-pct='${m.user_id}']`);
    const selected = m.user_id === userId;
    if (c) c.checked = selected;
    if (pct) pct.value = selected ? "100" : "0";
  });
}

function renderSplitPresets() {
  const target = document.getElementById("split-presets");
  if (!target) return;
  if (state.members.length !== 2 || !state.currentUser?.id) {
    target.innerHTML = "";
    return;
  }
  const other = getOtherMember();
  if (!other) {
    target.innerHTML = "";
    return;
  }
  const me = memberNameByUserId(state.currentUser.id);
  target.innerHTML = `
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_you_equal" checked />
      <span class="split-preset-label"><span class="split-preset-title">You paid, split equally</span><span class="split-preset-sub">${escapeHtml(other.display_name)} owes half</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_you_full" />
      <span class="split-preset-label"><span class="split-preset-title">You paid, ${escapeHtml(other.display_name)} owes all</span><span class="split-preset-sub">${escapeHtml(me)} owes none</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_other_equal" />
      <span class="split-preset-label"><span class="split-preset-title">${escapeHtml(other.display_name)} paid, split equally</span><span class="split-preset-sub">You owe half</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_other_full" />
      <span class="split-preset-label"><span class="split-preset-title">${escapeHtml(other.display_name)} paid, you owe all</span><span class="split-preset-sub">${escapeHtml(other.display_name)} owes none</span></span>
    </label>
  `;
  target.querySelectorAll("input[name='split_mode']").forEach((el) => {
    el.addEventListener("change", () => {
      state.splitMode = el.value;
      applySplitModeSelection();
      updatePaymentNetEffectPreview();
    });
  });
}

function applySplitModeSelection() {
  if (state.members.length !== 2 || !state.currentUser?.id) return;
  const other = getOtherMember();
  if (!other) return;
  if (state.splitMode === "preset_you_equal" || state.splitMode === "preset_you_full") {
    applyPaidBySingleUser(state.currentUser.id);
  }
  if (state.splitMode === "preset_other_equal" || state.splitMode === "preset_other_full") {
    applyPaidBySingleUser(other.user_id);
  }
}

function setDefaultSplitPreset() {
  const advanced = document.getElementById("advanced-split-fields");
  if (advanced) advanced.classList.add("hidden");
  state.splitMode = "preset_you_equal";
  const radio = document.querySelector("input[name='split_mode'][value='preset_you_equal']");
  if (radio) radio.checked = true;
  applySplitModeSelection();
}

function normalizeTitle(value) {
  return String(value || "")
    .toLowerCase()
    .replace(/[^a-z0-9\s]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function maybeAutofillCategoryFromTitle() {
  if (state.editingPaymentId || state.categoryManuallySet) return;
  const titleInput = document.querySelector("#payment-form input[name='title']");
  const categorySelect = document.getElementById("category-select");
  if (!titleInput || !categorySelect) return;
  const currentCategory = categorySelect.value;
  if (currentCategory && currentCategory !== "other") return;

  const category = inferCategoryFromTitle(titleInput.value);
  if (category) {
    categorySelect.value = category;
  }
}

function inferCategoryFromTitle(title) {
  const query = normalizeTitle(title);
  if (!query) return null;

  const tokens = query.split(" ").filter((t) => t.length > 2);
  const candidates = [];
  for (const row of state.titleCategoryIndex) {
    const n = row.normalizedTitle;
    if (!n) continue;
    let score = 0;
    if (n === query) score += 100;
    if (n.startsWith(query) || query.startsWith(n)) score += 40;
    if (n.includes(query) || query.includes(n)) score += 20;
    for (const tok of tokens) {
      if (n.includes(tok)) score += 3;
    }
    if (score > 0) candidates.push({ category: row.category_key, score });
  }
  if (!candidates.length) return null;

  const aggregate = new Map();
  for (const c of candidates) {
    aggregate.set(c.category, (aggregate.get(c.category) || 0) + c.score);
  }
  const ranked = Array.from(aggregate.entries()).sort((a, b) => b[1] - a[1]);
  return ranked[0]?.[0] || null;
}

function syncResultLabel(result) {
  if (!result) return "No sync run yet.";
  return `Last sync: ${new Date(result.ranAt).toLocaleString()} (${result.generated} added, ${result.failed} failed)`;
}

async function loadSession() {
  const url = new URL(window.location.href);
  const code = url.searchParams.get("code");
  const authError = url.searchParams.get("error_description") || url.searchParams.get("error");
  if (authError) {
    setAuthHelp(`Auth callback error: ${decodeURIComponent(authError)}`);
  }
  if (code) {
    const { error } = await state.supabase.auth.exchangeCodeForSession(code);
    if (error) {
      setAuthHelp(`Sign-in callback failed: ${error.message}`);
      showToast(`Sign-in callback failed: ${error.message}`);
    } else {
      url.searchParams.delete("code");
      url.searchParams.delete("type");
      url.searchParams.delete("error");
      url.searchParams.delete("error_description");
      window.history.replaceState({}, "", url.toString());
    }
  }
  const { data, error } = await state.supabase.auth.getSession();
  if (error) throw error;
  return data.session;
}

async function fetchSummaryCountsSince(lastOpenedAtIso) {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("source_type")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .gt("created_at", lastOpenedAtIso);

  if (error) throw error;

  let oneOffCount = 0;
  let recurringCount = 0;
  for (const row of data || []) {
    if (row.source_type === "one_off") oneOffCount += 1;
    if (row.source_type === "recurring_generated") recurringCount += 1;
  }

  return { oneOffCount, recurringCount };
}

async function processRecurringPayments() {
  const ranAt = new Date().toISOString();
  let generated = 0;
  let failed = 0;

  const { data: templates, error: templatesError } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, household_id, title, amount, currency_code, category_key, notes, frequency, day_of_month, start_date, end_date, status, last_processed_at, created_by")
    .eq("household_id", state.householdId)
    .eq("status", "active");
  if (templatesError) throw templatesError;

  if (!templates?.length) {
    return { ranAt, generated: 0, failed: 0 };
  }

  const templateIds = templates.map((t) => t.id);

  const { data: allContrib, error: contribError } = await state.supabase
    .schema("finance_app")
    .from("recurring_template_contributions")
    .select("recurring_template_id, user_id, mode, value")
    .in("recurring_template_id", templateIds);
  if (contribError) throw contribError;

  const { data: allSplits, error: splitsError } = await state.supabase
    .schema("finance_app")
    .from("recurring_template_splits")
    .select("recurring_template_id, user_id, mode, value")
    .in("recurring_template_id", templateIds);
  if (splitsError) throw splitsError;

  const contribByTemplate = new Map();
  for (const row of allContrib || []) {
    if (!contribByTemplate.has(row.recurring_template_id)) contribByTemplate.set(row.recurring_template_id, []);
    contribByTemplate.get(row.recurring_template_id).push(row);
  }
  const splitsByTemplate = new Map();
  for (const row of allSplits || []) {
    if (!splitsByTemplate.has(row.recurring_template_id)) splitsByTemplate.set(row.recurring_template_id, []);
    splitsByTemplate.get(row.recurring_template_id).push(row);
  }

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  for (const t of templates) {
    const dueDates = computeDueDates(t, today).slice(0, RECURRING_MAX_BACKFILL_PER_TEMPLATE);
    if (!dueDates.length) continue;

    const contribTemplateRows = contribByTemplate.get(t.id) || [];
    const splitTemplateRows = splitsByTemplate.get(t.id) || [];

    for (const dueDate of dueDates) {
      try {
        const dueDateStr = dueDate.toISOString().slice(0, 10);
        const { data: existingLog, error: existingLogError } = await state.supabase
          .schema("finance_app")
          .from("recurring_generation_log")
          .select("id")
          .eq("recurring_template_id", t.id)
          .eq("due_date", dueDateStr)
          .maybeSingle();
        if (existingLogError) throw existingLogError;
        if (existingLog?.id) continue;

        const { data: existingPayment, error: existingPaymentError } = await state.supabase
          .schema("finance_app")
          .from("payments")
          .select("id")
          .eq("generated_by_recurring_template_id", t.id)
          .eq("due_date_for_generation", dueDateStr)
          .eq("source_type", "recurring_generated")
          .is("deleted_at", null)
          .maybeSingle();
        if (existingPaymentError) throw existingPaymentError;
        if (existingPayment?.id) {
          await state.supabase.schema("finance_app").from("recurring_generation_log").insert({
            recurring_template_id: t.id,
            due_date: dueDateStr,
            payment_id: existingPayment.id,
            status: "skipped_exists"
          });
          continue;
        }

        const { data: payment, error: paymentError } = await state.supabase
          .schema("finance_app")
          .from("payments")
          .insert({
            household_id: t.household_id,
            title: t.title,
            amount: t.amount,
            currency_code: t.currency_code || "GBP",
            fx_rate_to_gbp: 1,
            fx_rate_date: dueDateStr,
            amount_gbp: t.amount,
            payment_date: dueDateStr,
            category_key: t.category_key,
            notes: t.notes,
            source_type: "recurring_generated",
            generated_by_recurring_template_id: t.id,
            due_date_for_generation: dueDateStr,
            created_by: t.created_by
          })
          .select("id")
          .single();
        if (paymentError) throw paymentError;

        const contributionRows = materializeTemplateRows(payment.id, Number(t.amount), contribTemplateRows, "payment_contributions");
        const splitRows = materializeTemplateRows(payment.id, Number(t.amount), splitTemplateRows, "payment_splits");

        if (contributionRows.length) {
          const { error } = await state.supabase.schema("finance_app").from("payment_contributions").insert(contributionRows);
          if (error) throw error;
        }
        if (splitRows.length) {
          const { error } = await state.supabase.schema("finance_app").from("payment_splits").insert(splitRows);
          if (error) throw error;
        }

        const { error: logInsertError } = await state.supabase.schema("finance_app").from("recurring_generation_log").insert({
          recurring_template_id: t.id,
          due_date: dueDateStr,
          payment_id: payment.id,
          status: "created"
        });
        if (logInsertError) throw logInsertError;

        generated += 1;
      } catch (error) {
        failed += 1;
        const dueDateStr = dueDate.toISOString().slice(0, 10);
        await state.supabase.schema("finance_app").from("recurring_generation_log").insert({
          recurring_template_id: t.id,
          due_date: dueDateStr,
          status: "failed",
          error_text: formatError(error)
        });
      }
    }

    await state.supabase
      .schema("finance_app")
      .from("recurring_templates")
      .update({ last_processed_at: new Date().toISOString() })
      .eq("id", t.id);
  }

  return { ranAt, generated, failed };
}

function computeDueDates(template, today) {
  const dates = [];
  const start = new Date(`${template.start_date}T00:00:00`);
  if (Number.isNaN(start.getTime())) return dates;
  const end = template.end_date ? new Date(`${template.end_date}T00:00:00`) : null;
  const lastProcessedDate = template.last_processed_at ? new Date(template.last_processed_at) : null;
  const floor = lastProcessedDate && !Number.isNaN(lastProcessedDate.getTime()) ? lastProcessedDate : null;

  if (template.frequency === "annual") {
    let year = start.getUTCFullYear();
    while (year <= today.getUTCFullYear()) {
      const d = new Date(Date.UTC(year, start.getUTCMonth(), start.getUTCDate()));
      if (d < start) {
        year += 1;
        continue;
      }
      if (d > today) break;
      if (end && d > end) break;
      if (!floor || d > floor) dates.push(d);
      year += 1;
    }
    return dates;
  }

  // monthly default
  const day = Number(template.day_of_month || start.getUTCDate());
  let cursor = new Date(Date.UTC(start.getUTCFullYear(), start.getUTCMonth(), 1));
  while (cursor <= today) {
    const year = cursor.getUTCFullYear();
    const month = cursor.getUTCMonth();
    const lastDay = new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
    const date = new Date(Date.UTC(year, month, Math.min(day, lastDay)));
    if (date >= start && date <= today && (!end || date <= end) && (!floor || date > floor)) {
      dates.push(date);
    }
    cursor = new Date(Date.UTC(year, month + 1, 1));
  }
  return dates;
}

function materializeTemplateRows(paymentId, amount, templateRows, tableName) {
  if (!templateRows.length) return [];
  const mode = templateRows[0].mode;
  const rows = [];
  if (mode === "fixed") {
    let total = 0;
    for (const r of templateRows) {
      const v = Number(r.value || 0);
      total += v;
      rows.push({ payment_id: paymentId, user_id: r.user_id, amount: Number(v.toFixed(2)) });
    }
    const delta = Number((amount - total).toFixed(2));
    if (rows.length && Math.abs(delta) >= 0.01) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
    return rows;
  }
  if (mode === "percentage") {
    let total = 0;
    for (const r of templateRows) {
      const calc = (amount * Number(r.value || 0)) / 100;
      const v = Number(calc.toFixed(2));
      total += v;
      rows.push({ payment_id: paymentId, user_id: r.user_id, amount: v });
    }
    const delta = Number((amount - total).toFixed(2));
    if (rows.length && Math.abs(delta) >= 0.01) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
    return rows;
  }
  // ratio and fallback
  let ratioTotal = 0;
  for (const r of templateRows) ratioTotal += Number(r.value || 0);
  if (ratioTotal <= 0) {
    const even = Number((amount / templateRows.length).toFixed(2));
    let total = 0;
    for (const r of templateRows) {
      rows.push({ payment_id: paymentId, user_id: r.user_id, amount: even });
      total += even;
    }
    const delta = Number((amount - total).toFixed(2));
    if (rows.length && Math.abs(delta) >= 0.01) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
    return rows;
  }
  let total = 0;
  for (const r of templateRows) {
    const v = Number(((amount * Number(r.value || 0)) / ratioTotal).toFixed(2));
    rows.push({ payment_id: paymentId, user_id: r.user_id, amount: v });
    total += v;
  }
  const delta = Number((amount - total).toFixed(2));
  if (rows.length && Math.abs(delta) >= 0.01) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
  return rows;
}

function formatGbp(value) {
  return GBP_FORMAT.format(Number(value || 0));
}

function escapeHtml(value) {
  return String(value || "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;");
}

function toDateLabel(dateValue) {
  const d = new Date(`${dateValue}T00:00:00`);
  return d.toLocaleDateString("en-GB", { year: "numeric", month: "short", day: "2-digit" });
}

async function ensureHouseholdContext() {
  const { data: existingHouseholds, error: householdReadError } = await state.supabase
    .schema("finance_app")
    .from("households")
    .select("id, name")
    .order("created_at", { ascending: true })
    .limit(1);
  if (householdReadError) throw householdReadError;

  let householdId = existingHouseholds?.[0]?.id;
  if (!householdId) {
    const { data: inserted, error: insertHouseholdError } = await state.supabase
      .schema("finance_app")
      .from("households")
      .insert(
        {
          name: "Shared Household",
          created_by: state.currentUser.id
        }
      )
      .select("id")
      .single();
    if (insertHouseholdError) throw insertHouseholdError;
    householdId = inserted.id;
  }

  const displayName = state.currentUser.user_metadata?.full_name || state.currentUser.email || "User";
  const { data: existingMember, error: existingMemberError } = await state.supabase
    .schema("finance_app")
    .from("household_members")
    .select("user_id, display_name, is_active")
    .eq("user_id", state.currentUser.id)
    .maybeSingle();
  if (existingMemberError) throw existingMemberError;

  if (!existingMember) {
    const { error: memberInsertError } = await state.supabase
      .schema("finance_app")
      .from("household_members")
      .insert({
        household_id: householdId,
        user_id: state.currentUser.id,
        display_name: displayName,
        is_active: true
      });
    if (memberInsertError) throw memberInsertError;
  } else if (!existingMember.is_active) {
    // Preserve manual display_name edits; only reactivate membership.
    const { error: memberUpdateError } = await state.supabase
      .schema("finance_app")
      .from("household_members")
      .update({ is_active: true, household_id: householdId })
      .eq("user_id", state.currentUser.id);
    if (memberUpdateError) throw memberUpdateError;
  }

  state.householdId = householdId;
}

async function loadMembers() {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("household_members")
    .select("user_id, display_name")
    .eq("household_id", state.householdId)
    .eq("is_active", true);
  if (error) throw error;
  state.members = data || [];
  renderPaidByRows();
}

async function loadCategoryOptions() {
  const select = document.getElementById("category-select");
  if (!select) return;

  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("categories")
    .select("key, label, sort_order")
    .eq("is_active", true)
    .order("sort_order", { ascending: true });
  if (error) throw error;

  const categories = data || [];
  if (!categories.length) {
    select.innerHTML = `<option value="other">Other</option>`;
    return;
  }

  const { data: paymentCats, error: paymentCatsError } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("category_key")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .not("category_key", "is", null)
    .limit(20000);
  if (paymentCatsError) throw paymentCatsError;

  const usage = new Map();
  for (const row of paymentCats || []) {
    const key = row.category_key;
    usage.set(key, (usage.get(key) || 0) + 1);
  }

  const ordered = categories
    .slice()
    .sort((a, b) => {
      const ua = usage.get(a.key) || 0;
      const ub = usage.get(b.key) || 0;
      if (ub !== ua) return ub - ua;
      return a.label.localeCompare(b.label);
    });

  select.innerHTML = ordered
    .map((c) => `<option value="${escapeHtml(c.key)}">${escapeHtml(c.label)}</option>`)
    .join("");

  if (!ordered.some((c) => c.key === "other")) {
    const option = document.createElement("option");
    option.value = "other";
    option.textContent = "Other";
    select.appendChild(option);
  }
}

function renderPaidByRows(prefill = null) {
  const target = document.getElementById("paid-by-rows");
  if (!target) return;
  if (!state.members.length) {
    target.textContent = "No members found.";
    return;
  }

  const selected = new Map();
  if (prefill?.length) {
    for (const p of prefill) selected.set(p.user_id, Number(p.percentage || 0));
  } else if (state.currentUser?.id) {
    selected.set(state.currentUser.id, 100);
  }

  target.innerHTML = state.members
    .map((m) => {
      const pct = selected.get(m.user_id) || 0;
      const checked = pct > 0 ? "checked" : "";
      return `<div style="display:grid; grid-template-columns: 1fr 110px; gap:8px; align-items:center; margin-bottom:6px">
        <label class="inline">
          <input type="checkbox" data-paid-by-user="${m.user_id}" ${checked} />
          ${escapeHtml(m.display_name)}
        </label>
        <input type="number" min="0" max="100" step="0.01" data-paid-by-pct="${m.user_id}" value="${pct}" />
      </div>`;
    })
    .join("");

  target.querySelectorAll("[data-paid-by-user], [data-paid-by-pct]").forEach((el) => {
    el.addEventListener("change", () => updatePaymentNetEffectPreview());
    el.addEventListener("input", () => updatePaymentNetEffectPreview());
  });
  renderSplitPresets();
  if (!prefill?.length) {
    setDefaultSplitPreset();
  } else {
    state.splitMode = "custom";
    const advanced = document.getElementById("advanced-split-fields");
    if (advanced) advanced.classList.remove("hidden");
    const presetRadios = document.querySelectorAll("input[name='split_mode']");
    presetRadios.forEach((r) => {
      r.checked = false;
    });
  }
  updatePaymentNetEffectPreview();
}

function getPaidByAllocations(amount) {
  const checks = Array.from(document.querySelectorAll("[data-paid-by-user]"));
  const selected = [];
  for (const c of checks) {
    const userId = c.getAttribute("data-paid-by-user");
    const pctInput = document.querySelector(`[data-paid-by-pct='${userId}']`);
    const pct = Number(pctInput?.value || 0);
    if (c.checked && pct > 0) selected.push({ user_id: userId, pct });
  }
  if (!selected.length) throw new Error("Select at least one payer with a percentage.");

  const totalPct = selected.reduce((sum, r) => sum + r.pct, 0);
  if (totalPct <= 0) throw new Error("Paid-by percentage total must be greater than 0.");

  const rows = selected.map((r) => ({
    user_id: r.user_id,
    amount: Number(((amount * r.pct) / totalPct).toFixed(2)),
    pct: Number(((r.pct / totalPct) * 100).toFixed(4))
  }));
  const roundedTotal = rows.reduce((s, r) => s + r.amount, 0);
  const delta = Number((amount - roundedTotal).toFixed(2));
  if (Math.abs(delta) >= 0.01 && rows.length) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
  return rows;
}

function getPaidByAllocationsSafe(amount) {
  try {
    return getPaidByAllocations(amount);
  } catch {
    return [];
  }
}

function buildEqualSplitRows(amount) {
  if (!state.members.length) throw new Error("No active members found for split.");
  const per = Number((amount / state.members.length).toFixed(2));
  const rows = state.members.map((m) => ({ user_id: m.user_id, amount: per }));
  const total = rows.reduce((s, r) => s + r.amount, 0);
  const delta = Number((amount - total).toFixed(2));
  if (Math.abs(delta) >= 0.01 && rows.length) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
  return rows;
}

function buildSplitRows(amount, paidByRows) {
  if (state.members.length !== 2) return buildEqualSplitRows(amount);
  if (state.splitMode === "custom" || state.splitMode === "preset_you_equal" || state.splitMode === "preset_other_equal") {
    return buildEqualSplitRows(amount);
  }
  const payer = paidByRows
    .slice()
    .sort((a, b) => Number(b.amount) - Number(a.amount))[0];
  if (!payer) return buildEqualSplitRows(amount);
  if (state.splitMode === "preset_you_full" || state.splitMode === "preset_other_full") {
    const other = state.members.find((m) => m.user_id !== payer.user_id);
    if (!other) return buildEqualSplitRows(amount);
    return [
      { user_id: payer.user_id, amount: 0 },
      { user_id: other.user_id, amount: Number(amount.toFixed(2)) }
    ];
  }
  return buildEqualSplitRows(amount);
}

function updatePaymentNetEffectPreview() {
  const target = document.getElementById("net-effect-preview");
  if (!target) return;
  const amountRaw = document.querySelector("#payment-form input[name='amount']")?.value;
  const amount = Number(amountRaw || 0);
  if (!Number.isFinite(amount) || amount <= 0 || !state.members.length) {
    target.textContent = "Enter amount and payer split to see net effect.";
    return;
  }

  const paidByRows = getPaidByAllocationsSafe(amount);
  if (!paidByRows.length) {
    target.textContent = "Select at least one payer with a percentage to preview net effect.";
    return;
  }
  const splitRows = buildSplitRows(amount, paidByRows);

  const paidMap = new Map();
  const owedMap = new Map();
  const netMap = new Map();
  for (const r of paidByRows) paidMap.set(r.user_id, (paidMap.get(r.user_id) || 0) + Number(r.amount || 0));
  for (const r of splitRows) owedMap.set(r.user_id, (owedMap.get(r.user_id) || 0) + Number(r.amount || 0));

  const lines = state.members.map((m) => {
    const paid = Number((paidMap.get(m.user_id) || 0).toFixed(2));
    const owes = Number((owedMap.get(m.user_id) || 0).toFixed(2));
    const net = Number((paid - owes).toFixed(2));
    netMap.set(m.user_id, net);
    const netText = net >= 0 ? `is owed ${formatGbp(Math.abs(net))}` : `owes ${formatGbp(Math.abs(net))}`;
    return `<div style="display:flex; justify-content:space-between; gap:8px; border-bottom:1px solid #e5e7eb; padding:4px 0">
      <span><strong>${escapeHtml(m.display_name)}</strong></span>
      <span>pays ${formatGbp(paid)} | owes ${formatGbp(owes)} -> <strong>${netText}</strong></span>
    </div>`;
  });

  let headline = "No balance change.";
  if (state.members.length === 2) {
    const [m1, m2] = state.members;
    const n1 = Number((netMap.get(m1.user_id) || 0).toFixed(2));
    const n2 = Number((netMap.get(m2.user_id) || 0).toFixed(2));
    if (n1 > 0.009 && n2 < -0.009) {
      headline = `${escapeHtml(m2.display_name)} owes ${escapeHtml(m1.display_name)} ${formatGbp(Math.abs(n1))}`;
    } else if (n2 > 0.009 && n1 < -0.009) {
      headline = `${escapeHtml(m1.display_name)} owes ${escapeHtml(m2.display_name)} ${formatGbp(Math.abs(n2))}`;
    }
  } else {
    const creditors = [];
    const debtors = [];
    for (const m of state.members) {
      const net = Number((netMap.get(m.user_id) || 0).toFixed(2));
      if (net > 0.009) creditors.push(`${escapeHtml(m.display_name)} +${formatGbp(net)}`);
      if (net < -0.009) debtors.push(`${escapeHtml(m.display_name)} -${formatGbp(Math.abs(net))}`);
    }
    if (creditors.length || debtors.length) headline = `${debtors.join(", ")} | ${creditors.join(", ")}`;
  }

  target.innerHTML = `
    <div style="font-weight:600; margin-bottom:4px">Net Effect</div>
    <div style="margin-bottom:6px"><strong>${headline}</strong></div>
    ${lines.join("")}
  `;
}

function memberNameByUserId(userId) {
  const member = state.members.find((m) => m.user_id === userId);
  return member?.display_name || "Unknown";
}

async function loadDashboardData() {
  let payments = await fetchPaymentsPage({ reset: true });

  // Fallback: if no rows for the current household context, detect a household that has data.
  if (!payments.length) {
    const { data: anyPayments, error: anyPaymentsError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("id, household_id, title, amount_gbp, payment_date, category_key, source_type, created_by")
      .is("deleted_at", null)
      .order("payment_date", { ascending: false })
      .limit(1);
    if (anyPaymentsError) throw anyPaymentsError;
    if (anyPayments && anyPayments.length) {
      state.householdId = anyPayments[0].household_id;
      await loadMembers();
      payments = await fetchPaymentsPage({ reset: true });
      showToast("Switched to household with existing payment history.");
    }
  }

  try {
    renderPayments(payments, new Map());
    try {
      const payerLabels = await buildPayerLabels(payments);
      renderPayments(payments, payerLabels);
    } catch (error) {
      console.error("Failed to load payer labels:", error);
    }
  } catch (error) {
    console.error("Failed to render payments:", error);
    document.getElementById("payments-list").textContent = `Failed to render payments: ${formatError(error)}`;
  }

  let balanceContext = { balances: new Map(), suggestions: [] };
  try {
    balanceContext = (await renderBalances(payments)) || balanceContext;
  } catch (error) {
    console.error("Failed to render balances:", error);
    const balancesEl = document.getElementById("balances-list");
    if (balancesEl) {
      balancesEl.textContent = `Failed to render balances: ${formatError(error)}`;
    } else {
      const owesSummary = document.getElementById("stat-owes-summary");
      if (owesSummary) {
        owesSummary.textContent = `Failed to load balances: ${formatError(error)}`;
      }
    }
  }
  renderRecurringPlaceholder();
  renderRemindersPlaceholder();
  await renderSummaryStats(payments, balanceContext);
  await renderRecurringSection();
  await renderRemindersSection();
  await renderInsights();
  await renderSyncLogs();
  await loadTitleCategoryIndex();
  updateLoadMoreButton();
}

async function loadTitleCategoryIndex() {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("title, category_key")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .not("category_key", "is", null)
    .order("created_at", { ascending: false })
    .limit(3000);
  if (error) throw error;
  state.titleCategoryIndex = (data || []).map((r) => ({
    title: r.title,
    normalizedTitle: normalizeTitle(r.title),
    category_key: r.category_key
  }));
}

async function fetchPaymentsPage({ reset = false } = {}) {
  if (reset) {
    state.paymentsOffset = 0;
  }

  const from = state.paymentsOffset;
  const to = state.paymentsOffset + state.paymentsPageSize - 1;
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("id, household_id, title, amount_gbp, payment_date, category_key, source_type, created_by")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .order("payment_date", { ascending: false })
    .order("created_at", { ascending: false })
    .range(from, to);
  if (error) throw error;

  const rows = data || [];
  state.paymentsHasMore = rows.length === state.paymentsPageSize;
  if (!reset) {
    state.paymentsOffset += rows.length;
  } else {
    state.paymentsOffset = rows.length;
  }
  return rows;
}

function updateLoadMoreButton() {
  const button = document.getElementById("load-more-payments");
  if (!button) return;
  button.classList.toggle("hidden", !state.paymentsHasMore);
}

async function buildPayerLabels(payments) {
  const paymentIds = payments.map((p) => p.id);
  if (!paymentIds.length) return new Map();
  const paymentIdSet = new Set(paymentIds);

  const { data: allContributions, error } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .select("payment_id, user_id, amount")
    .limit(20000);
  if (error) throw error;

  const contributions = (allContributions || []).filter((c) => paymentIdSet.has(c.payment_id));

  const byPayment = new Map();
  for (const c of contributions) {
    if (!byPayment.has(c.payment_id)) byPayment.set(c.payment_id, []);
    byPayment.get(c.payment_id).push(c);
  }

  const labels = new Map();
  for (const id of paymentIds) {
    const rows = (byPayment.get(id) || []).slice().sort((a, b) => Number(b.amount) - Number(a.amount));
    if (!rows.length) {
      labels.set(id, "Unknown");
      continue;
    }
    const names = rows.map((r) => memberNameByUserId(r.user_id));
    labels.set(id, names.join(", "));
  }
  return labels;
}

function renderPayments(payments, payerLabels) {
  const target = document.getElementById("payments-list");
  if (!payments.length) {
    target.textContent = "No payments yet.";
    return;
  }

  const rows = payments
    .slice(0, 200)
    .map((p) => {
      const payer = payerLabels?.get(p.id) || memberNameByUserId(p.created_by);
      return `<tr>
        <td>${toDateLabel(p.payment_date)}</td>
        <td>${escapeHtml(p.title)}</td>
        <td>${escapeHtml(p.category_key || "-")}</td>
        <td>${escapeHtml(p.source_type)}</td>
        <td>${escapeHtml(payer)}</td>
        <td style="text-align:right">${formatGbp(p.amount_gbp)}</td>
        <td style="text-align:right; white-space:nowrap">
          <button type="button" data-action="edit" data-payment-id="${p.id}" style="margin-right:6px">Edit</button>
          <button type="button" data-action="delete" data-payment-id="${p.id}">Delete</button>
        </td>
      </tr>`;
    })
    .join("");

  target.innerHTML = `
    <div style="overflow:auto">
      <table style="width:100%; border-collapse:collapse">
        <thead>
          <tr>
            <th style="text-align:left">Date</th>
            <th style="text-align:left">Title</th>
            <th style="text-align:left">Category</th>
            <th style="text-align:left">Type</th>
            <th style="text-align:left">Payer</th>
            <th style="text-align:right">Amount (GBP)</th>
            <th style="text-align:right">Actions</th>
          </tr>
        </thead>
        <tbody>${rows}</tbody>
      </table>
    </div>
  `;

  target.querySelectorAll("button[data-action='edit']").forEach((btn) => {
    btn.addEventListener("click", () => openEditPaymentModal(btn.getAttribute("data-payment-id")));
  });
  target.querySelectorAll("button[data-action='delete']").forEach((btn) => {
    btn.addEventListener("click", () => deletePayment(btn.getAttribute("data-payment-id")));
  });
}

async function openEditPaymentModal(paymentId) {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("id, title, amount, currency_code, payment_date, fx_rate_to_gbp, fx_rate_date, category_key, notes")
    .eq("id", paymentId)
    .single();
  if (error) {
    showToast(`Failed to load payment: ${formatError(error)}`);
    return;
  }

  const form = document.getElementById("payment-form");
  form.title.value = data.title || "";
  form.amount.value = data.amount || "";
  form.currency_code.value = data.currency_code || "GBP";
  toggleFxFields(form.currency_code.value);
  form.payment_date.value = data.payment_date || "";
  form.fx_rate_to_gbp.value = data.fx_rate_to_gbp || "";
  form.fx_rate_date.value = data.fx_rate_date || "";
  form.category_key.value = data.category_key || "other";
  state.categoryManuallySet = true;
  form.notes.value = data.notes || "";
  const { data: contribRows } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .select("user_id, amount")
    .eq("payment_id", paymentId);
  const total = Number(data.amount || 0) || 1;
  const prefill = (contribRows || []).map((r) => ({
    user_id: r.user_id,
    percentage: (Number(r.amount || 0) / total) * 100
  }));
  renderPaidByRows(prefill);
  form.is_recurring.checked = false;
  document.getElementById("recurring-fields").classList.add("hidden");
  state.editingPaymentId = paymentId;
  document.querySelector("#payment-modal h3").textContent = "Edit Payment";
  document.getElementById("payment-modal").showModal();
  updatePaymentNetEffectPreview();
}

async function deletePayment(paymentId) {
  if (!window.confirm("Delete this payment? It will be hidden from all views.")) return;
  const { error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .update({ deleted_at: new Date().toISOString() })
    .eq("id", paymentId);
  if (error) {
    showToast(`Delete failed: ${formatError(error)}`);
    return;
  }
  showToast("Payment deleted.");
  await loadDashboardData();
}

async function renderBalances(payments) {
  void payments;
  const target = document.getElementById("balances-list");
  if (!target) {
    const { data, error } = await state.supabase.schema("finance_app").rpc("get_household_balances", {
      p_household_id: state.householdId
    });
    if (error) throw error;
    const rows = (data || [])
      .map((r) => ({
        userId: r.user_id,
        name: r.display_name || memberNameByUserId(r.user_id),
        net: Number(r.net || 0)
      }))
      .sort((a, b) => b.net - a.net);
    const balances = new Map(rows.map((r) => [r.userId, r.net]));
    const suggestions = buildSettlementSuggestions(rows);
    return { balances, suggestions };
  }
  const { data, error } = await state.supabase.schema("finance_app").rpc("get_household_balances", {
    p_household_id: state.householdId
  });
  if (error) throw error;

  const rows = (data || [])
    .map((r) => ({
      userId: r.user_id,
      name: r.display_name || memberNameByUserId(r.user_id),
      net: Number(r.net || 0)
    }))
    .sort((a, b) => b.net - a.net);

  const balances = new Map(rows.map((r) => [r.userId, r.net]));

  const balanceRowsHtml = rows
    .map((r) => {
      const label = r.net >= 0 ? "is owed" : "owes";
      return `<div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid #e5e7eb">
        <span>${escapeHtml(r.name)}</span>
        <strong>${label} ${formatGbp(Math.abs(r.net))}</strong>
      </div>`;
    })
    .join("");

  const suggestions = buildSettlementSuggestions(rows);
  const suggestionsHtml = suggestions.length
    ? suggestions
        .map(
          (s) =>
            `<div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid #e5e7eb">
              <span>${escapeHtml(s.from)} pays ${escapeHtml(s.to)}</span>
              <strong>${formatGbp(s.amount)}</strong>
            </div>`
        )
        .join("")
    : `<div style="padding:6px 0">No settlements needed.</div>`;

  target.innerHTML = `
    <div style="margin-bottom:12px">
      <h3 style="margin:0 0 8px 0">Balances</h3>
      ${balanceRowsHtml}
    </div>
    <div>
      <h3 style="margin:0 0 8px 0">Suggested Settlements</h3>
      ${suggestionsHtml}
    </div>
  `;

  return { balances, suggestions };
}

function buildSettlementSuggestions(rows) {
  const creditors = rows
    .filter((r) => r.net > 0.009)
    .map((r) => ({ name: r.name, amount: Number(r.net.toFixed(2)) }))
    .sort((a, b) => b.amount - a.amount);
  const debtors = rows
    .filter((r) => r.net < -0.009)
    .map((r) => ({ name: r.name, amount: Number(Math.abs(r.net).toFixed(2)) }))
    .sort((a, b) => b.amount - a.amount);

  const suggestions = [];
  let i = 0;
  let j = 0;
  while (i < debtors.length && j < creditors.length) {
    const settle = Math.min(debtors[i].amount, creditors[j].amount);
    if (settle > 0.009) {
      suggestions.push({
        from: debtors[i].name,
        to: creditors[j].name,
        amount: Number(settle.toFixed(2))
      });
    }
    debtors[i].amount = Number((debtors[i].amount - settle).toFixed(2));
    creditors[j].amount = Number((creditors[j].amount - settle).toFixed(2));
    if (debtors[i].amount <= 0.009) i += 1;
    if (creditors[j].amount <= 0.009) j += 1;
  }
  return suggestions;
}

function renderRecurringPlaceholder() {
  document.getElementById("recurring-list").textContent = "Recurring templates loading next step.";
}

function renderRemindersPlaceholder() {
  document.getElementById("reminders-list").textContent = "Reminders loading next step.";
}

async function renderRecurringSection() {
  const target = document.getElementById("recurring-list");
  if (!target) return;

  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, title, amount, frequency, start_date, end_date, status")
    .eq("household_id", state.householdId)
    .order("created_at", { ascending: false })
    .limit(200);
  if (error) {
    target.textContent = `Failed to load recurring: ${formatError(error)}`;
    return;
  }

  const rows = data || [];
  if (!rows.length) {
    target.textContent = "No recurring templates yet.";
    return;
  }

  target.innerHTML = rows
    .map((r) => {
      const dates = `${toDateLabel(r.start_date)}${r.end_date ? ` -> ${toDateLabel(r.end_date)}` : ""}`;
      return `<div style="display:flex; justify-content:space-between; gap:12px; padding:6px 0; border-bottom:1px solid #e5e7eb">
        <span>${escapeHtml(r.title)} (${escapeHtml(r.frequency)}) - ${escapeHtml(dates)} - ${escapeHtml(r.status)}</span>
        <span style="display:flex; gap:6px; align-items:center">
          <strong>${formatGbp(r.amount)}</strong>
          <button type="button" data-action="toggle-recurring" data-template-id="${r.id}" data-status="${r.status}">
            ${r.status === "active" ? "Pause" : "Resume"}
          </button>
        </span>
      </div>`;
    })
    .join("");

  target.querySelectorAll("button[data-action='toggle-recurring']").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const templateId = btn.getAttribute("data-template-id");
      const currentStatus = btn.getAttribute("data-status");
      const nextStatus = currentStatus === "active" ? "paused" : "active";
      const { error: updateError } = await state.supabase
        .schema("finance_app")
        .from("recurring_templates")
        .update({ status: nextStatus })
        .eq("id", templateId);
      if (updateError) {
        showToast(`Failed to update recurring: ${formatError(updateError)}`);
        return;
      }
      showToast(`Recurring template ${nextStatus}.`);
      await renderRecurringSection();
      await renderRemindersSection();
    });
  });
}

async function renderRemindersSection() {
  const target = document.getElementById("reminders-list");
  if (!target) return;

  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, title, frequency, day_of_month, start_date, end_date, review_days_before, status")
    .eq("household_id", state.householdId)
    .eq("status", "active")
    .limit(500);
  if (error) {
    target.textContent = `Failed to load reminders: ${formatError(error)}`;
    return;
  }

  const now = new Date();
  const todayUtc = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()));
  const inSevenDaysUtc = new Date(todayUtc);
  inSevenDaysUtc.setUTCDate(inSevenDaysUtc.getUTCDate() + 7);
  const reminders = [];

  function getNextDueDate(template) {
    const start = new Date(`${template.start_date}T00:00:00Z`);
    if (Number.isNaN(start.getTime())) return null;
    const end = template.end_date ? new Date(`${template.end_date}T00:00:00Z`) : null;
    if (end && end < todayUtc) return null;

    if (template.frequency === "annual") {
      const month = start.getUTCMonth();
      const day = start.getUTCDate();
      let due = new Date(Date.UTC(todayUtc.getUTCFullYear(), month, day));
      if (due < todayUtc) due = new Date(Date.UTC(todayUtc.getUTCFullYear() + 1, month, day));
      if (due < start) due = start;
      if (end && due > end) return null;
      return due;
    }

    if (template.frequency === "monthly") {
      const configuredDay = Number(template.day_of_month || start.getUTCDate() || 1);
      const clampDay = (year, month, day) => {
        const lastDay = new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
        return Math.max(1, Math.min(day, lastDay));
      };
      let year = todayUtc.getUTCFullYear();
      let month = todayUtc.getUTCMonth();
      let due = new Date(Date.UTC(year, month, clampDay(year, month, configuredDay)));
      if (due < todayUtc) {
        month += 1;
        if (month > 11) {
          month = 0;
          year += 1;
        }
        due = new Date(Date.UTC(year, month, clampDay(year, month, configuredDay)));
      }
      if (due < start) due = start;
      if (end && due > end) return null;
      return due;
    }

    return null;
  }

  for (const r of data || []) {
    const nextDue = getNextDueDate(r);
    if (nextDue && nextDue >= todayUtc && nextDue <= inSevenDaysUtc) {
      const daysToDue = Math.ceil((nextDue.getTime() - todayUtc.getTime()) / 86400000);
      reminders.push({
        kind: "upcoming",
        template: r,
        text: `Due in next 7 days: ${r.title} (${Math.max(daysToDue, 0)} days, ${toDateLabel(nextDue.toISOString().slice(0, 10))})`
      });
    }

    if (r.end_date) {
      const end = new Date(`${r.end_date}T00:00:00`);
      const days = Math.ceil((end.getTime() - now.getTime()) / 86400000);
      if (days <= 30) {
        reminders.push({
          kind: "expires",
          template: r,
          text: `Expires soon: ${r.title} (${Math.max(days, 0)} days)`
        });
      }
    }

    const start = new Date(`${r.start_date}T00:00:00`);
    const nextReview = new Date(start);
    while (nextReview.getTime() < now.getTime()) nextReview.setUTCFullYear(nextReview.getUTCFullYear() + 1);
    const reviewDays = Number(r.review_days_before || 30);
    const daysToReview = Math.ceil((nextReview.getTime() - now.getTime()) / 86400000);
    if (daysToReview <= reviewDays) {
      reminders.push({
        kind: "review",
        template: r,
        text: `Annual review due: ${r.title} (${Math.max(daysToReview, 0)} days)`
      });
    }
  }

  if (!reminders.length) {
    target.textContent = "No reminders right now.";
    return;
  }
  target.innerHTML = reminders
    .slice(0, 20)
    .map(
      (r, idx) => `<div style="display:flex; justify-content:space-between; gap:10px; padding:6px 0; border-bottom:1px solid #e5e7eb">
        <span>${escapeHtml(r.text)}</span>
        <span style="display:flex; gap:6px">
          <button type="button" data-action="pause-from-reminder" data-template-id="${r.template.id}">Pause</button>
          <button type="button" data-action="extend-reminder" data-template-id="${r.template.id}">+30 days</button>
        </span>
      </div>`
    )
    .join("");

  target.querySelectorAll("button[data-action='pause-from-reminder']").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const templateId = btn.getAttribute("data-template-id");
      const template = (data || []).find((x) => x.id === templateId);
      if (!template) return;
      const { error } = await state.supabase
        .schema("finance_app")
        .from("recurring_templates")
        .update({ status: "paused" })
        .eq("id", template.id);
      if (error) {
        showToast(`Pause failed: ${formatError(error)}`);
        return;
      }
      showToast(`Paused ${template.title}.`);
      await renderRecurringSection();
      await renderRemindersSection();
    });
  });

  target.querySelectorAll("button[data-action='extend-reminder']").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const templateId = btn.getAttribute("data-template-id");
      const template = (data || []).find((x) => x.id === templateId);
      if (!template) return;
      const base = template.end_date ? new Date(`${template.end_date}T00:00:00`) : new Date();
      base.setUTCDate(base.getUTCDate() + 30);
      const next = base.toISOString().slice(0, 10);
      const { error } = await state.supabase
        .schema("finance_app")
        .from("recurring_templates")
        .update({ end_date: next })
        .eq("id", template.id);
      if (error) {
        showToast(`Extend failed: ${formatError(error)}`);
        return;
      }
      showToast(`Extended ${template.title} to ${next}.`);
      await renderRecurringSection();
      await renderRemindersSection();
    });
  });
}

async function renderSummaryStats(payments, balanceContext) {
  void payments;

  const owesSummary = document.getElementById("stat-owes-summary");
  if (!owesSummary) return;

  let suggestions = balanceContext?.suggestions || [];
  try {
    const { data, error } = await state.supabase.schema("finance_app").rpc("get_household_balances", {
      p_household_id: state.householdId
    });
    if (error) throw error;
    const rows = (data || []).map((r) => ({
      name: r.display_name || memberNameByUserId(r.user_id),
      net: Number(r.net || 0)
    }));
    const live = buildSettlementSuggestions(rows);
    if (live.length) suggestions = live;
  } catch (error) {
    console.error("Who-owes summary refresh failed:", error);
  }

  if (!suggestions.length) {
    owesSummary.textContent = "All square. No settlements needed.";
    return;
  }
  owesSummary.innerHTML = suggestions
    .slice(0, 3)
    .map((s) => `<div>${escapeHtml(s.from)} -> ${escapeHtml(s.to)}: <strong>${formatGbp(s.amount)}</strong></div>`)
    .join("");
}

async function renderSyncLogs() {
  const target = document.getElementById("sync-log-list");
  if (!target) return;
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_generation_log")
    .select("id, due_date, status, error_text, created_at, recurring_template_id")
    .order("created_at", { ascending: false })
    .limit(20);
  if (error) {
    target.textContent = `Failed to load sync logs: ${formatError(error)}`;
    return;
  }
  const rows = data || [];
  if (!rows.length) {
    target.textContent = "No sync logs yet.";
    return;
  }
  target.innerHTML = rows
    .map((r) => {
      const ts = new Date(r.created_at).toLocaleString("en-GB");
      const errorText = r.error_text ? ` - ${escapeHtml(r.error_text)}` : "";
      return `<div style="padding:4px 0; border-bottom:1px solid #e5e7eb">
        <strong>${escapeHtml(r.status)}</strong> template=${escapeHtml(r.recurring_template_id)} due=${escapeHtml(r.due_date)} at ${escapeHtml(ts)}${errorText}
      </div>`;
    })
    .join("");
}

async function renderInsights() {
  const target = document.getElementById("insights-list");
  if (!target) return;

  const { data: allPayments, error: paymentsError } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("id, title, amount_gbp, category_key, source_type")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .order("payment_date", { ascending: false })
    .limit(20000);
  if (paymentsError) {
    target.textContent = `Failed to load insights: ${formatError(paymentsError)}`;
    return;
  }

  const payments = allPayments || [];
  if (!payments.length) {
    target.textContent = "No insights yet.";
    return;
  }

  const paymentIdSet = new Set(payments.map((p) => p.id));
  const { data: allContrib, error: contribError } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .select("payment_id, user_id, amount")
    .limit(30000);
  if (contribError) {
    target.textContent = `Failed to load insights: ${formatError(contribError)}`;
    return;
  }
  const contrib = (allContrib || []).filter((c) => paymentIdSet.has(c.payment_id));

  const totalsByUser = new Map();
  for (const c of contrib) {
    totalsByUser.set(c.user_id, (totalsByUser.get(c.user_id) || 0) + Number(c.amount || 0));
  }
  const totalsRows = Array.from(totalsByUser.entries())
    .map(([userId, total]) => ({ name: memberNameByUserId(userId), total }))
    .sort((a, b) => b.total - a.total);

  const nonSettlement = payments.filter((p) => p.source_type !== "settlement");
  const biggest = nonSettlement
    .slice()
    .sort((a, b) => Number(b.amount_gbp || 0) - Number(a.amount_gbp || 0))[0];

  const freq = new Map();
  for (const p of nonSettlement) {
    const key = (p.title || "").trim().toLowerCase();
    if (!key) continue;
    const current = freq.get(key) || { title: p.title, count: 0, total: 0 };
    current.count += 1;
    current.total += Number(p.amount_gbp || 0);
    freq.set(key, current);
  }
  const frequentRows = Array.from(freq.values())
    .sort((a, b) => b.count - a.count || b.total - a.total)
    .slice(0, 5);

  const totalsHtml = totalsRows.length
    ? totalsRows
        .map((r) => `<div style="display:flex; justify-content:space-between"><span>${escapeHtml(r.name)}</span><strong>${formatGbp(r.total)}</strong></div>`)
        .join("")
    : "<div>No contributor totals yet.</div>";

  const biggestHtml = biggest
    ? `<div>${escapeHtml(biggest.title)} <strong>${formatGbp(biggest.amount_gbp)}</strong> <span style="color:#6b7280">(${escapeHtml(biggest.category_key || "other")})</span></div>`
    : "<div>No spend records yet.</div>";

  const frequentHtml = frequentRows.length
    ? frequentRows
        .map((r) => `<div style="display:flex; justify-content:space-between"><span>${escapeHtml(r.title)} (${r.count})</span><strong>${formatGbp(r.total)}</strong></div>`)
        .join("")
    : "<div>No recurring spend patterns yet.</div>";

  target.innerHTML = `
    <div style="display:grid; gap:12px">
      <div>
        <h3 style="margin:0 0 6px 0">Total Paid By</h3>
        ${totalsHtml}
      </div>
      <div>
        <h3 style="margin:0 0 6px 0">Biggest Spend</h3>
        ${biggestHtml}
      </div>
      <div>
        <h3 style="margin:0 0 6px 0">Most Frequent Spends</h3>
        ${frequentHtml}
      </div>
    </div>
  `;
}

function toIsoDateOrNull(rawValue) {
  if (!rawValue) return null;
  return rawValue;
}

function parsePositiveAmount(value, fieldName) {
  const parsed = Number(value);
  if (!Number.isFinite(parsed) || parsed <= 0) {
    throw new Error(`${fieldName} must be greater than 0`);
  }
  return parsed;
}

async function savePaymentFromForm(form) {
  if (!state.currentUser || !state.householdId) {
    throw new Error("You must be signed in.");
  }

  const formData = new FormData(form);
  const title = String(formData.get("title") || "").trim();
  const amount = parsePositiveAmount(formData.get("amount"), "Amount");
  const currencyCode = String(formData.get("currency_code") || "GBP").toUpperCase();
  const paymentDate = String(formData.get("payment_date") || "");
  const categoryKey = String(formData.get("category_key") || "").trim() || null;
  const notes = String(formData.get("notes") || "").trim() || null;
  const isRecurring = formData.get("is_recurring") === "on";
  const fxRateRaw = formData.get("fx_rate_to_gbp");
  const fxRateToGbp = currencyCode === "GBP" ? 1 : Number(fxRateRaw || 0);
  const fxRateDate = String(formData.get("fx_rate_date") || "") || new Date().toISOString().slice(0, 10);

  if (!title) throw new Error("Title is required");
  if (!paymentDate) throw new Error("Payment date is required");
  if (currencyCode !== "GBP" && (!Number.isFinite(fxRateToGbp) || fxRateToGbp <= 0)) {
    throw new Error("FX rate to GBP is required for non-GBP payments");
  }

  const amountGbp = Number((amount * fxRateToGbp).toFixed(2));
  const sourceType = "one_off";
  const paidByRows = getPaidByAllocations(amount);
  const splitRowsComputed = buildSplitRows(amount, paidByRows);

  let paymentId = state.editingPaymentId;
  if (paymentId) {
    const { error: updateError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .update({
        title,
        amount,
        currency_code: currencyCode,
        fx_rate_to_gbp: fxRateToGbp,
        fx_rate_date: fxRateDate,
        amount_gbp: amountGbp,
        payment_date: paymentDate,
        category_key: categoryKey,
        notes
      })
      .eq("id", paymentId);
    if (updateError) throw updateError;

    const { error: delContribErr } = await state.supabase.schema("finance_app").from("payment_contributions").delete().eq("payment_id", paymentId);
    if (delContribErr) throw delContribErr;
    const { error: delSplitsErr } = await state.supabase.schema("finance_app").from("payment_splits").delete().eq("payment_id", paymentId);
    if (delSplitsErr) throw delSplitsErr;
    const { error: insContribErr } = await state.supabase
      .schema("finance_app")
      .from("payment_contributions")
      .insert(paidByRows.map((r) => ({ payment_id: paymentId, user_id: r.user_id, amount: r.amount })));
    if (insContribErr) throw insContribErr;
    const { error: insSplitsErr } = await state.supabase
      .schema("finance_app")
      .from("payment_splits")
      .insert(splitRowsComputed.map((r) => ({ payment_id: paymentId, user_id: r.user_id, amount: r.amount })));
    if (insSplitsErr) throw insSplitsErr;
  } else {
    const { data: payment, error: paymentError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .insert(
        {
          household_id: state.householdId,
          title,
          amount,
          currency_code: currencyCode,
          fx_rate_to_gbp: fxRateToGbp,
          fx_rate_date: fxRateDate,
          amount_gbp: amountGbp,
          payment_date: paymentDate,
          category_key: categoryKey,
          notes,
          source_type: sourceType,
          created_by: state.currentUser.id
        }
      )
      .select("id")
      .single();
    if (paymentError) throw paymentError;

    paymentId = payment.id;
    const contributionRows = paidByRows.map((r) => ({ payment_id: paymentId, user_id: r.user_id, amount: r.amount }));
    const splitRows = splitRowsComputed.map((r) => ({ payment_id: paymentId, user_id: r.user_id, amount: r.amount }));

    const { error: contributionsError } = await state.supabase
      .schema("finance_app")
      .from("payment_contributions")
      .insert(contributionRows);
    if (contributionsError) throw contributionsError;

    const { error: splitsError } = await state.supabase
      .schema("finance_app")
      .from("payment_splits")
      .insert(splitRows);
    if (splitsError) throw splitsError;
  }

  if (!isRecurring || state.editingPaymentId) {
    await loadDashboardData();
    return;
  }

  const frequency = String(formData.get("frequency") || "monthly");
  const startDate = String(formData.get("start_date") || "") || paymentDate;
  const endDate = toIsoDateOrNull(String(formData.get("end_date") || ""));
  const reviewDaysBefore = 30;

  if (!["monthly", "annual"].includes(frequency)) {
    throw new Error("Recurring frequency must be monthly or annual");
  }

  const paymentDay = new Date(paymentDate).getUTCDate();
  const { data: template, error: templateError } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .insert(
      {
        household_id: state.householdId,
        title,
        amount,
        currency_code: currencyCode,
        category_key: categoryKey,
        notes,
        frequency,
        day_of_month: frequency === "monthly" ? paymentDay : null,
        start_date: startDate,
        end_date: endDate,
        review_days_before: reviewDaysBefore,
        status: "active",
        created_by: state.currentUser.id
      }
    )
    .select("id")
    .single();
  if (templateError) throw templateError;

  const recurringContributionRows = paidByRows.map((r) => ({
    recurring_template_id: template.id,
    user_id: r.user_id,
    mode: "percentage",
    value: r.pct
  }));
  const recurringSplitRowsRaw = splitRowsComputed.map((r) => ({
    user_id: r.user_id,
    pct: Number(((Number(r.amount || 0) / amount) * 100).toFixed(4))
  }));
  const splitTotalPct = recurringSplitRowsRaw.reduce((sum, r) => sum + r.pct, 0);
  const splitDelta = Number((100 - splitTotalPct).toFixed(4));
  if (Math.abs(splitDelta) > 0.0001 && recurringSplitRowsRaw.length) {
    recurringSplitRowsRaw[0].pct = Number((recurringSplitRowsRaw[0].pct + splitDelta).toFixed(4));
  }
  const recurringSplitRows = recurringSplitRowsRaw.map((r) => ({
    recurring_template_id: template.id,
    user_id: r.user_id,
    mode: "percentage",
    value: r.pct
  }));

  const { error: recurringContribError } = await state.supabase
    .schema("finance_app")
    .from("recurring_template_contributions")
    .insert(recurringContributionRows);
  if (recurringContribError) throw recurringContribError;

  const { error: recurringSplitError } = await state.supabase
    .schema("finance_app")
    .from("recurring_template_splits")
    .insert(recurringSplitRows);
  if (recurringSplitError) throw recurringSplitError;

  await loadDashboardData();
}

async function rebalancePaymentRows(paymentId, newAmount) {
  const { data: contribRows, error: cErr } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .select("id, amount")
    .eq("payment_id", paymentId)
    .order("amount", { ascending: false });
  if (cErr) throw cErr;

  const { data: splitRows, error: sErr } = await state.supabase
    .schema("finance_app")
    .from("payment_splits")
    .select("id, amount")
    .eq("payment_id", paymentId)
    .order("amount", { ascending: false });
  if (sErr) throw sErr;

  const contributionUpdates = proportionallyReassignAmounts(contribRows || [], Number(newAmount));
  const splitUpdates = proportionallyReassignAmounts(splitRows || [], Number(newAmount));

  for (const row of contributionUpdates) {
    const { error } = await state.supabase
      .schema("finance_app")
      .from("payment_contributions")
      .update({ amount: row.amount })
      .eq("id", row.id);
    if (error) throw error;
  }
  for (const row of splitUpdates) {
    const { error } = await state.supabase
      .schema("finance_app")
      .from("payment_splits")
      .update({ amount: row.amount })
      .eq("id", row.id);
    if (error) throw error;
  }
}

function proportionallyReassignAmounts(rows, total) {
  if (!rows.length) return [];
  const oldTotal = rows.reduce((sum, r) => sum + Number(r.amount || 0), 0);
  if (oldTotal <= 0) {
    const even = Number((total / rows.length).toFixed(2));
    let remainder = Number((total - even * rows.length).toFixed(2));
    return rows.map((r, idx) => {
      let amount = even;
      if (idx === 0) amount = Number((amount + remainder).toFixed(2));
      return { id: r.id, amount };
    });
  }
  const scaled = rows.map((r) => ({
    id: r.id,
    raw: (Number(r.amount || 0) / oldTotal) * total
  }));
  const rounded = scaled.map((r) => ({ id: r.id, amount: Number(r.raw.toFixed(2)) }));
  const roundedTotal = rounded.reduce((sum, r) => sum + r.amount, 0);
  const delta = Number((total - roundedTotal).toFixed(2));
  if (Math.abs(delta) >= 0.01 && rounded.length) {
    rounded[0].amount = Number((rounded[0].amount + delta).toFixed(2));
  }
  return rounded;
}

async function runStartupSummary() {
  const nowIso = new Date().toISOString();
  const lastOpenedAt = localStorage.getItem(STORAGE_KEYS.lastOpenedAt);

  if (!lastOpenedAt) {
    localStorage.setItem(STORAGE_KEYS.lastOpenedAt, nowIso);
    return;
  }

  const counts = await fetchSummaryCountsSince(lastOpenedAt);
  const parts = [];
  if (counts.oneOffCount > 0) parts.push(`${counts.oneOffCount} one-off payment${counts.oneOffCount === 1 ? "" : "s"} added`);
  if (counts.recurringCount > 0) parts.push(`${counts.recurringCount} recurring payment${counts.recurringCount === 1 ? "" : "s"} processed`);

  const windowKey = `${lastOpenedAt}->${nowIso}`;
  const alreadyShown = localStorage.getItem(STORAGE_KEYS.lastSummaryWindow) === windowKey;

  if (parts.length > 0 && !alreadyShown) {
    showToast(`Since last open: ${parts.join(", ")}.`);
    localStorage.setItem(STORAGE_KEYS.lastSummaryWindow, windowKey);
  }

  localStorage.setItem(STORAGE_KEYS.lastOpenedAt, nowIso);
}

async function bootstrap() {
  setupAccordion();
  setupModals();
  setSignInEnabled(false);

  const signInForm = document.getElementById("sign-in-form");
  signInForm?.addEventListener("submit", async (event) => {
    event.preventDefault();
    if (!state.supabase) {
      setAuthHelp("Supabase client is not ready. Check app config.");
      return;
    }
    const emailInput = document.getElementById("sign-in-email");
    const passwordInput = document.getElementById("sign-in-password");
    const email = String(emailInput?.value || "").trim();
    const password = String(passwordInput?.value || "");
    if (!email) {
      setAuthHelp("Enter an email address.");
      return;
    }
    if (!password) {
      setAuthHelp("Enter your password.");
      return;
    }
    const { error } = await state.supabase.auth.signInWithPassword({
      email,
      password
    });
    if (error) {
      setAuthHelp(`Sign-in failed: ${error.message}`);
      showToast(`Sign-in failed: ${error.message}`);
      return;
    }
    setAuthHelp("Sign-in successful.");
    showToast("Signed in.");
    window.location.reload();
  });

  const magicLinkButton = document.getElementById("send-magic-link-btn");
  magicLinkButton?.addEventListener("click", async () => {
    if (!state.supabase) {
      setAuthHelp("Supabase client is not ready. Check app config.");
      return;
    }
    const emailInput = document.getElementById("sign-in-email");
    const email = String(emailInput?.value || "").trim();
    if (!email) {
      setAuthHelp("Enter your email first, then click magic link.");
      return;
    }
    const { error } = await state.supabase.auth.signInWithOtp({
      email,
      options: { emailRedirectTo: window.location.href }
    });
    if (error) {
      setAuthHelp(`Magic link failed: ${error.message}`);
      showToast(`Magic link failed: ${error.message}`);
      return;
    }
    setAuthHelp("Magic link sent. Check your inbox.");
    showToast("Magic link sent.");
  });

  document.getElementById("load-more-payments")?.addEventListener("click", async () => {
    try {
      const more = await fetchPaymentsPage({ reset: false });
      const list = document.getElementById("payments-list");
      if (!more.length) {
        state.paymentsHasMore = false;
        updateLoadMoreButton();
        return;
      }
      const existingRows = Array.from(list.querySelectorAll("tbody tr")).map((tr) => tr.outerHTML).join("");
      const payerLabels = await buildPayerLabels(more);
      const newRows = more
        .map((p) => {
          const payer = payerLabels?.get(p.id) || memberNameByUserId(p.created_by);
          return `<tr>
            <td>${toDateLabel(p.payment_date)}</td>
            <td>${escapeHtml(p.title)}</td>
            <td>${escapeHtml(p.category_key || "-")}</td>
            <td>${escapeHtml(p.source_type)}</td>
            <td>${escapeHtml(payer)}</td>
            <td style="text-align:right">${formatGbp(p.amount_gbp)}</td>
          </tr>`;
        })
        .join("");
      if (existingRows) {
        list.innerHTML = `
          <div style="overflow:auto">
            <table style="width:100%; border-collapse:collapse">
              <thead>
                <tr>
                  <th style="text-align:left">Date</th>
                  <th style="text-align:left">Title</th>
                  <th style="text-align:left">Category</th>
                  <th style="text-align:left">Type</th>
                  <th style="text-align:left">Payer</th>
                  <th style="text-align:right">Amount (GBP)</th>
                </tr>
              </thead>
              <tbody>${existingRows}${newRows}</tbody>
            </table>
          </div>
        `;
      }
      updateLoadMoreButton();
    } catch (error) {
      console.error(error);
      showToast(`Failed to load more payments: ${formatError(error)}`);
    }
  });

  if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
    showToast("Set FINANCE_CONFIG.supabaseUrl and FINANCE_CONFIG.supabaseAnonKey in index.html.");
    setAuthHelp("Missing Supabase configuration in index.html.");
    setAuthedUI(false);
    return;
  }

  try {
    let createClient;
    try {
      ({ createClient } = await import("https://esm.sh/@supabase/supabase-js@2"));
    } catch {
      ({ createClient } = await import("https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm"));
    }
    state.supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
    setSignInEnabled(true);
    setAuthHelp("");
  } catch (error) {
    console.error(error);
    setAuthHelp(`Could not load Supabase client: ${formatError(error)}`);
    showToast("Could not load Supabase client.");
    setAuthedUI(false);
    return;
  }

  const session = await loadSession();
  if (!session?.user) {
    setAuthedUI(false);
    return;
  }

  state.currentUser = session.user;
  await ensureHouseholdContext();
  await loadMembers();
  await loadCategoryOptions();
  renderPaidByRows();
  updatePaymentNetEffectPreview();
  state.categoryManuallySet = false;
  setAuthedUI(true);

  const result = await processRecurringPayments();
  state.syncResult = result;
  localStorage.setItem(STORAGE_KEYS.lastSyncResult, JSON.stringify(result));
  document.getElementById("sync-status").textContent = syncResultLabel(result);

  if (result.generated > 0 || result.failed > 0) {
    showToast(`Recurring sync complete: ${result.generated} added, ${result.failed} failed.`);
  }

  await loadDashboardData();
  await runStartupSummary();
}

bootstrap().catch((error) => {
  console.error(error);
  const msg = formatError(error);
  setAuthHelp(`App startup failed: ${msg}`);
  showToast(`App startup failed: ${msg}`);
});
