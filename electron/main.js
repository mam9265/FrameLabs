const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

let mainWindow;
let ikemenProcess = null;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1920,
        height: 1080,
        webPreferences: {
            // Use a preload to expose a safe API for desktopCapturer
            preload: path.join(__dirname, 'preload.js'),
            nodeIntegration: false,
            contextIsolation: true,
            webSecurity: false
        }
    });

    mainWindow.loadFile(path.join(__dirname, '../public/practiceModeScreens/freestyleTraining.html'));

    mainWindow.on('closed', () => {
        if (ikemenProcess) {
            ikemenProcess.kill();
            ikemenProcess = null;
        }
        mainWindow = null;
    });
}

function startGame() {
    if (ikemenProcess) {
        console.log('Game is already running');
        return;
    }

    const ikemenExe = path.join(__dirname, '../Ikemen-GO/Ikemen_GO.exe');
    const ikemenDir = path.join(__dirname, '../Ikemen-GO');
    
    console.log('Launching Ikemen GO from:', ikemenDir);
    
    try {
        // Start Ikemen minimized via PowerShell so it doesn't steal focus.
        // We use Start-Process -WindowStyle Minimized and capture the new process id so we can stop it later.
        try {
            const psCommand = `Start-Process -FilePath '${ikemenExe}' -WorkingDirectory '${ikemenDir}' -WindowStyle Minimized -PassThru | Select-Object -ExpandProperty Id`;
            const ps = spawn('powershell.exe', ['-NoProfile', '-Command', psCommand], { cwd: ikemenDir, env: process.env, stdio: ['ignore', 'pipe', 'pipe'] });

            let ikemenPid = null;

            ps.stdout.on('data', (data) => {
                const text = data.toString().trim();
                console.log(`PowerShell stdout: ${text}`);
                if (!ikemenPid) {
                    const parsed = parseInt(text, 10);
                    if (!isNaN(parsed)) {
                        ikemenPid = parsed;
                        console.log('Launched Ikemen PID:', ikemenPid);
                    }
                }
                if (mainWindow) mainWindow.webContents.send('game-log', text);
            });

            ps.stderr.on('data', (data) => {
                console.error(`PowerShell stderr: ${data}`);
                if (mainWindow) mainWindow.webContents.send('game-log', data.toString());
            });

            ps.on('error', (err) => {
                console.error('Failed to start PowerShell to launch Ikemen GO:', err);
                if (mainWindow) mainWindow.webContents.send('game-error', err.message);
            });

            ps.on('close', (code) => {
                console.log('PowerShell start process exited with code', code);
                // PowerShell exits after launching the game; if it failed to produce a PID we'll still notify
                if (mainWindow) {
                    // Give the game time to create its window, then tell renderer to search for it
                    setTimeout(() => mainWindow.webContents.send('game-started'), 3500);
                }
            });

            // Store reference so we can terminate Ikemen later via taskkill using the recorded PID
            ikemenProcess = { ps, pid: null, ikemenPidRef: () => ikemenPid };

            // When window closes or app quits, try to kill the launched Ikemen process if we have its PID
            const killLaunchedIkemen = () => {
                const pidToKill = ikemenPid;
                if (pidToKill) {
                    console.log('Killing Ikemen process PID:', pidToKill);
                    const killer = spawn('taskkill', ['/PID', String(pidToKill), '/T', '/F']);
                    killer.on('close', (c) => console.log('taskkill exit', c));
                }
            };

            // attach to existing exit handling below by replacing ikemenProcess with object
            ikemenProcess.killLaunched = killLaunchedIkemen;
        } catch (err) {
            console.error('Error launching Ikemen GO via PowerShell:', err);
            if (mainWindow) mainWindow.webContents.send('game-error', err.message || String(err));
        }

    } catch (error) {
        console.error('Error starting game:', error);
        if (mainWindow) {
            mainWindow.webContents.send('game-error', error.message);
        }
    }
}

// IPC handlers
ipcMain.on('start-game', () => {
    startGame();
});

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