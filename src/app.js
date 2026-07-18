const STORAGE_KEYS = {
  lastOpenedAt: "finance.lastOpenedAt",
  lastSummaryWindow: "finance.lastSummaryShownForWindow",
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
  paymentsHasMore: false,
  latestSettlementDate: null,
  showSettledItems: false,
  paymentsCursorPaymentDate: null,
  paymentsCursorCreatedAt: null,
  loadedPayments: [],
  lastHypotheticalRows: [],
  lastPayerLabels: new Map(),
  lastPaymentDetails: new Map(),
  editingPaymentId: null,
  editingPaymentMeta: null,
  titleCategoryIndex: [],
  categoryManuallySet: false,
  splitMode: "preset_you_equal",
  advancedOwesMode: "percentage",
  editingTemplateId: null,
  editingTemplateBefore: null,
  owesMessageKey: null,
  owesMessageText: null,
  dashboardRefreshInFlight: false,
  dashboardRefreshQueued: false,
  debouncedNetEffectUpdate: null
};

const GBP_FORMAT = new Intl.NumberFormat("en-GB", {
  style: "currency",
  currency: "GBP"
});
const NO_OUTSTANDING_MESSAGES = [
  "No balances due. The Manatees are floating on a watertight budget and calm waters.",
  "All square. Manatee Towers is debt-free, buoyant, and running on an even keel.",
  "No one owes a penny. The manatees are cruising in smooth fiscal waters with a watertight budget.",
  "Outstanding balance: £0. The manatees are financially streamlined and steady as she goes.",
  "Nothing to settle. Manatee finances are shipshape, tidy, and running like a well-trimmed sail.",
  "No commitments outstanding. The manatees are in full fiscal harmony from seabed to surface.",
  "Everything's settled. The pod is on an even keel with no loose ends to tie off.",
  "No debts on deck. The manatees are gliding with a watertight plan and a steady course.",
  "All clear. The household books are shipshape and calm as a glassy bay.",
  "No balances pending. The manatees are cruising smoothly with every pound accounted for."
];
const SMALL_OUTSTANDING_MESSAGES = [
  "Minor wake only: the manatee books are nearly level, just a pocket ripple to settle.",
  "Small trim needed: this is a light manatee imbalance in otherwise calm waters.",
  "A tiny drift off even keel: the pod only needs a quick nudge to rebalance.",
  "Brief Budget-note moment: a small adjustment and the manatee ledger is tidy again.",
  "Harbour-level wobble: this is a small financial ripple, not a storm.",
  "Teacup tide only: the manatees are nearly square with just a tiny nudge left.",
  "Gentle ripple in the ledger: a small settle and we're back on even keel.",
  "Low-draft imbalance: this one barely lifts the harbour markers.",
  "A penny-level wobble: the pod is almost perfectly trimmed.",
  "Shallow-water drift: small imbalance, quick correction."
];
const MEDIUM_OUTSTANDING_MESSAGES = [
  "Mid-tide mismatch: the manatee finances need a proper but manageable correction.",
  "Noticeable list to port: a medium ledger swell is running through the pod.",
  "Chancellor-briefing territory: the books are stable, but this medium gap needs action.",
  "A steady cross-current: medium imbalance detected across Manatee Towers.",
  "Not rough seas, but whitecaps: medium financial drift to settle up.",
  "Mid-channel sway: the manatee books need a tidy medium rebalance.",
  "Noticeable chop on the balance sheet: manageable, but worth settling now.",
  "Half-mast warning: medium mismatch across the pod accounts.",
  "Fiscal crosswind ahead: medium adjustment required to hold course.",
  "A proper roll in the hull: not severe, but definitely settlement weather."
];
const LARGE_OUTSTANDING_MESSAGES = [
  "Heavy swell on the ledger: this large manatee gap needs a decisive settle-up run.",
  "Decks are tilting: a large imbalance is pushing the pod off course.",
  "Red box moment: this is a substantial budget wave in manatee waters.",
  "Strong headwind in the harbour accounts: large mismatch, time to rebalance.",
  "Big wake behind this one: the pod should correct this large gap soon.",
  "Heavy seas on this leg: large imbalance needs a firm correction.",
  "The ledger is listing: substantial gap, settle-up recommended promptly.",
  "Full-crew manoeuvre: this is a big wake in manatee finances.",
  "Strong current through the accounts: large mismatch pushing us off line.",
  "Budget barometer rising: this one's a chunky rebalancing job."
];
const CRISIS_OUTSTANDING_MESSAGES = [
  "Manatee fiscal storm warning: this is full-blown imbalance weather.",
  "Code Coral Red: the pod has entered exaggerated financial-crisis seas.",
  "All hands on deck: this ledger gap is a major manatee money squall.",
  "Treasury panic buoy deployed: crisis-level mismatch across the lagoon books.",
  "Sirens over the marina: this is a top-tier manatee budget emergency.",
  "Manatee market panic: crisis-grade imbalance, immediate action stations.",
  "Ledger hurricane warning: this is deep-red settlement territory.",
  "All buoys flashing: major fiscal squall across the pod.",
  "Treasury distress signal received: top-level imbalance emergency.",
  "Catastrophic wake event: this is a full manatee money crisis."
];

function showToast(message) {
  const toast = document.getElementById("toast");
  const openDialog = document.querySelector("dialog[open]");
  if (openDialog) {
    let dialogToast = openDialog.querySelector(".dialog-toast");
    if (!dialogToast) {
      dialogToast = document.createElement("div");
      dialogToast.className = "dialog-toast";
      openDialog.appendChild(dialogToast);
    }
    dialogToast.textContent = message;
    dialogToast.classList.remove("hidden");
    window.setTimeout(() => dialogToast.classList.add("hidden"), 5000);
    return;
  }
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

function debounce(fn, waitMs = 120) {
  let t = null;
  return (...args) => {
    if (t) window.clearTimeout(t);
    t = window.setTimeout(() => {
      t = null;
      fn(...args);
    }, waitMs);
  };
}

function scheduleDashboardRefresh() {
  if (state.dashboardRefreshInFlight) {
    state.dashboardRefreshQueued = true;
    return;
  }
  state.dashboardRefreshInFlight = true;
  Promise.resolve()
    .then(async () => {
      do {
        state.dashboardRefreshQueued = false;
        await loadDashboardData();
      } while (state.dashboardRefreshQueued);
    })
    .catch((error) => {
      console.error("Background dashboard refresh failed:", error);
      showToast(`Refresh failed: ${formatError(error)}`);
    })
    .finally(() => {
      state.dashboardRefreshInFlight = false;
    });
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

function toDisplayFirstName(nameLike) {
  const raw = String(nameLike || "").trim();
  if (!raw) return "Unknown";
  if (raw.includes("@")) {
    const local = raw.split("@")[0].trim();
    if (!local) return "Unknown";
    const token = local.split(/[.\-_+\s]+/).filter(Boolean)[0] || local;
    return token.charAt(0).toUpperCase() + token.slice(1);
  }
  return raw.split(/\s+/).filter(Boolean)[0] || "Unknown";
}

function randomNoOutstandingMessage() {
  const idx = Math.floor(Math.random() * NO_OUTSTANDING_MESSAGES.length);
  return NO_OUTSTANDING_MESSAGES[idx] || "All square. No settlements needed.";
}

function randomOutstandingMessage(maxSettlementAmount) {
  const amount = Number(maxSettlementAmount || 0);
  let pool = CRISIS_OUTSTANDING_MESSAGES;
  if (amount < 100) pool = SMALL_OUTSTANDING_MESSAGES;
  else if (amount < 500) pool = MEDIUM_OUTSTANDING_MESSAGES;
  else if (amount < 1000) pool = LARGE_OUTSTANDING_MESSAGES;
  const idx = Math.floor(Math.random() * pool.length);
  return pool[idx] || "Outstanding balance detected. Settle-up recommended.";
}

function setSettleUpEnabled(enabled) {
  const btn = document.getElementById("open-settlement");
  if (!btn) return;
  btn.disabled = !enabled;
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
    const label = toggle.textContent || "";
    toggle.innerHTML = `<span>${escapeHtml(label)}</span><span class="accordion-indicator" aria-hidden="true">▾</span>`;
    const saved = localStorage.getItem(`finance.section.${key}`);
    const open = saved === null ? index === 0 : saved === "open";
    content.classList.toggle("hidden", !open);
    toggle.classList.toggle("is-open", open);
    toggle.addEventListener("click", () => {
      const nowOpen = content.classList.contains("hidden");
      content.classList.toggle("hidden", !nowOpen);
      toggle.classList.toggle("is-open", nowOpen);
      localStorage.setItem(`finance.section.${key}`, nowOpen ? "open" : "closed");
    });
  });
}

function setupModals() {
  const paymentModal = document.getElementById("payment-modal");
  const settingsModal = document.getElementById("settings-modal");
  const settlementModal = document.getElementById("settlement-modal");
  const recurringTemplateModal = document.getElementById("recurring-template-modal");
  document.getElementById("add-payment").addEventListener("click", () => {
    if (!state.editingPaymentId) {
      setDefaultPaymentDateIfEmpty();
      setDefaultSplitPreset();
      state.editingPaymentMeta = null;
    }
    paymentModal.showModal();
  });
  document.getElementById("open-settings")?.addEventListener("click", () => settingsModal.showModal());
  document.getElementById("open-settings")?.addEventListener("click", async () => {
    await renderSyncLogs();
  });
  document.getElementById("open-settlement")?.addEventListener("click", () => {
    openSettlementModal();
  });

  const recurringToggleInputs = Array.from(document.querySelectorAll("#payment-form input[name='payment_kind']"));
  const recurringFields = document.getElementById("recurring-fields");
  const currencySelect = document.querySelector("#payment-form select[name='currency_code']");
  const titleInput = document.querySelector("#payment-form input[name='title']");
  const amountInput = document.querySelector("#payment-form input[name='amount']");
  const debouncedNetEffectUpdate = debounce(() => updatePaymentNetEffectPreview(), 120);
  const debouncedCategoryInfer = debounce(() => maybeAutofillCategoryFromTitle(), 180);
  state.debouncedNetEffectUpdate = debouncedNetEffectUpdate;
  const categorySelect = document.getElementById("category-select");
  const quickDateButtons = document.querySelectorAll("[data-quick-date]");
  const advancedOwesMode = document.getElementById("advanced-owes-mode");
  const syncRecurringFieldsVisibility = () => {
    const kind = document.querySelector("#payment-form input[name='payment_kind']:checked")?.value || "one_off";
    const isRecurring = kind === "recurring";
    recurringFields.classList.toggle("hidden", !isRecurring);
    if (isRecurring && !state.editingPaymentId) setDefaultRecurringDates();
  };
  recurringToggleInputs.forEach((input) => input.addEventListener("change", syncRecurringFieldsVisibility));
  const fxRateDateInput = document.querySelector("#payment-form input[name='fx_rate_date']");
  const paymentDateInput = document.querySelector("#payment-form input[name='payment_date']");
  currencySelect?.addEventListener("change", () => {
    toggleFxFields(currencySelect.value);
    if (currencySelect.value.toUpperCase() === "GBP") return;
    if (fxRateDateInput && !fxRateDateInput.value) {
      fxRateDateInput.value = paymentDateInput?.value || localTodayIsoDate();
    }
    autoFillFxRate();
  });
  fxRateDateInput?.addEventListener("change", () => autoFillFxRate());
  document.getElementById("fx-rate-refresh")?.addEventListener("click", () => autoFillFxRate());
  categorySelect?.addEventListener("change", () => {
    state.categoryManuallySet = true;
  });
  titleInput?.addEventListener("blur", () => {
    maybeAutofillCategoryFromTitle();
  });
  titleInput?.addEventListener("input", () => {
    debouncedCategoryInfer();
  });
  amountInput?.addEventListener("input", () => {
    debouncedNetEffectUpdate();
  });
  advancedOwesMode?.addEventListener("change", () => {
    state.advancedOwesMode = advancedOwesMode.value || "percentage";
    renderSplitRows();
    updateSplitValidationBanner(false);
    updatePaymentNetEffectPreview();
  });
  quickDateButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const form = document.getElementById("payment-form");
      if (!form) return;
      const today = localTodayUtc();
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
  toggleFxFields(currencySelect?.value || "GBP");
  syncRecurringFieldsVisibility();

  document.getElementById("payment-form").addEventListener("submit", async (event) => {
    event.preventDefault();
    const formEl = event.currentTarget;
    try {
      const mutation = await savePaymentFromForm(formEl);
      showToast(state.editingPaymentId ? "Payment updated." : "Payment saved.");
      if (mutation) applyOptimisticPaymentMutation(mutation);
      paymentModal.close();
      formEl?.reset();
      const oneOffRadio = document.querySelector("#payment-form input[name='payment_kind'][value='one_off']");
      if (oneOffRadio) oneOffRadio.checked = true;
      syncRecurringFieldsVisibility();
      document.getElementById("recurring-fields").classList.add("hidden");
      toggleFxFields("GBP");
      const fxStatusAfterSave = document.getElementById("fx-rate-status");
      if (fxStatusAfterSave) fxStatusAfterSave.textContent = "";
      state.editingPaymentId = null;
      state.editingPaymentMeta = null;
      state.categoryManuallySet = false;
      state.splitMode = "preset_you_equal";
      document.querySelector("#payment-modal h3").textContent = "Add Payment";
      setDefaultPaymentDateIfEmpty();
      setDefaultSplitPreset();
      updatePaymentNetEffectPreview();
      scheduleDashboardRefresh();
    } catch (error) {
      console.error(error);
      showToast(`Failed to save payment: ${error.message}`);
    }
  });

  document.getElementById("cancel-payment")?.addEventListener("click", () => {
    const form = document.getElementById("payment-form");
    form?.reset();
    const oneOffRadio = document.querySelector("#payment-form input[name='payment_kind'][value='one_off']");
    if (oneOffRadio) oneOffRadio.checked = true;
    syncRecurringFieldsVisibility();
    document.getElementById("recurring-fields")?.classList.add("hidden");
    toggleFxFields("GBP");
    const fxStatusAfterCancel = document.getElementById("fx-rate-status");
    if (fxStatusAfterCancel) fxStatusAfterCancel.textContent = "";
    state.editingPaymentId = null;
    state.editingPaymentMeta = null;
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
    scheduleDashboardRefresh();
  });

  document.getElementById("settlement-form")?.addEventListener("submit", async (event) => {
    event.preventDefault();
    const form = event.currentTarget;
    try {
      await saveSettlementFromForm(form);
      settlementModal?.close();
      form.reset();
      showToast("Settlement recorded.");
      scheduleDashboardRefresh();
    } catch (error) {
      console.error(error);
      showToast(`Failed to save settlement: ${formatError(error)}`);
    }
  });
  document.getElementById("cancel-settlement")?.addEventListener("click", () => {
    const form = document.getElementById("settlement-form");
    form?.reset();
    settlementModal?.close();
  });
  document.getElementById("settlement-form")?.from_user_id?.addEventListener("change", () => updateSettlementDirectionPreview());
  document.getElementById("settlement-form")?.to_user_id?.addEventListener("change", () => updateSettlementDirectionPreview());
  document.getElementById("settlement-form")?.amount?.addEventListener("input", () => updateSettlementSaveState());
  document.getElementById("reverse-settlement-direction")?.addEventListener("click", () => {
    const form = document.getElementById("settlement-form");
    if (!form) return;
    const from = String(form.from_user_id.value || "");
    const to = String(form.to_user_id.value || "");
    form.from_user_id.value = to;
    form.to_user_id.value = from;
    updateSettlementDirectionPreview();
    updateSettlementSaveState();
  });

  document.getElementById("recurring-template-form")?.addEventListener("submit", async (event) => {
    event.preventDefault();
    const form = event.currentTarget;
    try {
      await saveRecurringTemplateFromForm(form);
      recurringTemplateModal?.close();
      showToast("Recurring payment updated.");
      scheduleDashboardRefresh();
    } catch (error) {
      console.error(error);
      showToast(`Failed to update recurring payment: ${formatError(error)}`);
    }
  });
  document.getElementById("cancel-recurring-template")?.addEventListener("click", () => {
    recurringTemplateModal?.close();
  });
  document.querySelectorAll(".modal-close-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      const key = btn.getAttribute("data-close-dialog");
      if (key === "payment") {
        document.getElementById("cancel-payment")?.click();
        return;
      }
      if (key === "settlement") {
        document.getElementById("cancel-settlement")?.click();
        return;
      }
      if (key === "recurring-template") {
        document.getElementById("cancel-recurring-template")?.click();
        return;
      }
      if (key === "settings") {
        settingsModal?.close();
      }
    });
  });
  const recurringTemplateForm = document.getElementById("recurring-template-form");
  recurringTemplateForm?.querySelectorAll("input, select").forEach((el) => {
    el.addEventListener("change", () => renderRecurringImpactPreview());
    el.addEventListener("input", () => renderRecurringImpactPreview());
  });
}

