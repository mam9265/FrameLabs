const { contextBridge, desktopCapturer, ipcRenderer } = require('electron');

// Expose protected methods that allow the renderer process to use specific APIs safely
contextBridge.exposeInMainWorld('electronAPI', {
    // Desktop Capture API for window/screen selection
    getSources: async (opts) => {
        try {
            const sources = await desktopCapturer.getSources(opts);
            return { success: true, sources };
        } catch (err) {
            return { success: false, error: err && err.message ? err.message : String(err) };
        }
    },

    // IPC for communication with main process
    ipcRenderer: {
        send: (channel, ...args) => {
            try { ipcRenderer.send(channel, ...args); } catch (e) { console.warn('IPC send failed:', e); }
        },
        on: (channel, listener) => {
            try { 
                ipcRenderer.on(channel, (event, ...args) => listener(...args));
                return () => ipcRenderer.removeListener(channel, listener);
            } catch (e) { 
                console.warn('IPC on failed:', e);
                return () => {};
            }
        },
        once: (channel, listener) => {
            try {
                ipcRenderer.once(channel, (event, ...args) => listener(...args));
            } catch (e) { 
                console.warn('IPC once failed:', e);
            }
        }
    }
});