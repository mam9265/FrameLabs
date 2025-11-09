const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

let mainWindow;
let ikemenProcess;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1920,
        height: 1080,
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
            webviewTag: true
        }
    });

    // Load the freestyle training page
    mainWindow.loadFile(path.join(__dirname, '../public/practiceModeScreens/freestyleTraining.html'));

    // Wait for the page to load before starting Ikemen GO
    mainWindow.webContents.on('did-finish-load', () => {
        // Start Ikemen-GO process
        const ikemenPath = path.join(__dirname, '../Ikemen-GO/Ikemen_GO.exe');
        ikemenProcess = spawn(ikemenPath, [], {
            windowsHide: false // We need the window to be visible to capture it
        });

        ikemenProcess.on('error', (err) => {
            console.error('Failed to start Ikemen-GO:', err);
        });

        // Give the process a moment to create its window
        setTimeout(() => {
            mainWindow.webContents.send('game-started');
        }, 2000);
    });

    mainWindow.on('closed', () => {
        mainWindow = null;
        if (ikemenProcess) {
            ikemenProcess.kill();
        }
    });
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        if (ikemenProcess) {
            ikemenProcess.kill();
        }
        app.quit();
    }
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
        createWindow();
    }
});