function computeNextDueDateForTemplate(template, now = new Date()) {
  if (!template?.start_date) return null;
  const start = new Date(`${template.start_date}T00:00:00Z`);
  if (Number.isNaN(start.getTime())) return null;
  const end = template.end_date ? new Date(`${template.end_date}T00:00:00Z`) : null;
  const todayUtc = new Date(Date.UTC(now.getFullYear(), now.getMonth(), now.getDate()));
  if (end && end < todayUtc) return null;

  if (template.frequency === "annual") {
    const month = start.getUTCMonth();
    const day = start.getUTCDate();
    let due = new Date(Date.UTC(todayUtc.getUTCFullYear(), month, day));
    if (due < todayUtc) due = new Date(Date.UTC(todayUtc.getUTCFullYear() + 1, month, day));
    if (due < start) due = start;
    if (end && due > end) return null;
    return due.toISOString().slice(0, 10);
  }

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
  return due.toISOString().slice(0, 10);
}

function computeNextNDueDates(template, count = 5, now = new Date()) {
  const dates = [];
  if (!template?.start_date || template?.status !== "active" || count <= 0) return dates;
  const start = new Date(`${template.start_date}T00:00:00Z`);
  if (Number.isNaN(start.getTime())) return dates;
  const end = template.end_date ? new Date(`${template.end_date}T00:00:00Z`) : null;
  let cursorIso = computeNextDueDateForTemplate(template, now);
  if (!cursorIso) return dates;

  let guard = 0;
  while (dates.length < count && guard < 60 && cursorIso) {
    guard += 1;
    dates.push(cursorIso);
    const cursorDate = new Date(`${cursorIso}T00:00:00Z`);
    let nextDate = null;

    if (template.frequency === "annual") {
      nextDate = new Date(Date.UTC(cursorDate.getUTCFullYear() + 1, cursorDate.getUTCMonth(), cursorDate.getUTCDate()));
    } else {
      const day = Number(template.day_of_month || start.getUTCDate() || 1);
      let year = cursorDate.getUTCFullYear();
      let month = cursorDate.getUTCMonth() + 1;
      if (month > 11) {
        month = 0;
        year += 1;
      }
      const lastDay = new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
      nextDate = new Date(Date.UTC(year, month, Math.min(day, lastDay)));
    }

    if (!nextDate || Number.isNaN(nextDate.getTime())) break;
    if (nextDate < start) nextDate = start;
    if (end && nextDate > end) break;
    cursorIso = nextDate.toISOString().slice(0, 10);
    if (dates[dates.length - 1] === cursorIso) break;
  }
  return dates;
}

function renderRecurringImpactPreview() {
  const target = document.getElementById("recurring-impact");
  const nextDatesTarget = document.getElementById("recurring-next-dates");
  const form = document.getElementById("recurring-template-form");
  if (!target || !nextDatesTarget || !form || !state.editingTemplateBefore) return;
  const before = state.editingTemplateBefore;
  const after = {
    ...before,
    title: String(form.title.value || before.title || "").trim(),
    amount: Number(form.amount.value || before.amount || 0),
    frequency: String(form.frequency.value || before.frequency || "monthly"),
    start_date: String(form.start_date.value || before.start_date || ""),
    end_date: String(form.end_date.value || "") || null,
    status: String(form.status.value || before.status || "active")
  };
  after.day_of_month = after.frequency === "monthly" ? new Date(`${after.start_date}T00:00:00Z`).getUTCDate() : null;

  const nextBefore = computeNextDueDateForTemplate(before);
  const nextAfter = after.status === "active" ? computeNextDueDateForTemplate(after) : null;
  const amountBefore = Number(before.amount || 0);
  const amountAfter = Number(after.amount || 0);
  const amountChanged = Math.abs(amountAfter - amountBefore) > 0.009;
  const dateChanged = String(nextBefore || "") !== String(nextAfter || "");

  target.innerHTML = `
    <div style="font-weight:600; margin-bottom:6px">Impact on next scheduled payment</div>
    <div style="display:grid; gap:4px">
      <div>Next date: <strong>${nextBefore ? toDateLabel(nextBefore) : "None"}</strong> <span aria-hidden="true">→</span> <strong>${nextAfter ? toDateLabel(nextAfter) : "None"}</strong>${dateChanged ? ' <span style="color:var(--warn-text)">(changed)</span>' : ""}</div>
      <div>Amount: <strong>${formatGbp(amountBefore)}</strong> <span aria-hidden="true">→</span> <strong>${formatGbp(amountAfter)}</strong>${amountChanged ? ' <span style="color:var(--warn-text)">(changed)</span>' : ""}</div>
    </div>
  `;

  const nextFive = computeNextNDueDates(after, 5);
  if (after.status !== "active") {
    nextDatesTarget.innerHTML = `<div style="font-weight:600; margin-bottom:6px">Next 5 Scheduled Dates</div><div style="color:var(--muted)">Recurring payment is paused.</div>`;
    return;
  }
  if (!nextFive.length) {
    nextDatesTarget.innerHTML = `<div style="font-weight:600; margin-bottom:6px">Next 5 Scheduled Dates</div><div style="color:var(--muted)">No upcoming dates.</div>`;
    return;
  }
  nextDatesTarget.innerHTML = `
    <div style="font-weight:600; margin-bottom:6px">Next 5 Scheduled Dates</div>
    <div style="display:grid; gap:4px">
      ${nextFive.map((d) => `<div>${toDateLabel(d)}</div>`).join("")}
    </div>
  `;
}

async function openRecurringTemplateModal(templateId) {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, title, amount, frequency, day_of_month, start_date, end_date, status, category_key")
    .eq("id", templateId)
    .single();
  if (error) {
    showToast(`Failed to load recurring payment: ${formatError(error)}`);
    return;
  }
  const form = document.getElementById("recurring-template-form");
  if (!form) return;
  syncRecurringTemplateCategoryOptions();
  form.template_id.value = data.id;
  form.title.value = data.title || "";
  form.amount.value = data.amount || "";
  form.category_key.value = data.category_key || "other";
  form.frequency.value = data.frequency || "monthly";
  form.start_date.value = data.start_date || "";
  form.end_date.value = data.end_date || "";
  form.status.value = data.status || "active";
  state.editingTemplateId = data.id;
  state.editingTemplateBefore = { ...data };
  renderRecurringImpactPreview();
  document.getElementById("recurring-template-modal")?.showModal();
}

