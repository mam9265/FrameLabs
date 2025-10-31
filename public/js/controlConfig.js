import {
    ACTIONS, getActivePad, getCurrentPadInfo, setCurrentPad,
    getMapping, setMapping, loadMapping, saveMapping, describeBinding,
    clearActionBinding, bindCapturedInput, setOptions,
    captureNextInput, getActionState
  } from '/js/gamepad-core.js';
  
  // DOM
  const el = {
    status:  document.getElementById('status'),
    padId:   document.getElementById('pad-id'),
    mapping: document.getElementById('mapping'),
    buttons: document.getElementById('buttons'),
    axes:    document.getElementById('axes'),
    body:    document.getElementById('actions-body'),
    json:    document.getElementById('json'),
    dzLS:    document.getElementById('dz-ls'),
    dzLSv:   document.getElementById('dz-ls-val'),
    dzRS:    document.getElementById('dz-rs'),
    dzRSv:   document.getElementById('dz-rs-val'),
    invertY: document.getElementById('invert-y'),
    btnExport:  document.getElementById('btn-export'),
    fileImport: document.getElementById('file-import'),
    btnClear:   document.getElementById('btn-clear'),
  };
  
  let raf = 0;
  let rebindingKey = null;
  
  function applyOptionsToUI() {
    const m = getMapping();
    el.dzLS.value = m.options.deadzoneLS ?? 0.15;
    el.dzRS.value = m.options.deadzoneRS ?? 0.15;
    el.invertY.checked = !!m.options.invertY;
    el.dzLSv.textContent = (+el.dzLS.value).toFixed(2);
    el.dzRSv.textContent = (+el.dzRS.value).toFixed(2);
  }
  
  function renderActionsTable() {
    el.body.innerHTML = '';
    for (const action of ACTIONS) {
      const tr = document.createElement('tr');
      const tdA = document.createElement('td');
      const tdB = document.createElement('td');
      const tdC = document.createElement('td');
  
      tdA.textContent = action.key;
  
      tdB.innerHTML = `<span class="kbd">${describeBinding(action.key) || 'Unbound'}</span>`;
  
      const btn = document.createElement('button');
      btn.className = 'btn small';
      btn.textContent = (rebindingKey === action.key) ? 'Press a control…' : 'Rebind';
      btn.disabled = !!rebindingKey && rebindingKey !== action.key;
      btn.addEventListener('click', () => {
        rebindingKey = (rebindingKey === action.key) ? null : action.key;
        renderActionsTable();
      });
      tdC.appendChild(btn);
  
      tr.appendChild(tdA); tr.appendChild(tdB); tr.appendChild(tdC);
      el.body.appendChild(tr);
    }
  }
  
  function renderJSON() {
    const { id } = getCurrentPadInfo();
    el.json.textContent = JSON.stringify({ padId: id, mapping: getMapping() }, null, 2);
  }
  
  function showLiveInputs(pad) {
    const pressed = [];
    pad.buttons.forEach((b, i) => { if (b.pressed || b.value > 0.5) pressed.push(i); });
    el.buttons.innerHTML = pressed.length
      ? pressed.map(i => `<span class="tag">B${i}</span>`).join(' ')
      : `<span class="muted">No buttons</span>`;
    const ax = pad.axes.map(v => v.toFixed(2));
    el.axes.textContent = `Axes: [ ${ax.join(' , ')} ]`;
  }
  
  function tick() {
    const pad = getActivePad();
    if (!pad) {
      el.status.textContent = 'Waiting… press any button';
      el.padId.textContent = '—';
      el.mapping.textContent = '—';
      raf = requestAnimationFrame(tick);
      return;
    }
  
    const info = getCurrentPadInfo();
    if (info.id !== pad.id) {
      setCurrentPad(pad.index, pad.id);
      el.status.textContent = 'Connected';
      el.padId.textContent = pad.id;
      el.mapping.textContent = pad.mapping || 'none';
      loadMapping(pad.id);
      applyOptionsToUI();
      renderActionsTable();
      renderJSON();
    }
  
    if (rebindingKey) {
      const captured = captureNextInput(pad);
      if (captured) {
        clearActionBinding(rebindingKey);
        bindCapturedInput(rebindingKey, captured);
        rebindingKey = null;
        renderActionsTable();
        renderJSON();
      }
    }
  
    showLiveInputs(pad);
    raf = requestAnimationFrame(tick);
  }
  
  // Options
  el.dzLS.addEventListener('input', () => {
    el.dzLSv.textContent = (+el.dzLS.value).toFixed(2);
    setOptions({ deadzoneLS: +el.dzLS.value });
    renderJSON();
  });
  el.dzRS.addEventListener('input', () => {
    el.dzRSv.textContent = (+el.dzRS.value).toFixed(2);
    setOptions({ deadzoneRS: +el.dzRS.value });
    renderJSON();
  });
  el.invertY.addEventListener('change', () => {
    setOptions({ invertY: !!el.invertY.checked });
    renderJSON();
  });
  
  // Export / Import / Clear
  el.btnExport.addEventListener('click', () => {
    const { id } = getCurrentPadInfo();
    const blob = new Blob([JSON.stringify({ padId: id, mapping: getMapping() }, null, 2)], { type: 'application/json' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = `controller-mapping-${(id||'unknown').replace(/[^\w.-]+/g,'_')}.json`;
    document.body.appendChild(a); a.click(); a.remove();
    URL.revokeObjectURL(url);
  });
  
  el.fileImport.addEventListener('change', async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    try {
      const text = await file.text();
      const data = JSON.parse(text);
      if (!data || !data.mapping) throw new Error('Invalid mapping file');
      setMapping(data.mapping);
      applyOptionsToUI();
      renderActionsTable();
      renderJSON();
    } catch (err) {
      alert('Import failed: ' + err.message);
    } finally {
      e.target.value = '';
    }
  });
  
  el.btnClear.addEventListener('click', () => {
    const { id } = getCurrentPadInfo();
    if (!id) return;
    localStorage.removeItem(`mapping:${id}`);
    loadMapping(id);
    applyOptionsToUI();
    renderActionsTable();
    renderJSON();
  });
  
  // Connect/Disconnect
  window.addEventListener('gamepadconnected', (e) => {
    setCurrentPad(e.gamepad.index, e.gamepad.id);
    el.status.textContent = 'Connected';
    el.padId.textContent = e.gamepad.id;
    el.mapping.textContent = e.gamepad.mapping || 'none';
    loadMapping(e.gamepad.id);
    applyOptionsToUI();
    renderActionsTable();
    renderJSON();
  });
  window.addEventListener('gamepaddisconnected', (e) => {
    const info = getCurrentPadInfo();
    if (e.gamepad.index === info.index) {
      el.status.textContent = 'Disconnected';
      el.padId.textContent = '—';
      el.mapping.textContent = '—';
    }
  });
  
  // Kick off polling so we catch already-connected pads
  applyOptionsToUI();
  renderActionsTable();
  raf = requestAnimationFrame(tick);
  
  // (Optional) Re-export for your game code to use directly if needed:
  export { getActionState };
  