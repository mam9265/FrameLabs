// Core state & helpers for Gamepad mapping; no DOM here.

const ACTIONS = [
  { key: 'moveX', type: 'axis' },
  { key: 'moveY', type: 'axis' },
  { key: 'lookX', type: 'axis' },
  { key: 'lookY', type: 'axis' },
  { key: 'jump',  type: 'button' },
  { key: 'shoot', type: 'button' },
  { key: 'dash',  type: 'button' },
  { key: 'menu',  type: 'button' },
];

// Reasonable defaults for “standard” mapping pads
const DEFAULT_MAPPING = {
  buttonBindings: { 0: ['jump'], 1: ['shoot'], 2: ['dash'], 3: ['menu'], 9: ['menu'] },
  axisBindings:   { 0: { key: 'moveX', scale: 1 }, 1: { key: 'moveY', scale: 1 }, 2: { key: 'lookX', scale: 1 }, 3: { key: 'lookY', scale: 1 } },
  options: { deadzoneLS: 0.15, deadzoneRS: 0.15, invertY: false }
};

let currentPadIndex = null;
let currentPadId = null;
let mapping = structuredClone(DEFAULT_MAPPING);

function dz(v, deadzone) { return Math.abs(v) < deadzone ? 0 : v; }

function loadMapping(padId) {
  const raw = localStorage.getItem(`mapping:${padId}`);
  mapping = raw ? JSON.parse(raw) : structuredClone(DEFAULT_MAPPING);
  return mapping;
}
function saveMapping() {
  if (!currentPadId) return;
  localStorage.setItem(`mapping:${currentPadId}`, JSON.stringify(mapping));
}

function describeBinding(actionKey) {
  for (const [btnIndex, keys] of Object.entries(mapping.buttonBindings)) {
    if (keys.includes(actionKey)) return `Button ${btnIndex}`;
  }
  for (const [axisIndex, obj] of Object.entries(mapping.axisBindings)) {
    if (obj.key === actionKey) return `Axis ${axisIndex}${(obj.scale ?? 1) < 0 ? ' (inverted)' : ''}`;
  }
  return '';
}

function getActivePad() {
  const pads = navigator.getGamepads?.() || [];
  return (currentPadIndex != null ? pads[currentPadIndex] : pads.find(Boolean)) || null;
}

function captureNextInput(pad) {
  for (let i = 0; i < pad.buttons.length; i++) {
    const b = pad.buttons[i];
    if (b.pressed || b.value > 0.7) return { type: 'button', index: i, value: 1 };
  }
  let maxMag = 0, maxIndex = -1, val = 0;
  for (let i = 0; i < pad.axes.length; i++) {
    const v = pad.axes[i], m = Math.abs(v);
    if (m > 0.6 && m > maxMag) { maxMag = m; maxIndex = i; val = v; }
  }
  return (maxIndex >= 0) ? { type: 'axis', index: maxIndex, value: val } : null;
}

function clearActionBinding(actionKey) {
  for (const [btnIdx, keys] of Object.entries(mapping.buttonBindings)) {
    const i = keys.indexOf(actionKey);
    if (i >= 0) keys.splice(i, 1);
    if (!keys.length) delete mapping.buttonBindings[btnIdx];
  }
  for (const [axisIdx, a] of Object.entries(mapping.axisBindings)) {
    if (a.key === actionKey) delete mapping.axisBindings[axisIdx];
  }
}

function bindCapturedInput(actionKey, captured) {
  if (captured.type === 'button') {
    const arr = mapping.buttonBindings[captured.index] || [];
    if (!arr.includes(actionKey)) arr.push(actionKey);
    mapping.buttonBindings[captured.index] = arr;
  } else if (captured.type === 'axis') {
    mapping.axisBindings[captured.index] = { key: actionKey, scale: Math.sign(captured.value) || 1 };
  }
  saveMapping();
}

function setOptions({ deadzoneLS, deadzoneRS, invertY }) {
  if (typeof deadzoneLS === 'number') mapping.options.deadzoneLS = deadzoneLS;
  if (typeof deadzoneRS === 'number') mapping.options.deadzoneRS = deadzoneRS;
  if (typeof invertY === 'boolean') mapping.options.invertY = invertY;
  saveMapping();
}

function getActionState() {
  const pad = getActivePad();
  const state = { moveX:0, moveY:0, lookX:0, lookY:0, jump:false, shoot:false, dash:false, menu:false };
  if (!pad) return state;

  const dzLS = mapping.options.deadzoneLS ?? 0.15;
  const dzRS = mapping.options.deadzoneRS ?? 0.15;
  const invY = !!mapping.options.invertY;

  for (const [btnIndex, keys] of Object.entries(mapping.buttonBindings)) {
    const b = pad.buttons[+btnIndex];
    const on = !!(b && (b.pressed || b.value > 0.5));
    for (const k of keys) if (typeof state[k] === 'boolean') state[k] = state[k] || on;
  }
  for (const [axisIndex, { key, scale }] of Object.entries(mapping.axisBindings)) {
    const idx = +axisIndex;
    const vRaw = pad.axes[idx] ?? 0;
    const useDZ = (idx <= 1) ? dzLS : dzRS;
    let v = dz(vRaw, useDZ) * (scale ?? 1);
    if (invY && (key === 'moveY' || key === 'lookY')) v *= -1;
    if (typeof state[key] === 'number') state[key] = v;
  }
  if (pad.mapping === 'standard') {
    const up = pad.buttons[12]?.pressed, down = pad.buttons[13]?.pressed,
          left = pad.buttons[14]?.pressed, right = pad.buttons[15]?.pressed;
    if (Math.abs(state.moveX) < 0.01) state.moveX = (right?1:0) + (left?-1:0);
    if (Math.abs(state.moveY) < 0.01) state.moveY = (down?1:0) + (up?-1:0);
  }
  return state;
}

// Expose minimal state setters/getters for the UI layer
function setCurrentPad(index, id) { currentPadIndex = index; currentPadId = id; loadMapping(id); }
function getCurrentPadInfo() { return { index: currentPadIndex, id: currentPadId }; }
function getMapping() { return mapping; }
function setMapping(newMap) { mapping = newMap; saveMapping(); }

export {
  ACTIONS,
  DEFAULT_MAPPING,
  // state
  setCurrentPad, getCurrentPadInfo, getActivePad,
  // mapping
  getMapping, setMapping, loadMapping, saveMapping, describeBinding, clearActionBinding, bindCapturedInput, setOptions,
  // input
  captureNextInput, getActionState
};
