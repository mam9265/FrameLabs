const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');

let mainWindow;
let gameWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1920,
        height: 1080,
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: true,
            webviewTag: true,
            preload: path.join(__dirname, 'preload.js')
        }
    });

    // Create hidden window for the game
    gameWindow = new BrowserWindow({
        width: 800,
        height: 600,
        show: false,
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false
        }
    });

    // Load the freestyle training page
    mainWindow.loadFile(path.join(__dirname, '../public/practiceModeScreens/freestyleTraining.html'));

    // Load Ikemen GO in the game window
    const ikemenPath = path.join(__dirname, '../Ikemen-GO/Ikemen_GO.exe');
    gameWindow.loadURL(`file://${ikemenPath}`);

    // Capture the game window and send it to the main window
    gameWindow.webContents.on('did-finish-load', () => {
        const stream = gameWindow.webContents.getOSProcessId();
        mainWindow.webContents.send('game-stream', stream);
    });

    mainWindow.on('closed', () => {
        mainWindow = null;
        if (gameWindow) {
            gameWindow.close();
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