async function saveRecurringTemplateFromForm(form) {
  const templateId = String(form.template_id.value || state.editingTemplateId || "");
  if (!templateId) throw new Error("Missing template id.");
  const title = toTitleCaseText(form.title.value);
  const amount = parsePositiveAmount(form.amount.value, "Amount");
  const categoryKey = String(form.category_key.value || "").trim() || null;
  const frequency = String(form.frequency.value || "monthly");
  const startDate = String(form.start_date.value || "");
  const endDate = toIsoDateOrNull(String(form.end_date.value || ""));
  const status = String(form.status.value || "active");
  if (!title) throw new Error("Expense is required.");
  if (!startDate) throw new Error("Start date is required.");
  const dayOfMonth = frequency === "monthly" ? new Date(`${startDate}T00:00:00Z`).getUTCDate() : null;

  const { error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .update({
      title,
      amount,
      category_key: categoryKey,
      frequency,
      start_date: startDate,
      end_date: endDate,
      day_of_month: dayOfMonth,
      status
    })
    .eq("id", templateId);
  if (error) throw error;
}

async function maybePropagateRecurringTemplateFromPaymentEdit({ title, amount, categoryKey, notes, paymentDate }) {
  const meta = state.editingPaymentMeta;
  if (!meta?.recurring_template_id || meta.source_type !== "recurring_generated") return;

  const templateId = meta.recurring_template_id;
  const { data: template, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, title, amount, frequency, day_of_month, start_date, end_date, status, category_key, notes")
    .eq("id", templateId)
    .single();
  if (error) throw error;

  const beforeNext = template.status === "active" ? computeNextDueDateForTemplate(template) : null;
  const after = {
    ...template,
    title,
    amount,
    category_key: categoryKey,
    notes,
    day_of_month: template.frequency === "monthly" ? new Date(`${paymentDate}T00:00:00Z`).getUTCDate() : template.day_of_month
  };
  const afterNext = after.status === "active" ? computeNextDueDateForTemplate(after) : null;
  const impactText = `Next scheduled payment: ${beforeNext ? toDateLabel(beforeNext) : "None"} → ${afterNext ? toDateLabel(afterNext) : "None"} | Amount: ${formatGbp(template.amount)} → ${formatGbp(amount)}`;

  const ok = window.confirm(`Apply these edits to the recurring payment defaults as well?\n\n${impactText}`);
  if (!ok) return;

  const { error: updateError } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .update({
      title,
      amount,
      category_key: categoryKey,
      notes,
      day_of_month: after.day_of_month
    })
    .eq("id", templateId);
  if (updateError) throw updateError;
  showToast("Recurring payment defaults updated from payment edit.");
}

function toggleFxFields(currencyCode) {
  const show = String(currencyCode || "").toUpperCase() !== "GBP";
  document.getElementById("fx-rate-to-gbp-row")?.classList.toggle("hidden", !show);
  document.getElementById("fx-rate-date-row")?.classList.toggle("hidden", !show);
}

// Free, no-key, CORS-enabled ECB reference rates. Only covers major
// currencies and doesn't publish on weekends/bank holidays, so callers must
// treat failures as "fall back to manual entry", not an error.
async function fetchFxRateToGbp(currencyCode, dateIso) {
  const code = String(currencyCode || "").toUpperCase();
  if (!code || code === "GBP") return null;
  const requestDate = dateIso && dateIso <= localTodayIsoDate() ? dateIso : "latest";
  const url = `https://api.frankfurter.dev/v1/${requestDate}?base=${encodeURIComponent(code)}&symbols=GBP`;
  const response = await fetch(url);
  if (!response.ok) throw new Error(`FX service returned ${response.status}`);
  const payload = await response.json();
  const rate = Number(payload?.rates?.GBP);
  if (!Number.isFinite(rate) || rate <= 0) throw new Error(`No GBP rate available for ${code}`);
  return { rate, asOfDate: payload.date || requestDate };
}

async function autoFillFxRate() {
  const form = document.getElementById("payment-form");
  if (!form) return;
  const currencyCode = form.currency_code.value;
  if (!currencyCode || currencyCode.toUpperCase() === "GBP") return;
  const status = document.getElementById("fx-rate-status");
  const dateIso = form.fx_rate_date.value || form.payment_date.value || localTodayIsoDate();
  if (status) status.textContent = "Fetching rate…";
  try {
    const result = await fetchFxRateToGbp(currencyCode, dateIso);
    if (!result) return;
    form.fx_rate_to_gbp.value = result.rate.toFixed(8);
    if (status) {
      status.textContent =
        result.asOfDate === dateIso
          ? `Auto-filled from Frankfurter (ECB) for ${toDateLabel(result.asOfDate)}`
          : `Auto-filled from Frankfurter (ECB), nearest available rate: ${toDateLabel(result.asOfDate)}`;
    }
  } catch (error) {
    if (status) status.textContent = "Auto-fetch failed — enter rate manually.";
    console.error("FX auto-fetch failed:", error);
  }
}

function toIsoDate(date) {
  return date.toISOString().slice(0, 10);
}

// A UTC-midnight instant carrying the browser's LOCAL calendar date. Using
// this (instead of `new Date()`'s raw UTC getters) keeps "today" aligned with
// the user's actual day even when local time is ahead of UTC (e.g. BST),
// which otherwise makes due/generated dates land a day late.
function localTodayUtc() {
  const now = new Date();
  return new Date(Date.UTC(now.getFullYear(), now.getMonth(), now.getDate()));
}

function localTodayIsoDate() {
  return toIsoDate(localTodayUtc());
}

function isFutureDated(dateStr) {
  return Boolean(dateStr) && String(dateStr) > localTodayIsoDate();
}

function setDefaultPaymentDateIfEmpty() {
  const form = document.getElementById("payment-form");
  if (!form) return;
  if (!form.payment_date.value) {
    form.payment_date.value = localTodayIsoDate();
  }
}

function syncRecurringTemplateCategoryOptions() {
  const source = document.getElementById("category-select");
  const target = document.getElementById("recurring-template-category");
  if (!source || !target) return;
  target.innerHTML = source.innerHTML || `<option value="other">Other</option>`;
}

function setDefaultRecurringDates() {
  const form = document.getElementById("payment-form");
  if (!form) return;
  const today = localTodayUtc();
  const oneYearLater = new Date(today);
  oneYearLater.setUTCFullYear(oneYearLater.getUTCFullYear() + 1);

  if (!form.end_date.value) form.end_date.value = toIsoDate(oneYearLater);
}

function populateSettlementPartyOptions() {
  const form = document.getElementById("settlement-form");
  if (!form) return;
  const options = state.members
    .map((m) => `<option value="${escapeHtml(m.user_id)}">${escapeHtml(memberNameByUserId(m.user_id))}</option>`)
    .join("");
  form.from_user_id.innerHTML = options;
  form.to_user_id.innerHTML = options;
}

function updateSettlementDirectionPreview() {
  const form = document.getElementById("settlement-form");
  const preview = document.getElementById("settlement-direction-preview");
  if (!form || !preview) return;
  const fromId = String(form.from_user_id.value || "");
  const toId = String(form.to_user_id.value || "");
  const fromName = memberNameByUserId(fromId);
  const toName = memberNameByUserId(toId);
  preview.textContent = `${fromName} → ${toName}`;
}

function updateSettlementSaveState() {
  const form = document.getElementById("settlement-form");
  const saveBtn = document.getElementById("save-settlement");
  if (!form || !saveBtn) return;
  const fromId = String(form.from_user_id.value || "");
  const toId = String(form.to_user_id.value || "");
  const amount = Number(form.amount?.value || 0);
  const canSave = Boolean(fromId) && Boolean(toId) && fromId !== toId && Number.isFinite(amount) && amount > 0;
  saveBtn.disabled = !canSave;
}

async function getTopSettlementSuggestion() {
  const rows = await getHouseholdBalanceRows();
  const creditors = [];
  const debtors = [];
  for (const r of rows) {
    if (r.net > 0.009) creditors.push({ userId: r.userId, amount: Number(r.net.toFixed(2)) });
    if (r.net < -0.009) debtors.push({ userId: r.userId, amount: Number(Math.abs(r.net).toFixed(2)) });
  }
  creditors.sort((a, b) => b.amount - a.amount);
  debtors.sort((a, b) => b.amount - a.amount);
  if (!creditors.length || !debtors.length) return null;
  const from = debtors[0];
  const to = creditors[0];
  const amount = Number(Math.min(from.amount, to.amount).toFixed(2));
  if (amount <= 0) return null;
  const fromName = memberNameByUserId(from.userId);
  const toName = memberNameByUserId(to.userId);
  return {
    fromUserId: from.userId,
    toUserId: to.userId,
    amount,
    text: `${fromName} owes ${toName} ${formatGbp(amount)}`
  };
}

async function openSettlementModal(prefill = null) {
  const modal = document.getElementById("settlement-modal");
  const form = document.getElementById("settlement-form");
  if (!modal || !form) return;
  populateSettlementPartyOptions();
  form.payment_date.value = localTodayIsoDate();
  form.amount.value = "";
  if (form.notes) form.notes.value = "";
  const hint = document.getElementById("settlement-outstanding-hint");
  if (hint) hint.textContent = "";
  if (prefill) {
    form.from_user_id.value = prefill.fromUserId || "";
    form.to_user_id.value = prefill.toUserId || "";
    form.amount.value = Number(prefill.amount || 0).toFixed(2);
  } else if (state.members.length === 2 && state.currentUser?.id) {
    const other = getOtherMember();
    if (other) {
      form.from_user_id.value = state.currentUser.id;
      form.to_user_id.value = other.user_id;
    }
  } else if (!form.from_user_id.value || !form.to_user_id.value) {
    const [first, second] = state.members || [];
    if (first && second) {
      form.from_user_id.value = first.user_id;
      form.to_user_id.value = second.user_id;
    }
  }
  try {
    const suggested = await getTopSettlementSuggestion();
    if (suggested) {
      form.from_user_id.value = suggested.fromUserId;
      form.to_user_id.value = suggested.toUserId;
      form.amount.value = Number(suggested.amount || 0).toFixed(2);
      if (hint) hint.textContent = `Outstanding: ${suggested.text}`;
    }
  } catch (error) {
    console.error("Failed to prefill settlement suggestion:", error);
  }
  updateSettlementDirectionPreview();
  updateSettlementSaveState();
  modal.showModal();
}

function getOtherMember() {
  if (!state.currentUser?.id) return null;
  return state.members.find((m) => m.user_id !== state.currentUser.id) || null;
}

function applyPaidBySingleUser(userId) {
  const radio = document.querySelector(`[data-paid-by-user='${userId}']`);
  if (radio) radio.checked = true;
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
  const otherName = memberNameByUserId(other.user_id);
  target.innerHTML = `
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_you_equal" checked />
      <span class="split-preset-label"><span class="split-preset-title">You paid, split equally</span><span class="split-preset-sub">${escapeHtml(otherName)} owes half</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_you_full" />
      <span class="split-preset-label"><span class="split-preset-title">You paid, ${escapeHtml(otherName)} owes all</span><span class="split-preset-sub">${escapeHtml(me)} owes none</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_other_equal" />
      <span class="split-preset-label"><span class="split-preset-title">${escapeHtml(otherName)} paid, split equally</span><span class="split-preset-sub">You owe half</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="preset_other_full" />
      <span class="split-preset-label"><span class="split-preset-title">${escapeHtml(otherName)} paid, you owe all</span><span class="split-preset-sub">${escapeHtml(otherName)} owes none</span></span>
    </label>
    <label class="split-preset">
      <input type="radio" name="split_mode" value="custom" />
      <span class="split-preset-label"><span class="split-preset-title">More options</span><span class="split-preset-sub">Set custom owes split mode and values</span></span>
    </label>
  `;
  target.querySelectorAll("input[name='split_mode']").forEach((el) => {
    el.addEventListener("change", () => {
      state.splitMode = el.value;
      applySplitModeSelection();
      updateSplitValidationBanner(false);
      updatePaymentNetEffectPreview();
    });
  });
}

function applySplitModeSelection() {
  const advanced = document.getElementById("advanced-split-fields");
  if (advanced) advanced.classList.toggle("hidden", state.splitMode !== "custom");
  if (state.splitMode === "custom") return;
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
  const owesMode = document.getElementById("advanced-owes-mode");
  if (owesMode) owesMode.value = "percentage";
  state.advancedOwesMode = "percentage";
  state.splitMode = "preset_you_equal";
  const radio = document.querySelector("input[name='split_mode'][value='preset_you_equal']");
  if (radio) radio.checked = true;
  applySplitModeSelection();
  updateSplitValidationBanner(false);
}

function normalizeTitle(value) {
  return String(value || "")
    .toLowerCase()
    .replace(/[^a-z0-9\s]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function toTitleCaseText(value) {
  const cleaned = String(value || "")
    .trim()
    .replace(/[^a-zA-Z0-9\s]/g, " ")
    .replace(/\s+/g, " ");
  if (!cleaned) return "";
  return cleaned
    .split(" ")
    .filter(Boolean)
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
    .join(" ");
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
    .select("source_type, title, payment_date")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .gt("created_at", lastOpenedAtIso)
    .order("created_at", { ascending: false })
    .limit(300);

  if (error) throw error;

  let oneOffCount = 0;
  let recurringCount = 0;
  const oneOffTitles = [];
  const recurringTitles = [];
  for (const row of data || []) {
    if (row.source_type === "one_off") {
      oneOffCount += 1;
      if (row.title) oneOffTitles.push(String(row.title));
    }
    if (row.source_type === "recurring_generated") {
      recurringCount += 1;
      if (row.title) recurringTitles.push(String(row.title));
    }
  }

  return { oneOffCount, recurringCount, oneOffTitles, recurringTitles };
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

  const today = localTodayUtc();

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
          .select("id, status")
          .eq("recurring_template_id", t.id)
          .eq("due_date", dueDateStr)
          .maybeSingle();
        if (existingLogError) throw existingLogError;
        if (existingLog?.id && existingLog.status !== "failed") continue;

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

function computeUpcomingDueDates(template, fromDate, toDate) {
  const dates = [];
  const start = new Date(`${template.start_date}T00:00:00Z`);
  if (Number.isNaN(start.getTime())) return dates;
  const end = template.end_date ? new Date(`${template.end_date}T00:00:00Z`) : null;
  const fromUtc = new Date(Date.UTC(fromDate.getUTCFullYear(), fromDate.getUTCMonth(), fromDate.getUTCDate()));
  const toUtc = new Date(Date.UTC(toDate.getUTCFullYear(), toDate.getUTCMonth(), toDate.getUTCDate()));

  if (template.frequency === "annual") {
    let year = fromUtc.getUTCFullYear();
    while (year <= toUtc.getUTCFullYear()) {
      const d = new Date(Date.UTC(year, start.getUTCMonth(), start.getUTCDate()));
      if (d >= fromUtc && d <= toUtc && d >= start && (!end || d <= end)) {
        dates.push(d);
      }
      year += 1;
    }
    return dates;
  }

  const day = Number(template.day_of_month || start.getUTCDate());
  let cursor = new Date(Date.UTC(fromUtc.getUTCFullYear(), fromUtc.getUTCMonth(), 1));
  while (cursor <= toUtc) {
    const year = cursor.getUTCFullYear();
    const month = cursor.getUTCMonth();
    const lastDay = new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
    const date = new Date(Date.UTC(year, month, Math.min(day, lastDay)));
    if (date >= fromUtc && date <= toUtc && date >= start && (!end || date <= end)) {
      dates.push(date);
    }
    cursor = new Date(Date.UTC(year, month + 1, 1));
  }
  return dates;
}

async function renderHypotheticalUpcoming() {
  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_templates")
    .select("id, title, amount, frequency, day_of_month, start_date, end_date, status")
    .eq("household_id", state.householdId)
    .eq("status", "active")
    .limit(500);
  if (error) throw error;

  const today = localTodayUtc();
  const horizon = new Date(today);
  horizon.setUTCDate(horizon.getUTCDate() + 30);

  const items = [];
  const templateIds = (data || []).map((t) => t.id);
  const { data: contribData, error: contribError } = await state.supabase
    .schema("finance_app")
    .from("recurring_template_contributions")
    .select("recurring_template_id, user_id, mode, value")
    .in("recurring_template_id", templateIds.length ? templateIds : ["00000000-0000-0000-0000-000000000000"]);
  if (contribError) throw contribError;
  const contribByTemplate = new Map();
  for (const row of contribData || []) {
    if (!contribByTemplate.has(row.recurring_template_id)) contribByTemplate.set(row.recurring_template_id, []);
    contribByTemplate.get(row.recurring_template_id).push(row);
  }
  for (const t of data || []) {
    const dueDates = computeUpcomingDueDates(t, today, horizon);
    const templateContrib = (contribByTemplate.get(t.id) || []).slice().sort((a, b) => Number(b.value || 0) - Number(a.value || 0));
    const primaryPayerId = templateContrib[0]?.user_id || t.created_by || null;
    const primaryPayerName = primaryPayerId ? memberNameByUserId(primaryPayerId) : "Unknown";
    for (const d of dueDates) {
      items.push({
        templateId: t.id,
        dueDate: d.toISOString().slice(0, 10),
        title: t.title,
        amount: Number(t.amount || 0),
        frequency: t.frequency,
        payerUserId: primaryPayerId,
        payerName: primaryPayerName
      });
    }
  }

  if (items.length) {
    const templateIds = Array.from(new Set(items.map((i) => i.templateId)));
    const fromIso = today.toISOString().slice(0, 10);
    const toIso = horizon.toISOString().slice(0, 10);
    const { data: realized, error: realizedError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("generated_by_recurring_template_id, due_date_for_generation")
      .in("generated_by_recurring_template_id", templateIds)
      .gte("due_date_for_generation", fromIso)
      .lte("due_date_for_generation", toIso)
      .is("deleted_at", null);
    if (realizedError) throw realizedError;
    const realizedSet = new Set(
      (realized || [])
        .filter((r) => r.generated_by_recurring_template_id && r.due_date_for_generation)
        .map((r) => `${r.generated_by_recurring_template_id}::${r.due_date_for_generation}`)
    );
    const filtered = items.filter((i) => !realizedSet.has(`${i.templateId}::${i.dueDate}`));
    items.length = 0;
    items.push(...filtered);
  }

  items.sort((a, b) => b.dueDate.localeCompare(a.dueDate) || a.title.localeCompare(b.title));
  return items.slice(0, 100).map((r, idx) => ({
    id: `hypo-${r.dueDate}-${idx}-${r.title}`,
    payment_date: r.dueDate,
    title: r.title,
    amount_gbp: r.amount,
    category_key: "recurring",
    source_type: "recurring_generated",
    created_by: r.payerUserId,
    hypothetical_payer_name: r.payerName,
    generated_by_recurring_template_id: null,
    is_hypothetical: true
  }));
}

function computeDueDates(template, today) {
  const dates = [];
  const start = new Date(`${template.start_date}T00:00:00Z`);
  if (Number.isNaN(start.getTime())) return dates;
  const end = template.end_date ? new Date(`${template.end_date}T00:00:00Z`) : null;
  const todayUtc = new Date(Date.UTC(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()));
  const floorDateStr = template.last_processed_at ? String(template.last_processed_at).slice(0, 10) : null;

  if (template.frequency === "annual") {
    let year = start.getUTCFullYear();
    while (year <= todayUtc.getUTCFullYear()) {
      const d = new Date(Date.UTC(year, start.getUTCMonth(), start.getUTCDate()));
      const dStr = d.toISOString().slice(0, 10);
      if (d < start) {
        year += 1;
        continue;
      }
      if (d > todayUtc) break;
      if (end && d > end) break;
      if (!floorDateStr || dStr > floorDateStr) dates.push(d);
      year += 1;
    }
    return dates;
  }

  // monthly default
  const day = Number(template.day_of_month || start.getUTCDate());
  let cursor = new Date(Date.UTC(start.getUTCFullYear(), start.getUTCMonth(), 1));
  while (cursor <= todayUtc) {
    const year = cursor.getUTCFullYear();
    const month = cursor.getUTCMonth();
    const lastDay = new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
    const date = new Date(Date.UTC(year, month, Math.min(day, lastDay)));
    const dateStr = date.toISOString().slice(0, 10);
    if (date >= start && date <= todayUtc && (!end || date <= end) && (!floorDateStr || dateStr > floorDateStr)) {
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

const CURRENCY_FORMAT_CACHE = new Map();
function formatCurrencyAmount(value, currencyCode) {
  const code = String(currencyCode || "GBP").toUpperCase();
  if (code === "GBP") return formatGbp(value);
  if (!CURRENCY_FORMAT_CACHE.has(code)) {
    try {
      CURRENCY_FORMAT_CACHE.set(code, new Intl.NumberFormat("en-GB", { style: "currency", currency: code }));
    } catch {
      CURRENCY_FORMAT_CACHE.set(code, null);
    }
  }
  const formatter = CURRENCY_FORMAT_CACHE.get(code);
  return formatter ? formatter.format(Number(value || 0)) : `${code} ${Number(value || 0).toFixed(2)}`;
}

function categoryIcon(categoryKey) {
  const map = {
    household_bills: "🏠",
    travel: "✈️",
    insurance: "🛡️",
    mortgage_rent: "🏡",
    utilities: "🔌",
    internet_phone: "📶",
    groceries: "🛒",
    shopping: "🛍️",
    dining: "🍽️",
    subscriptions: "📺",
    education: "🎓",
    entertainment: "🎬",
    healthcare: "🩺",
    transport: "🚗",
    settlements: "💷",
    recurring: "🔁",
    other: "📄"
  };
  return map[String(categoryKey || "").toLowerCase()] || "📄";
}

function typeIcon(sourceType) {
  const map = {
    one_off: "💳",
    recurring_generated: "♻️",
    recurring_initial: "♻️",
    settlement: "💸"
  };
  return map[String(sourceType || "").toLowerCase()] || "•";
}

function categoryOptionLabel(key, fallbackLabel) {
  const icon = categoryIcon(key);
  const label = fallbackLabel || key || "Other";
  return `${icon} ${label}`;
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
    .filter((c) => String(c.key || "").toLowerCase() !== "settlements")
    .sort((a, b) => {
      const ua = usage.get(a.key) || 0;
      const ub = usage.get(b.key) || 0;
      if (ub !== ua) return ub - ua;
      return a.label.localeCompare(b.label);
    });

  select.innerHTML = ordered
    .map((c) => `<option value="${escapeHtml(c.key)}">${escapeHtml(categoryOptionLabel(c.key, c.label))}</option>`)
    .join("");

  if (!ordered.some((c) => c.key === "other")) {
    const option = document.createElement("option");
    option.value = "other";
    option.textContent = categoryOptionLabel("other", "Other");
    select.appendChild(option);
  }
}

function renderPaidByRows(prefill = null, options = {}) {
  const { forceCustom = true, splitMode = null, splitPrefill = null } = options || {};
  const target = document.getElementById("paid-by-rows");
  if (!state.members.length) {
    if (target) target.textContent = "No members found.";
    renderSplitRows();
    renderSplitPresets();
    return;
  }

  if (target) {
    let selectedUserId = null;
    if (prefill?.length) {
      const best = prefill.reduce((a, b) => (Number(b.percentage || 0) > Number(a.percentage || 0) ? b : a), prefill[0]);
      selectedUserId = best.user_id;
    } else if (state.currentUser?.id) {
      selectedUserId = state.currentUser.id;
    }
    target.innerHTML = state.members
      .map((m) => {
        const checked = m.user_id === selectedUserId ? "checked" : "";
        return `<label class="inline">
          <input type="radio" name="paid_by_user" data-paid-by-user="${m.user_id}" ${checked} />
          ${escapeHtml(memberNameByUserId(m.user_id))}
        </label>`;
      })
      .join("");

    target.querySelectorAll("[data-paid-by-user]").forEach((el) => {
      el.addEventListener("change", () => updatePaymentNetEffectPreview());
    });
  }
  renderSplitRows();
  renderSplitPresets();
  if (!prefill?.length) {
    setDefaultSplitPreset();
  } else {
    if (splitMode && !forceCustom) {
      state.splitMode = splitMode;
      const modeRadio = document.querySelector(`input[name='split_mode'][value='${splitMode}']`);
      if (modeRadio) modeRadio.checked = true;
      if (splitMode === "custom") {
        const owesMode = document.getElementById("advanced-owes-mode");
        if (owesMode) owesMode.value = "fixed";
        state.advancedOwesMode = "fixed";
        renderSplitRows(splitPrefill || null);
      }
      applySplitModeSelection();
    } else {
      state.splitMode = "custom";
      const advanced = document.getElementById("advanced-split-fields");
      if (advanced) advanced.classList.remove("hidden");
      const customRadio = document.querySelector("input[name='split_mode'][value='custom']");
      if (customRadio) customRadio.checked = true;
    }
  }
  updateSplitValidationBanner(false);
  updatePaymentNetEffectPreview();
}

function inferSplitPresetForEdit(contribRows, splitRows, totalAmount) {
  if (state.members.length !== 2 || !state.currentUser?.id) return { mode: "custom" };
  const other = getOtherMember();
  if (!other) return { mode: "custom" };
  const meId = state.currentUser.id;
  const otherId = other.user_id;
  const total = Number(totalAmount || 0);
  if (!total || total <= 0) return { mode: "custom" };

  const contribByUser = new Map();
  const splitByUser = new Map();
  for (const r of contribRows || []) contribByUser.set(r.user_id, Number(r.amount || 0));
  for (const r of splitRows || []) splitByUser.set(r.user_id, Number(r.amount || 0));

  const paidMe = Number((contribByUser.get(meId) || 0).toFixed(2));
  const paidOther = Number((contribByUser.get(otherId) || 0).toFixed(2));
  const splitMe = Number((splitByUser.get(meId) || 0).toFixed(2));
  const splitOther = Number((splitByUser.get(otherId) || 0).toFixed(2));
  const tol = 0.02;
  const half = Number((total / 2).toFixed(2));

  const payerId = paidMe >= paidOther ? meId : otherId;
  const payerIsMe = payerId === meId;
  const payerSplit = payerIsMe ? splitMe : splitOther;
  const otherSplit = payerIsMe ? splitOther : splitMe;

  const paidBySingle =
    (Math.abs(paidMe - total) <= tol && Math.abs(paidOther) <= tol) ||
    (Math.abs(paidOther - total) <= tol && Math.abs(paidMe) <= tol);
  if (!paidBySingle) return { mode: "custom" };

  const isEqual = Math.abs(splitMe - half) <= tol && Math.abs(splitOther - half) <= tol;
  if (isEqual) return { mode: payerIsMe ? "preset_you_equal" : "preset_other_equal" };

  const isOtherOwesAll = Math.abs(otherSplit - total) <= tol && Math.abs(payerSplit) <= tol;
  if (isOtherOwesAll) return { mode: payerIsMe ? "preset_you_full" : "preset_other_full" };

  return { mode: "custom" };
}

function renderSplitRows(prefill = null) {
  const target = document.getElementById("split-rows");
  if (!target) return;
  if (!state.members.length) {
    target.textContent = "No members found.";
    return;
  }
  const selected = new Map();
  const amount = Number(document.querySelector("#payment-form input[name='amount']")?.value || 0);
  if (prefill?.length) {
    for (const p of prefill) selected.set(p.user_id, Number(p.value || 0));
  } else {
    if (state.advancedOwesMode === "ratio") {
      state.members.forEach((m) => selected.set(m.user_id, 1));
    } else if (state.advancedOwesMode === "percentage") {
      const each = state.members.length ? Number((100 / state.members.length).toFixed(2)) : 0;
      state.members.forEach((m, idx) => {
        const value = idx === 0 ? Number((100 - each * (state.members.length - 1)).toFixed(2)) : each;
        selected.set(m.user_id, value);
      });
    } else if (state.advancedOwesMode === "fixed") {
      const each = state.members.length ? Number((amount / state.members.length).toFixed(2)) : 0;
      state.members.forEach((m, idx) => {
        const value = idx === 0 ? Number((amount - each * (state.members.length - 1)).toFixed(2)) : each;
        selected.set(m.user_id, value);
      });
    }
  }
  const suffix = state.advancedOwesMode === "percentage" ? "%" : state.advancedOwesMode === "fixed" ? "GBP" : "ratio";
  target.innerHTML = state.members
    .map((m) => {
      const value = selected.get(m.user_id) || 0;
      const checked = selected.has(m.user_id) ? "checked" : "";
      return `<div class="advanced-row">
        <label class="inline"><input type="checkbox" data-split-user="${m.user_id}" ${checked} /> ${escapeHtml(memberNameByUserId(m.user_id))}</label>
        <input type="number" step="0.01" min="0" data-split-value="${m.user_id}" value="${value}" placeholder="${suffix}" />
      </div>`;
    })
    .join("");
  target.querySelectorAll("[data-split-user], [data-split-value]").forEach((el) => {
    el.addEventListener("input", (e) => {
      if (e.target.hasAttribute("data-split-value") && state.members.length === 2 &&
          (state.advancedOwesMode === "percentage" || state.advancedOwesMode === "fixed")) {
        const changedUserId = e.target.getAttribute("data-split-value");
        const otherInput = target.querySelector(`[data-split-value]:not([data-split-value="${changedUserId}"])`);
        if (otherInput) {
          const val = Number(e.target.value || 0);
          const total = state.advancedOwesMode === "percentage" ? 100 : Number(document.querySelector("#payment-form input[name='amount']")?.value || 0);
          otherInput.value = Math.max(0, Number((total - val).toFixed(2)));
        }
      }
      updateSplitValidationBanner(false);
      if (state.debouncedNetEffectUpdate) state.debouncedNetEffectUpdate();
      else updatePaymentNetEffectPreview();
    });
    el.addEventListener("change", (e) => {
      if (e.target.hasAttribute("data-split-value") && state.members.length === 2 &&
          (state.advancedOwesMode === "percentage" || state.advancedOwesMode === "fixed")) {
        const changedUserId = e.target.getAttribute("data-split-value");
        const otherInput = target.querySelector(`[data-split-value]:not([data-split-value="${changedUserId}"])`);
        if (otherInput) {
          const val = Number(e.target.value || 0);
          const total = state.advancedOwesMode === "percentage" ? 100 : Number(document.querySelector("#payment-form input[name='amount']")?.value || 0);
          otherInput.value = Math.max(0, Number((total - val).toFixed(2)));
        }
      }
      updateSplitValidationBanner(false);
      updatePaymentNetEffectPreview();
    });
    if (el.hasAttribute("data-split-value")) {
      el.addEventListener("blur", () => updateSplitValidationBanner(true));
    }
  });
}

function getPaidByAllocations(amount) {
  const selected = document.querySelector("[data-paid-by-user]:checked");
  if (selected) {
    return [{ user_id: selected.getAttribute("data-paid-by-user"), amount: Number(amount.toFixed(2)), pct: 100 }];
  }
  const other = getOtherMember();
  let payerUserId = state.currentUser?.id || state.members[0]?.user_id;
  if (state.splitMode === "preset_other_equal" || state.splitMode === "preset_other_full") {
    payerUserId = other?.user_id || payerUserId;
  }
  if (!payerUserId) throw new Error("No payer found.");
  return [{ user_id: payerUserId, amount: Number(amount.toFixed(2)), pct: 100 }];
}

function getPaidBySelectionSummary() {
  const selected = document.querySelector("[data-paid-by-user]:checked");
  if (selected) {
    return { selected: [{ user_id: selected.getAttribute("data-paid-by-user"), pct: 100 }], totalPct: 100 };
  }
  const other = getOtherMember();
  let payerUserId = state.currentUser?.id || state.members[0]?.user_id;
  if (state.splitMode === "preset_other_equal" || state.splitMode === "preset_other_full") {
    payerUserId = other?.user_id || payerUserId;
  }
  return { selected: payerUserId ? [{ user_id: payerUserId, pct: 100 }] : [], totalPct: payerUserId ? 100 : 0 };
}

function getSplitSelectionSummary(amount) {
  const checks = Array.from(document.querySelectorAll("[data-split-user]"));
  const selected = [];
  for (const c of checks) {
    const userId = c.getAttribute("data-split-user");
    const valInput = document.querySelector(`[data-split-value='${userId}']`);
    const value = Number(valInput?.value || 0);
    if (c.checked) selected.push({ user_id: userId, value });
  }
  const mode = state.advancedOwesMode || "percentage";
  const total = selected.reduce((sum, r) => sum + Number(r.value || 0), 0);
  return { mode, selected, total: Number(total.toFixed(2)) };
}

function updateSplitValidationBanner(showIfInvalid = false) {
  const banner = document.getElementById("split-validation-banner");
  if (!banner) return true;

  const advancedOpen = !document.getElementById("advanced-split-fields")?.classList.contains("hidden");
  if (!advancedOpen || state.splitMode !== "custom") {
    banner.classList.add("hidden");
    banner.textContent = "";
    return true;
  }

  const paidBy = getPaidBySelectionSummary();
  const split = getSplitSelectionSummary(Number(document.querySelector("#payment-form input[name='amount']")?.value || 0));
  const amount = Number(document.querySelector("#payment-form input[name='amount']")?.value || 0);
  const paidValid = paidBy.selected.length > 0 && Math.abs(paidBy.totalPct - 100) <= 0.01;
  let splitValid = split.selected.length > 0;
  if (split.mode === "percentage") splitValid = splitValid && Math.abs(split.total - 100) <= 0.01;
  if (split.mode === "fixed") splitValid = splitValid && Math.abs(split.total - amount) <= 0.01;
  if (split.mode === "ratio") splitValid = splitValid && split.total > 0;
  const valid = paidValid && splitValid;
  if (valid) {
    banner.classList.add("hidden");
    banner.textContent = "";
    return true;
  }
  if (!showIfInvalid) {
    banner.classList.add("hidden");
    banner.textContent = "";
    return false;
  }
  if (!split.selected.length) {
    banner.textContent = "Select at least one split member.";
  } else if (split.mode === "percentage" && Math.abs(split.total - 100) > 0.01) {
    banner.textContent = `Split percentage must total 100% (currently ${split.total.toFixed(2)}%).`;
  } else if (split.mode === "fixed" && Math.abs(split.total - amount) > 0.01) {
    banner.textContent = `Split fixed amounts must total ${formatGbp(amount)} (currently ${formatGbp(split.total)}).`;
  } else if (split.mode === "ratio" && split.total <= 0) {
    banner.textContent = "Split ratio must be greater than 0.";
  } else {
    banner.textContent = "Advanced split values are invalid.";
  }
  banner.classList.remove("hidden");
  return false;
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
  if (state.splitMode === "preset_you_equal" || state.splitMode === "preset_other_equal") {
    return buildEqualSplitRows(amount);
  }
  if (state.splitMode === "custom") {
    const { mode, selected } = getSplitSelectionSummary(amount);
    if (!selected.length) throw new Error("Select at least one split member.");
    if (mode === "percentage") {
      const totalPct = selected.reduce((s, r) => s + Number(r.value || 0), 0);
      if (Math.abs(totalPct - 100) > 0.01) throw new Error(`Split percentage must total 100% (currently ${totalPct.toFixed(2)}%).`);
      const rows = selected.map((r) => ({ user_id: r.user_id, amount: Number(((amount * Number(r.value || 0)) / 100).toFixed(2)) }));
      const total = rows.reduce((s, r) => s + r.amount, 0);
      const delta = Number((amount - total).toFixed(2));
      if (Math.abs(delta) >= 0.01 && rows.length) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
      return rows;
    }
    if (mode === "fixed") {
      const total = selected.reduce((s, r) => s + Number(r.value || 0), 0);
      if (Math.abs(total - amount) > 0.01) throw new Error(`Split fixed amounts must total ${formatGbp(amount)}.`);
      return selected.map((r) => ({ user_id: r.user_id, amount: Number(Number(r.value || 0).toFixed(2)) }));
    }
    if (mode === "ratio") {
      const totalRatio = selected.reduce((s, r) => s + Number(r.value || 0), 0);
      if (totalRatio <= 0) throw new Error("Split ratio must be greater than 0.");
      const rows = selected.map((r) => ({ user_id: r.user_id, amount: Number(((amount * Number(r.value || 0)) / totalRatio).toFixed(2)) }));
      const total = rows.reduce((s, r) => s + r.amount, 0);
      const delta = Number((amount - total).toFixed(2));
      if (Math.abs(delta) >= 0.01 && rows.length) rows[0].amount = Number((rows[0].amount + delta).toFixed(2));
      return rows;
    }
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
    target.classList.add("hidden");
    return;
  }
  target.classList.remove("hidden");

  const paidByRows = getPaidByAllocationsSafe(amount);
  if (!paidByRows.length) {
    target.textContent = "Select at least one payer with a percentage to preview net effect.";
    return;
  }
  const splitRows = buildSplitRows(amount, paidByRows);

  const paidLine = paidByRows.length
    ? `Paid by: ${paidByRows
        .slice()
        .sort((a, b) => Number(b.amount || 0) - Number(a.amount || 0))
        .map((r) => `${memberNameByUserId(r.user_id)} ${formatGbp(r.amount)}`)
        .join(", ")}`
    : "Paid by: Unknown";
  const splitLine = splitRows.length
    ? `Split: ${splitRows
        .slice()
        .sort((a, b) => Number(b.amount || 0) - Number(a.amount || 0))
        .map((r) => `${memberNameByUserId(r.user_id)} ${formatGbp(r.amount)}`)
        .join(", ")}`
    : "Split: Unknown";

  const netByUser = new Map();
  for (const m of state.members) netByUser.set(m.user_id, 0);
  for (const r of paidByRows) netByUser.set(r.user_id, Number((netByUser.get(r.user_id) + Number(r.amount || 0)).toFixed(2)));
  for (const r of splitRows) netByUser.set(r.user_id, Number((netByUser.get(r.user_id) - Number(r.amount || 0)).toFixed(2)));

  const creditors = [];
  const debtors = [];
  for (const m of state.members) {
    const net = Number((netByUser.get(m.user_id) || 0).toFixed(2));
    if (net > 0.009) creditors.push({ userId: m.user_id, amount: net });
    if (net < -0.009) debtors.push({ userId: m.user_id, amount: Math.abs(net) });
  }

  creditors.sort((a, b) => b.amount - a.amount);
  debtors.sort((a, b) => b.amount - a.amount);
  const results = [];
  let i = 0;
  let j = 0;
  while (i < debtors.length && j < creditors.length) {
    const settled = Math.min(debtors[i].amount, creditors[j].amount);
    if (settled > 0.009) {
      results.push(`${memberNameByUserId(debtors[i].userId)} owes ${memberNameByUserId(creditors[j].userId)} ${formatGbp(settled)}`);
    }
    debtors[i].amount = Number((debtors[i].amount - settled).toFixed(2));
    creditors[j].amount = Number((creditors[j].amount - settled).toFixed(2));
    if (debtors[i].amount <= 0.009) i += 1;
    if (creditors[j].amount <= 0.009) j += 1;
  }
  const resultLine = results.length ? `Result: ${results.join(" | ")}` : "Result: No one owes anything";

  target.innerHTML = `
    <div class="net-effect-title">Net Effect</div>
    <div class="net-effect-meta">${escapeHtml(paidLine)}</div>
    <div class="net-effect-meta">${escapeHtml(splitLine)}</div>
    <div class="net-effect-result">${escapeHtml(resultLine)}</div>
  `;
}

function memberNameByUserId(userId) {
  const member = state.members.find((m) => m.user_id === userId);
  return toDisplayFirstName(member?.display_name || "");
}

async function loadDashboardData() {
  let payments = await fetchPaymentsPage({ reset: true });

  // Fallback: if no rows for the current household context, detect a household that has data.
  if (!payments.length) {
    const { data: anyPayments, error: anyPaymentsError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("id, household_id, title, amount_gbp, payment_date, category_key, source_type, created_by, generated_by_recurring_template_id")
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
    const [hypoRes, metaRes] = await Promise.allSettled([
      renderHypotheticalUpcoming(),
      buildPaymentMeta(payments)
    ]);
    const hypotheticalRows = hypoRes.status === "fulfilled" ? hypoRes.value : [];
    state.lastHypotheticalRows = hypotheticalRows.slice();
    if (hypoRes.status === "rejected") {
      console.error("Failed to load hypothetical rows:", hypoRes.reason);
    }
    const payerLabels = metaRes.status === "fulfilled" ? metaRes.value.payerLabels : new Map();
    const paymentDetails = metaRes.status === "fulfilled" ? metaRes.value.paymentDetails : new Map();
    if (metaRes.status === "rejected") {
      console.error("Failed to load payment meta:", metaRes.reason);
    }
    renderPayments(payments, payerLabels, paymentDetails, hypotheticalRows);
  } catch (error) {
    console.error("Failed to render payments:", error);
    document.getElementById("payments-list").textContent = `Failed to render payments: ${formatError(error)}`;
  }

  let balanceContext = { balances: new Map(), suggestions: [] };
  const [balancesRes, recurringRes, syncRes, titleIndexRes] = await Promise.allSettled([
    renderBalances(payments),
    renderRecurringSection(),
    renderSyncLogs(),
    loadTitleCategoryIndex()
  ]);
  if (balancesRes.status === "fulfilled") {
    balanceContext = balancesRes.value || balanceContext;
  } else {
    const error = balancesRes.reason;
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
  if (recurringRes.status === "rejected") console.error("Failed to render recurring section:", recurringRes.reason);
  if (syncRes.status === "rejected") console.error("Failed to render sync logs:", syncRes.reason);
  if (titleIndexRes.status === "rejected") console.error("Failed to load title/category index:", titleIndexRes.reason);
  await renderSummaryStats(payments, balanceContext);
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
    state.showSettledItems = false;
    state.paymentsCursorPaymentDate = null;
    state.paymentsCursorCreatedAt = null;
    state.loadedPayments = [];
  }

  let defaultFromDate = null;
  if (reset) {
    const { data: latestSettlement, error: latestSettlementError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("payment_date")
      .eq("household_id", state.householdId)
      .is("deleted_at", null)
      .eq("source_type", "settlement")
      .order("payment_date", { ascending: false })
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle();
    if (latestSettlementError) throw latestSettlementError;
    defaultFromDate = latestSettlement?.payment_date || null;
    state.latestSettlementDate = defaultFromDate;
  }

  let query = state.supabase
    .schema("finance_app")
    .from("payments")
    .select("id, household_id, title, amount, currency_code, fx_rate_to_gbp, amount_gbp, payment_date, category_key, source_type, created_by, generated_by_recurring_template_id, created_at, payment_contributions(user_id,amount), payment_splits(user_id,amount)")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .order("payment_date", { ascending: false })
    .order("created_at", { ascending: false });
  const cutoff = state.latestSettlementDate || defaultFromDate;
  if (!state.showSettledItems && cutoff) {
    query = query.gte("payment_date", cutoff);
  }
  if (!reset && state.paymentsCursorPaymentDate) {
    query = query.or(`payment_date.lt.${state.paymentsCursorPaymentDate},and(payment_date.eq.${state.paymentsCursorPaymentDate},created_at.lt.${state.paymentsCursorCreatedAt})`);
  }
  const { data, error } = await query.limit(state.paymentsPageSize);
  if (error) throw error;

  const rows = data || [];
  if (rows.length) {
    const last = rows[rows.length - 1];
    state.paymentsCursorPaymentDate = last.payment_date || state.paymentsCursorPaymentDate;
    state.paymentsCursorCreatedAt = last.created_at || state.paymentsCursorCreatedAt;
  }
  if (!state.showSettledItems && cutoff) {
    const { count, error: olderCountError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("id", { count: "exact", head: true })
      .eq("household_id", state.householdId)
      .is("deleted_at", null)
      .lt("payment_date", cutoff);
    if (olderCountError) throw olderCountError;
    state.paymentsHasMore = Number(count || 0) > 0 || rows.length === state.paymentsPageSize;
  } else {
    state.paymentsHasMore = rows.length === state.paymentsPageSize;
  }
  state.loadedPayments = reset ? rows.slice() : state.loadedPayments.concat(rows);
  return rows;
}

async function fetchLoadedPayments() {
  return state.loadedPayments.slice();
}

function updateLoadMoreButton() {
  const button = document.getElementById("load-more-payments");
  if (!button) return;
  button.textContent = state.showSettledItems ? "Show More" : "Show Settled Expenses";
  button.classList.toggle("hidden", !state.paymentsHasMore);
}

async function buildPaymentMeta(payments) {
  const paymentIds = payments.map((p) => p.id);
  if (!paymentIds.length) return { payerLabels: new Map(), paymentDetails: new Map() };
  // payment_contributions/payment_splits rows are recorded in the payment's
  // ORIGINAL currency (matching how the "Add Payment" form and edit modal
  // read/write them), not the converted GBP total, so reconciliation and
  // display must be done against `amount`/`currency_code`, not `amount_gbp`.
  const amountByPaymentId = new Map(payments.map((p) => [p.id, Number(p.amount ?? p.amount_gbp ?? 0)]));
  const currencyByPaymentId = new Map(payments.map((p) => [p.id, String(p.currency_code || "GBP").toUpperCase()]));
  const fxRateByPaymentId = new Map(payments.map((p) => [p.id, Number(p.fx_rate_to_gbp || 1)]));
  const amountGbpByPaymentId = new Map(payments.map((p) => [p.id, Number(p.amount_gbp || 0)]));
  const hasEmbeddedMeta = payments.some((p) => Array.isArray(p.payment_contributions) || Array.isArray(p.payment_splits));

  const byPayment = new Map();
  const splitByPayment = new Map();
  if (hasEmbeddedMeta) {
    for (const p of payments) {
      byPayment.set(
        p.id,
        (p.payment_contributions || []).map((c) => ({
          payment_id: p.id,
          user_id: c.user_id,
          amount: c.amount
        }))
      );
      splitByPayment.set(
        p.id,
        (p.payment_splits || []).map((s) => ({
          payment_id: p.id,
          user_id: s.user_id,
          amount: s.amount
        }))
      );
    }
  } else {
    const { data: contributions, error } = await state.supabase
      .schema("finance_app")
      .from("payment_contributions")
      .select("payment_id, user_id, amount")
      .in("payment_id", paymentIds);
    if (error) throw error;

    const { data: splits, error: splitsError } = await state.supabase
      .schema("finance_app")
      .from("payment_splits")
      .select("payment_id, user_id, amount")
      .in("payment_id", paymentIds);
    if (splitsError) throw splitsError;

    for (const c of contributions || []) {
      if (!byPayment.has(c.payment_id)) byPayment.set(c.payment_id, []);
      byPayment.get(c.payment_id).push(c);
    }
    for (const s of splits || []) {
      if (!splitByPayment.has(s.payment_id)) splitByPayment.set(s.payment_id, []);
      splitByPayment.get(s.payment_id).push(s);
    }
  }

  const labels = new Map();
  const paymentDetails = new Map();
  for (const id of paymentIds) {
    const contribRows = (byPayment.get(id) || []).slice().sort((a, b) => Number(b.amount) - Number(a.amount));
    if (!contribRows.length) {
      labels.set(id, "Unknown");
    } else {
      const names = contribRows.map((r) => memberNameByUserId(r.user_id));
      labels.set(id, names.join(", "));
    }

    const splitRows = (splitByPayment.get(id) || []).slice().sort((a, b) => Number(b.amount) - Number(a.amount));
    const currency = currencyByPaymentId.get(id) || "GBP";
    const fxRate = fxRateByPaymentId.get(id) || 1;
    const expectedAmount = Number((amountByPaymentId.get(id) || 0).toFixed(2));
    const contribTotal = Number(contribRows.reduce((sum, r) => sum + Number(r.amount || 0), 0).toFixed(2));
    const splitTotal = Number(splitRows.reduce((sum, r) => sum + Number(r.amount || 0), 0).toFixed(2));
    const reconciles =
      expectedAmount > 0 &&
      Math.abs(contribTotal - expectedAmount) <= 0.01 &&
      Math.abs(splitTotal - expectedAmount) <= 0.01;

    if (!reconciles) {
      // If rows do not reconcile to payment amount, hide split detail to avoid misleading text.
      continue;
    }

    const paidLine = contribRows.length
      ? `Paid by: ${contribRows.map((r) => `${memberNameByUserId(r.user_id)} ${formatCurrencyAmount(r.amount, currency)}`).join(", ")}`
      : "Paid by: Unknown";
    const splitLine = splitRows.length
      ? `Split: ${splitRows.map((r) => `${memberNameByUserId(r.user_id)} ${formatCurrencyAmount(r.amount, currency)}`).join(", ")}`
      : "Split: Unknown";
    const fxLine =
      currency !== "GBP"
        ? `FX: ${formatCurrencyAmount(expectedAmount, currency)} @ ${fxRate.toFixed(4)} = ${formatGbp(amountGbpByPaymentId.get(id))}`
        : null;

    // Settlement amounts are always expressed in GBP (the household's home
    // currency), so convert original-currency contributions/splits before
    // netting them against each other.
    const netByUser = new Map();
    for (const r of contribRows) netByUser.set(r.user_id, (netByUser.get(r.user_id) || 0) + Number(r.amount || 0) * fxRate);
    for (const r of splitRows) netByUser.set(r.user_id, (netByUser.get(r.user_id) || 0) - Number(r.amount || 0) * fxRate);
    const creditors = [];
    const debtors = [];
    for (const [userId, net] of netByUser.entries()) {
      if (net > 0.009) creditors.push({ userId, amount: Number(net.toFixed(2)) });
      if (net < -0.009) debtors.push({ userId, amount: Number(Math.abs(net).toFixed(2)) });
    }
    creditors.sort((a, b) => b.amount - a.amount);
    debtors.sort((a, b) => b.amount - a.amount);
    const results = [];
    let i = 0;
    let j = 0;
    while (i < debtors.length && j < creditors.length) {
      const settled = Math.min(debtors[i].amount, creditors[j].amount);
      if (settled > 0.009) {
        results.push(`${memberNameByUserId(debtors[i].userId)} owes ${memberNameByUserId(creditors[j].userId)} ${formatGbp(settled)}`);
      }
      debtors[i].amount = Number((debtors[i].amount - settled).toFixed(2));
      creditors[j].amount = Number((creditors[j].amount - settled).toFixed(2));
      if (debtors[i].amount <= 0.009) i += 1;
      if (creditors[j].amount <= 0.009) j += 1;
    }
    const resultLine = results.length ? `Result: ${results.join(" | ")}` : "Result: No one owes anything";
    paymentDetails.set(id, { paidLine, splitLine, resultLine, fxLine });
  }
  return { payerLabels: labels, paymentDetails };
}

function renderPaymentRow(p, payerLabels, paymentDetails) {
  const isSettlement = p.source_type === "settlement";
  const isFutureReal = !p.is_hypothetical && !isSettlement && isFutureDated(p.payment_date);
  const isProjected = p.is_hypothetical || isFutureReal;
  const payer = p.is_hypothetical
    ? (p.hypothetical_payer_name || memberNameByUserId(p.created_by) || "—")
    : (payerLabels?.get(p.id) || memberNameByUserId(p.created_by));
  const detail = paymentDetails?.get(p.id) || null;
  const isRecurringInitial = p.source_type === "one_off" && Boolean(p.generated_by_recurring_template_id);
  const typeLabel = isRecurringInitial ? "recurring_initial" : p.source_type;
  const categoryLabel = isRecurringInitial ? "recurring" : (p.category_key || "-");
  const rowClass = isProjected ? "hypothetical-payment-row" : (p.source_type === "settlement" ? "cash-row" : "");
  const subtitleHtml = `${!isSettlement && p.is_hypothetical ? `<div class="payment-meta-line">Projected from recurring payment</div>` : ""}
      ${!isSettlement && isFutureReal ? `<div class="payment-meta-line">Projected (future dated, excluded from totals)</div>` : ""}
      ${!isSettlement && !p.is_hypothetical && !detail ? `<div class="payment-meta-line">(imported from splitwise)</div>` : ""}
      ${!isSettlement && detail ? `<div class="payment-meta-line">${escapeHtml(detail.paidLine)}</div>` : ""}
      ${!isSettlement && detail ? `<div class="payment-meta-line">${escapeHtml(detail.splitLine)}</div>` : ""}
      ${!isSettlement && detail?.fxLine ? `<div class="payment-meta-line">${escapeHtml(detail.fxLine)}</div>` : ""}
      ${!isSettlement && detail ? `<div class="payment-result-line">${escapeHtml(detail.resultLine)}</div>` : ""}`;
  const hasSubtitleDetails = subtitleHtml.replace(/\s/g, "").length > 0;
  const rowClassWithDetails = `${rowClass}${hasSubtitleDetails ? "" : " no-mobile-details"}`;
  return `<tr class="${rowClassWithDetails}">
    <td data-label="Date">${toDateLabel(p.payment_date)}</td>
    <td data-label="Expense">
      <div class="payment-title" style="display:flex; align-items:center; gap:8px">
        ${isSettlement ? "" : `<span class="pill" title="${escapeHtml(categoryLabel)}" aria-label="${escapeHtml(categoryLabel)}">${categoryIcon(categoryLabel)}</span>`}
        <span>${escapeHtml(p.title)}</span>
      </div>
      <div class="payment-subtitle-desktop">${subtitleHtml}</div>
    </td>
    <td data-label="Type"><span class="pill" title="${escapeHtml(typeLabel)}" aria-label="${escapeHtml(typeLabel)}">${typeIcon(typeLabel)}</span></td>
    <td data-label="Payer">${escapeHtml(payer)}</td>
    <td data-label="Amount" style="text-align:right"><strong>${formatGbp(p.amount_gbp)}</strong></td>
    <td data-label="Details" class="payment-details-mobile${isSettlement ? " no-details" : ""}">${subtitleHtml}</td>
    <td data-label="Actions" style="text-align:right; white-space:nowrap">
      ${p.is_hypothetical
        ? `<span style="color:var(--muted); font-size:12px">Projected</span>`
        : (isSettlement
          ? `<button type="button" class="icon-btn" data-action="delete" data-payment-id="${p.id}" title="Delete">&#x1F5D1;</button>`
          : `<button type="button" class="icon-btn" data-action="edit" data-payment-id="${p.id}" title="Edit">&#x270E;</button>
      <button type="button" class="icon-btn" data-action="delete" data-payment-id="${p.id}" title="Delete">&#x1F5D1;</button>`)}
    </td>
  </tr>`;
}

function renderPayments(payments, payerLabels, paymentDetails = new Map(), hypotheticalRows = []) {
  state.lastPayerLabels = payerLabels || new Map();
  state.lastPaymentDetails = paymentDetails || new Map();
  const target = document.getElementById("payments-list");
  const showProjected = document.getElementById("show-projected")?.checked ?? true;
  const toggleLabel = document.getElementById("show-projected-toggle");
  const hasFutureRealPayments = (payments || []).some(
    (p) => p.source_type !== "settlement" && isFutureDated(p.payment_date)
  );

  if (hypotheticalRows.length || hasFutureRealPayments) {
    toggleLabel?.classList.remove("hidden");
  } else {
    toggleLabel?.classList.add("hidden");
  }

  const visiblePayments = showProjected
    ? (payments || [])
    : (payments || []).filter((p) => p.source_type === "settlement" || !isFutureDated(p.payment_date));

  const combined = [
    ...(showProjected ? (hypotheticalRows || []).slice(0, 100) : []),
    ...visiblePayments.slice(0, 200)
  ];

  if (!combined.length) {
    target.textContent = "No payments yet.";
    return;
  }

  const rows = combined.map((p) => renderPaymentRow(p, payerLabels, paymentDetails)).join("");

  target.innerHTML = `
    <div class="payments-table-wrap">
      <table class="payments-table">
        <thead>
          <tr>
            <th style="text-align:left">Date</th>
            <th style="text-align:left">Expense</th>
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
    .select("id, title, amount, currency_code, payment_date, fx_rate_to_gbp, fx_rate_date, category_key, notes, source_type, generated_by_recurring_template_id")
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
  const fxStatusForEdit = document.getElementById("fx-rate-status");
  if (fxStatusForEdit) fxStatusForEdit.textContent = "";
  form.category_key.value = data.category_key || "other";
  state.categoryManuallySet = true;
  if (form.notes) form.notes.value = data.notes || "";
  const { data: contribRows } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .select("user_id, amount")
    .eq("payment_id", paymentId);
  const { data: splitRows } = await state.supabase
    .schema("finance_app")
    .from("payment_splits")
    .select("user_id, amount")
    .eq("payment_id", paymentId);
  const total = Number(data.amount || 0) || 1;
  const prefill = (contribRows || []).map((r) => ({
    user_id: r.user_id,
    percentage: (Number(r.amount || 0) / total) * 100
  }));
  const splitPrefill = (splitRows || []).map((r) => ({
    user_id: r.user_id,
    value: Number(r.amount || 0)
  }));
  const inferred = inferSplitPresetForEdit(contribRows || [], splitRows || [], total);
  renderPaidByRows(prefill, {
    forceCustom: false,
    splitMode: inferred.mode,
    splitPrefill
  });
  const oneOffRadio = document.querySelector("#payment-form input[name='payment_kind'][value='one_off']");
  if (oneOffRadio) oneOffRadio.checked = true;
  document.getElementById("recurring-fields").classList.add("hidden");
  state.editingPaymentId = paymentId;
  state.editingPaymentMeta = {
    source_type: data.source_type || null,
    recurring_template_id: data.generated_by_recurring_template_id || null
  };
  document.querySelector("#payment-modal h3").textContent = "Edit Payment";
  document.getElementById("payment-modal").showModal();
  updatePaymentNetEffectPreview();
}

async function deletePayment(paymentId) {
  if (!window.confirm("Delete this payment?")) return;
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
  applyOptimisticPaymentMutation({ action: "delete", paymentId });
  scheduleDashboardRefresh();
}

function applyOptimisticPaymentMutation(mutation) {
  if (!mutation) return;
  if (mutation.action === "delete") {
    state.loadedPayments = (state.loadedPayments || []).filter((p) => p.id !== mutation.paymentId);
  } else if (mutation.action === "upsert" && mutation.payment) {
    const next = (state.loadedPayments || []).filter((p) => p.id !== mutation.payment.id);
    next.unshift(mutation.payment);
    next.sort((a, b) => String(b.created_at || "").localeCompare(String(a.created_at || "")));
    state.loadedPayments = next;
  }
  renderPayments(state.loadedPayments || [], new Map(), new Map(), state.lastHypotheticalRows || []);
}

// The balances RPC sums payment_contributions.amount / payment_splits.amount
// directly and treats the result as GBP. Two cases make that wrong, and
// rather than changing the DB function we correct for both client-side:
//  1. Future-dated payments (shown as "projected") should not count at all
//     yet — their raw contribution/split amounts need removing entirely.
//  2. Non-GBP payments store contributions/splits in the ORIGINAL currency
//     (matching how the Add Payment form and edit modal read/write them),
//     not the converted GBP amount, so the RPC's raw sum overstates/understates
//     them by a factor of fx_rate_to_gbp.
// For a payment needing correction, "true" GBP value of a contribution/split
// row is `raw * fx_rate_to_gbp` (or 0 entirely if it's future-dated); the
// delta between that and the RPC's raw sum is netted out per user below.
async function fetchBalanceCorrections() {
  const correction = new Map();
  const todayIso = localTodayIsoDate();
  const { data: candidatePayments, error } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .select("id, fx_rate_to_gbp, payment_date")
    .eq("household_id", state.householdId)
    .is("deleted_at", null)
    .or(`payment_date.gt.${todayIso},fx_rate_to_gbp.neq.1`);
  if (error) throw error;

  const candidateIds = (candidatePayments || []).map((p) => p.id);
  if (!candidateIds.length) return correction;

  const fxRateByPayment = new Map(candidatePayments.map((p) => [p.id, Number(p.fx_rate_to_gbp || 1)]));
  const isFutureByPayment = new Map(candidatePayments.map((p) => [p.id, isFutureDated(p.payment_date)]));

  const [contribRes, splitsRes] = await Promise.all([
    state.supabase.schema("finance_app").from("payment_contributions").select("payment_id, user_id, amount").in("payment_id", candidateIds),
    state.supabase.schema("finance_app").from("payment_splits").select("payment_id, user_id, amount").in("payment_id", candidateIds)
  ]);
  if (contribRes.error) throw contribRes.error;
  if (splitsRes.error) throw splitsRes.error;

  const netCorrection = (rows, sign) => {
    for (const row of rows || []) {
      const raw = Number(row.amount || 0);
      const trueGbp = isFutureByPayment.get(row.payment_id) ? 0 : raw * fxRateByPayment.get(row.payment_id);
      const delta = raw - trueGbp;
      correction.set(row.user_id, (correction.get(row.user_id) || 0) + sign * delta);
    }
  };
  netCorrection(contribRes.data, 1);
  netCorrection(splitsRes.data, -1);
  return correction;
}

async function getHouseholdBalanceRows() {
  const { data, error } = await state.supabase.schema("finance_app").rpc("get_household_balances", {
    p_household_id: state.householdId
  });
  if (error) throw error;
  const adjustment = await fetchBalanceCorrections();

  return (data || [])
    .map((r) => {
      const rawNet = Number(r.net || 0) - (adjustment.get(r.user_id) || 0);
      return {
        userId: r.user_id,
        name: toDisplayFirstName(r.display_name) || memberNameByUserId(r.user_id),
        net: Number(rawNet.toFixed(2))
      };
    })
    .sort((a, b) => b.net - a.net);
}

async function renderBalances(payments) {
  void payments;
  const target = document.getElementById("balances-list");
  if (!target) {
    const rows = await getHouseholdBalanceRows();
    const balances = new Map(rows.map((r) => [r.userId, r.net]));
    const suggestions = buildSettlementSuggestions(rows);
    return { balances, suggestions };
  }
  const rows = await getHouseholdBalanceRows();

  const balances = new Map(rows.map((r) => [r.userId, r.net]));

  const balanceRowsHtml = rows
    .map((r) => {
      const label = r.net >= 0 ? "is owed" : "owes";
      return `<div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--line)">
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
            `<div style="display:flex; justify-content:space-between; padding:6px 0; border-bottom:1px solid var(--line)">
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
  document.getElementById("recurring-list").textContent = "Recurring payments loading next step.";
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
    target.textContent = "No recurring payments yet.";
    return;
  }

  const tableRows = rows
    .map((r) => {
      const titleText = toTitleCaseText(r.title || "");
      const frequencyText = toTitleCaseText(r.frequency || "");
      const statusChecked = r.status === "active" ? "checked" : "";
      const now = new Date();
      const end = r.end_date ? new Date(`${r.end_date}T00:00:00`) : null;
      const daysToEnd = end ? Math.ceil((end.getTime() - now.getTime()) / 86400000) : null;
      const expiringSoon = r.status === "active" && daysToEnd !== null && daysToEnd >= 0 && daysToEnd <= 30;
      const rowClass = expiringSoon ? " recurring-expiring-soon" : "";
      return `<tr class="${rowClass}">
        <td data-label="Name">${escapeHtml(titleText)}</td>
        <td data-label="Amount" style="text-align:right"><strong>${formatGbp(r.amount)}</strong></td>
        <td data-label="Frequency">${escapeHtml(frequencyText)}</td>
        <td data-label="Start">${toDateLabel(r.start_date)}</td>
        <td data-label="End">${r.end_date ? toDateLabel(r.end_date) : "—"}</td>
        <td data-label="Actions">
          <div style="display:flex; align-items:center; justify-content:flex-end; gap:6px">
            <button type="button" class="icon-btn" data-action="edit-recurring" data-template-id="${r.id}" title="Edit">&#x270E;</button>
            <label class="active-toggle-label">
              <input type="checkbox" data-action="toggle-recurring" data-template-id="${r.id}" ${statusChecked} />
              Active
            </label>
            <button type="button" class="icon-btn" data-action="delete-recurring" data-template-id="${r.id}" title="Delete">&#x1F5D1;</button>
          </div>
        </td>
      </tr>`;
    })
    .join("");

  target.innerHTML = `
    <div class="payments-table-wrap">
      <table class="payments-table">
        <thead>
          <tr>
            <th style="text-align:left">Name</th>
            <th style="text-align:right">Amount</th>
            <th style="text-align:left">Frequency</th>
            <th style="text-align:left">Start</th>
            <th style="text-align:left">End</th>
            <th style="text-align:right">Actions</th>
          </tr>
        </thead>
        <tbody>${tableRows}</tbody>
      </table>
    </div>
  `;

  target.querySelectorAll("input[data-action='toggle-recurring']").forEach((input) => {
    input.addEventListener("change", async () => {
      const templateId = input.getAttribute("data-template-id");
      const nextStatus = input.checked ? "active" : "paused";
      const { error: updateError } = await state.supabase
        .schema("finance_app")
        .from("recurring_templates")
        .update({ status: nextStatus })
        .eq("id", templateId);
      if (updateError) {
        showToast(`Failed to update recurring: ${formatError(updateError)}`);
        input.checked = !input.checked;
        return;
      }
      showToast(`Recurring payment ${nextStatus}.`);
      scheduleDashboardRefresh();
    });
  });
  target.querySelectorAll("button[data-action='edit-recurring']").forEach((btn) => {
    btn.addEventListener("click", () => openRecurringTemplateModal(btn.getAttribute("data-template-id")));
  });
  target.querySelectorAll("button[data-action='delete-recurring']").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const templateId = btn.getAttribute("data-template-id");
      if (!templateId) return;
      const ok = window.confirm("Delete this recurring payment completely?");
      if (!ok) return;

      const { error: delContribError } = await state.supabase
        .schema("finance_app")
        .from("recurring_template_contributions")
        .delete()
        .eq("recurring_template_id", templateId);
      if (delContribError) {
        showToast(`Delete failed: ${formatError(delContribError)}`);
        return;
      }

      const { error: delSplitsError } = await state.supabase
        .schema("finance_app")
        .from("recurring_template_splits")
        .delete()
        .eq("recurring_template_id", templateId);
      if (delSplitsError) {
        showToast(`Delete failed: ${formatError(delSplitsError)}`);
        return;
      }

      const { error: delLogError } = await state.supabase
        .schema("finance_app")
        .from("recurring_generation_log")
        .delete()
        .eq("recurring_template_id", templateId);
      if (delLogError) {
        showToast(`Delete failed: ${formatError(delLogError)}`);
        return;
      }

      const { error: unlinkPaymentsError } = await state.supabase
        .schema("finance_app")
        .from("payments")
        .update({
          generated_by_recurring_template_id: null,
          due_date_for_generation: null
        })
        .eq("generated_by_recurring_template_id", templateId);
      if (unlinkPaymentsError) {
        showToast(`Delete failed: ${formatError(unlinkPaymentsError)}`);
        return;
      }

      const { error: deleteTemplateError } = await state.supabase
        .schema("finance_app")
        .from("recurring_templates")
        .delete()
        .eq("id", templateId);
      if (deleteTemplateError) {
        showToast(`Delete failed: ${formatError(deleteTemplateError)}`);
        return;
      }

      showToast("Recurring payment deleted.");
      scheduleDashboardRefresh();
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
  const todayUtc = localTodayUtc();
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
      (r, idx) => `<div style="padding:6px 0; border-bottom:1px solid var(--line)">
        <span>${escapeHtml(r.text)}</span>
      </div>`
    )
    .join("");
}

async function renderSummaryStats(payments, balanceContext) {
  void payments;

  const owesSummary = document.getElementById("stat-owes-summary");
  if (!owesSummary) return;

  let suggestions = balanceContext?.suggestions || [];
  try {
    const rows = await getHouseholdBalanceRows();
    const live = buildSettlementSuggestions(rows);
    if (live.length) suggestions = live;
  } catch (error) {
    console.error("Who-owes summary refresh failed:", error);
  }

  if (!suggestions.length) {
    setSettleUpEnabled(false);
    const noBalanceKey = "none";
    if (state.owesMessageKey !== noBalanceKey || !state.owesMessageText) {
      state.owesMessageKey = noBalanceKey;
      state.owesMessageText = randomNoOutstandingMessage();
    }
    owesSummary.textContent = state.owesMessageText;
    return;
  }
  setSettleUpEnabled(true);
  const suggestionsKey = suggestions
    .slice(0, 3)
    .map((s) => `${s.from}|${s.to}|${Number(s.amount || 0).toFixed(2)}`)
    .join(";");
  if (state.owesMessageKey !== suggestionsKey || !state.owesMessageText) {
    const maxSettlementAmount = Math.max(...suggestions.map((s) => Number(s.amount || 0)), 0);
    state.owesMessageKey = suggestionsKey;
    state.owesMessageText = randomOutstandingMessage(maxSettlementAmount);
  }
  const outstandingMessage = state.owesMessageText;
  owesSummary.innerHTML = suggestions
    .slice(0, 3)
    .map((s) => `<div style="padding:4px 0">${escapeHtml(s.from)} owes ${escapeHtml(s.to)} <strong>${formatGbp(s.amount)}</strong></div>`)
    .join("");
  owesSummary.innerHTML = `<div style="padding:4px 0; color:var(--text-secondary)">${escapeHtml(outstandingMessage)}</div>${owesSummary.innerHTML}`;
}

async function saveSettlementFromForm(form) {
  if (!state.currentUser || !state.householdId) throw new Error("You must be signed in.");
  const formData = new FormData(form);
  const fromUserId = String(formData.get("from_user_id") || "");
  const toUserId = String(formData.get("to_user_id") || "");
  const amount = parsePositiveAmount(formData.get("amount"), "Amount");
  const paymentDate = String(formData.get("payment_date") || "");
  const notes = String(formData.get("notes") || "").trim() || null;
  if (!fromUserId || !toUserId) throw new Error("From and To are required.");
  if (fromUserId === toUserId) throw new Error("From and To must be different members.");
  if (!paymentDate) throw new Error("Date is required.");

  const fromName = memberNameByUserId(fromUserId);
  const toName = memberNameByUserId(toUserId);
  const title = `Settlement: ${fromName} paid ${toName}`;

  const { data: payment, error: paymentError } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .insert({
      household_id: state.householdId,
      title,
      amount,
      currency_code: "GBP",
      fx_rate_to_gbp: 1,
      fx_rate_date: paymentDate,
      amount_gbp: Number(amount.toFixed(2)),
      payment_date: paymentDate,
      category_key: "settlements",
      notes,
      source_type: "settlement",
      created_by: state.currentUser.id
    })
    .select("id")
    .single();
  if (paymentError) throw paymentError;

  const { error: contributionError } = await state.supabase
    .schema("finance_app")
    .from("payment_contributions")
    .insert({ payment_id: payment.id, user_id: fromUserId, amount: Number(amount.toFixed(2)) });
  if (contributionError) throw contributionError;

  const { error: splitError } = await state.supabase
    .schema("finance_app")
    .from("payment_splits")
    .insert({ payment_id: payment.id, user_id: toUserId, amount: Number(amount.toFixed(2)) });
  if (splitError) throw splitError;
}

async function renderSyncLogs() {
  const target = document.getElementById("sync-log-list");
  if (!target) return;
  const now = new Date();
  const cutoff = new Date(now);
  cutoff.setUTCDate(cutoff.getUTCDate() - 10);
  const cutoffIso = cutoff.toISOString();

  const { data, error } = await state.supabase
    .schema("finance_app")
    .from("recurring_generation_log")
    .select("id, due_date, status, error_text, created_at, recurring_template_id, payment_id")
    .gte("created_at", cutoffIso)
    .order("created_at", { ascending: false })
    .limit(500);
  if (error) {
    target.textContent = `Failed to load sync logs: ${formatError(error)}`;
    return;
  }
  const rows = data || [];
  if (!rows.length) {
    target.textContent = "No sync logs in the last 10 days.";
    return;
  }

  const counts = {
    created: 0,
    skipped_exists: 0,
    failed: 0,
    other: 0
  };
  for (const r of rows) {
    if (r.status === "created") counts.created += 1;
    else if (r.status === "skipped_exists") counts.skipped_exists += 1;
    else if (r.status === "failed") counts.failed += 1;
    else counts.other += 1;
  }

  const candidatePaymentIds = Array.from(
    new Set(
      rows
        .filter((r) => (r.status === "created" || r.status === "skipped_exists") && r.payment_id)
        .map((r) => r.payment_id)
    )
  );
  let missingCount = 0;
  if (candidatePaymentIds.length) {
    const { data: payments, error: paymentsError } = await state.supabase
      .schema("finance_app")
      .from("payments")
      .select("id, deleted_at")
      .in("id", candidatePaymentIds);
    if (paymentsError) {
      target.textContent = `Failed to audit generated payments: ${formatError(paymentsError)}`;
      return;
    }
    const paymentMap = new Map((payments || []).map((p) => [p.id, p]));
    for (const pid of candidatePaymentIds) {
      const p = paymentMap.get(pid);
      if (!p || p.deleted_at) missingCount += 1;
    }
  }

  const summaryHtml = `
    <div style="padding:8px 0; border-bottom:1px solid var(--line); margin-bottom:6px">
      <div style="font-weight:600">Last 10 days recurring status</div>
      <div style="font-size:13px; color:var(--muted); margin-top:4px">
        created=${counts.created} • already-existed=${counts.skipped_exists} • failed=${counts.failed}${counts.other ? ` • other=${counts.other}` : ""} • missing/deleted generated payments=${missingCount}
      </div>
    </div>
  `;

  const logsHtml = rows
    .slice(0, 120)
    .map((r) => {
      const ts = new Date(r.created_at).toLocaleString("en-GB");
      const errorText = r.error_text ? ` - ${escapeHtml(r.error_text)}` : "";
      return `<div style="padding:4px 0; border-bottom:1px solid var(--line)">
        <strong>${escapeHtml(r.status)}</strong> template=${escapeHtml(r.recurring_template_id)} due=${escapeHtml(r.due_date)} at ${escapeHtml(ts)}${r.payment_id ? ` payment=${escapeHtml(r.payment_id)}` : ""}${errorText}
      </div>`;
    })
    .join("");
  target.innerHTML = summaryHtml + logsHtml;
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
  const title = toTitleCaseText(formData.get("title"));
  const amount = parsePositiveAmount(formData.get("amount"), "Amount");
  const currencyCode = String(formData.get("currency_code") || "GBP").toUpperCase();
  const paymentDate = String(formData.get("payment_date") || "");
  const categoryKey = String(formData.get("category_key") || "").trim() || null;
  const notes = String(formData.get("notes") || "").trim() || null;
  const isRecurring = String(formData.get("payment_kind") || "one_off") === "recurring";
  const fxRateRaw = formData.get("fx_rate_to_gbp");
  const fxRateToGbp = currencyCode === "GBP" ? 1 : Number(fxRateRaw || 0);
  const fxRateDate = String(formData.get("fx_rate_date") || "") || localTodayIsoDate();

  if (!title) throw new Error("Expense is required");
  if (!paymentDate) throw new Error("Payment date is required");
  if (currencyCode !== "GBP" && (!Number.isFinite(fxRateToGbp) || fxRateToGbp <= 0)) {
    throw new Error("FX rate to GBP is required for non-GBP payments");
  }

  const amountGbp = Number((amount * fxRateToGbp).toFixed(2));
  const sourceType = "one_off";
  if (state.splitMode === "custom" && !updateSplitValidationBanner(true)) {
    throw new Error("Advanced options are invalid. Check split totals.");
  }
  const paidByRows = getPaidByAllocations(amount);
  const splitRowsComputed = buildSplitRows(amount, paidByRows);

  let paymentId = state.editingPaymentId;
  let optimisticPayment = null;
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
    await maybePropagateRecurringTemplateFromPaymentEdit({
      title,
      amount,
      categoryKey,
      notes,
      paymentDate
    });
    const existing = (state.loadedPayments || []).find((p) => p.id === paymentId);
    optimisticPayment = {
      id: paymentId,
      household_id: state.householdId,
      title,
      amount,
      currency_code: currencyCode,
      fx_rate_to_gbp: fxRateToGbp,
      amount_gbp: amountGbp,
      payment_date: paymentDate,
      category_key: categoryKey,
      source_type: existing?.source_type || sourceType,
      created_by: existing?.created_by || state.currentUser.id,
      generated_by_recurring_template_id: existing?.generated_by_recurring_template_id || null,
      created_at: existing?.created_at || new Date().toISOString(),
      payment_contributions: paidByRows.map((r) => ({ user_id: r.user_id, amount: r.amount })),
      payment_splits: splitRowsComputed.map((r) => ({ user_id: r.user_id, amount: r.amount }))
    };
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
      .select("id, created_at")
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
    optimisticPayment = {
      id: payment.id,
      household_id: state.householdId,
      title,
      amount,
      currency_code: currencyCode,
      fx_rate_to_gbp: fxRateToGbp,
      amount_gbp: amountGbp,
      payment_date: paymentDate,
      category_key: categoryKey,
      source_type: sourceType,
      created_by: state.currentUser.id,
      generated_by_recurring_template_id: null,
      created_at: payment.created_at || new Date().toISOString(),
      payment_contributions: paidByRows.map((r) => ({ user_id: r.user_id, amount: r.amount })),
      payment_splits: splitRowsComputed.map((r) => ({ user_id: r.user_id, amount: r.amount }))
    };
  }

  if (!isRecurring || state.editingPaymentId) {
    return optimisticPayment ? { action: "upsert", payment: optimisticPayment } : null;
  }

  const frequency = String(formData.get("frequency") || "monthly");
  const startDate = paymentDate;
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
        last_processed_at: `${paymentDate}T23:59:59.999Z`,
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

  const { error: linkInitialError } = await state.supabase
    .schema("finance_app")
    .from("payments")
    .update({
      generated_by_recurring_template_id: template.id,
      due_date_for_generation: paymentDate
    })
    .eq("id", paymentId);
  if (linkInitialError) throw linkInitialError;

  // Prevent immediate duplicate generation for the same due date:
  // the one-off payment just saved already represents this cycle.
  const { error: seedLogError } = await state.supabase
    .schema("finance_app")
    .from("recurring_generation_log")
    .insert({
      recurring_template_id: template.id,
      due_date: paymentDate,
      payment_id: paymentId,
      status: "skipped_exists"
    });
  if (seedLogError) throw seedLogError;
  return null;
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
  const oneOffList = Array.from(new Set(counts.oneOffTitles || [])).slice(0, 5);
  const recurringList = Array.from(new Set(counts.recurringTitles || [])).slice(0, 5);

  const windowKey = lastOpenedAt;
  const alreadyShown = localStorage.getItem(STORAGE_KEYS.lastSummaryWindow) === windowKey;

  if (parts.length > 0 && !alreadyShown) {
    const listParts = [];
    if (oneOffList.length) listParts.push(`New one-offs: ${oneOffList.join(", ")}${counts.oneOffCount > oneOffList.length ? ", ..." : ""}`);
    if (recurringList.length) listParts.push(`Recurring processed: ${recurringList.join(", ")}${counts.recurringCount > recurringList.length ? ", ..." : ""}`);
    showToast(`Since last open: ${parts.join(", ")}.${listParts.length ? ` ${listParts.join(" | ")}` : ""}`);
    localStorage.setItem(STORAGE_KEYS.lastSummaryWindow, windowKey);
  }

  localStorage.setItem(STORAGE_KEYS.lastOpenedAt, nowIso);
}

async function bootstrap() {
  setupAccordion();
  setupModals();
  setSignInEnabled(false);

  const showProjectedCheckbox = document.getElementById("show-projected");
  if (showProjectedCheckbox) {
    const savedPref = localStorage.getItem("finance.showProjected");
    if (savedPref !== null) showProjectedCheckbox.checked = savedPref !== "false";
    showProjectedCheckbox.addEventListener("change", () => {
      localStorage.setItem("finance.showProjected", showProjectedCheckbox.checked);
      const loadedPayments = state.loadedPayments.slice();
      renderPayments(loadedPayments, state.lastPayerLabels, state.lastPaymentDetails, state.lastHypotheticalRows);
    });
  }

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
      if (!state.showSettledItems) {
        state.showSettledItems = true;
      }
      const more = await fetchPaymentsPage({ reset: false });
      if (!more.length) {
        state.paymentsHasMore = false;
        updateLoadMoreButton();
        return;
      }
      const loadedPayments = await fetchLoadedPayments();
      let hypotheticalRows = [];
      try {
        hypotheticalRows = await renderHypotheticalUpcoming();
      } catch (error) {
        console.error("Failed to load hypothetical rows:", error);
      }
      state.lastHypotheticalRows = hypotheticalRows.slice();
      const { payerLabels, paymentDetails } = await buildPaymentMeta(loadedPayments);
      renderPayments(loadedPayments, payerLabels, paymentDetails, hypotheticalRows);
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
    if (window.supabase?.createClient) {
      createClient = window.supabase.createClient;
    } else {
      try {
        ({ createClient } = await import("https://esm.sh/@supabase/supabase-js@2"));
      } catch {
        ({ createClient } = await import("https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm"));
      }
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

  // Load members and categories in parallel
  await Promise.all([loadMembers(), loadCategoryOptions()]);
  renderPaidByRows();
  updatePaymentNetEffectPreview();
  state.categoryManuallySet = false;
  setAuthedUI(true);

  // Load dashboard data first, show content ASAP
  await loadDashboardData();

  // Hide loading spinner, reveal app content
  const appLoading = document.getElementById("app-loading");
  if (appLoading) appLoading.classList.add("hidden");
  const appContent = document.getElementById("app-content");
  if (appContent) appContent.classList.remove("hidden");

  // Defer recurring sync and summary to after render
  setTimeout(async () => {
    try {
      const result = await processRecurringPayments();
      state.syncResult = result;
      localStorage.setItem(STORAGE_KEYS.lastSyncResult, JSON.stringify(result));
      document.getElementById("sync-status").textContent = syncResultLabel(result);
      if (result.failed > 0) {
        showToast(`Recurring sync had ${result.failed} failed item${result.failed === 1 ? "" : "s"}.`);
      }
      if (result.generated > 0) {
        // Refresh dashboard if new recurring payments were generated
        await loadDashboardData();
      }
      await runStartupSummary();
    } catch (err) {
      console.error("Background sync error:", err);
    }
  }, 0);
}

bootstrap().catch((error) => {
  console.error(error);
  const msg = formatError(error);
  setAuthHelp(`App startup failed: ${msg}`);
  showToast(`App startup failed: ${msg}`);
});
