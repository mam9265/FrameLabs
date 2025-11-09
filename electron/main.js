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
        const ikemenExe = path.join(__dirname, '../Ikemen-GO/Ikemen_GO.exe');
        console.log('Launching Ikemen GO using:', ikemenExe);

        // Change working directory to Ikemen-GO folder to ensure DLLs are found
        const ikemenDir = path.join(__dirname, '../Ikemen-GO');
        
        // Use PowerShell to start the process
        ikemenProcess = spawn('powershell.exe', [
            '-Command',
            `Start-Process -FilePath '${ikemenExe}' -WorkingDirectory '${ikemenDir}' -NoNewWindow -PassThru`
        ], {
            windowsHide: false,
            cwd: ikemenDir,
            env: process.env
        });

        ikemenProcess.stdout.on('data', (data) => {
            console.log(`PowerShell stdout: ${data}`);
        });

        ikemenProcess.stderr.on('data', (data) => {
            console.error(`PowerShell stderr: ${data}`);
        });

        ikemenProcess.on('error', (err) => {
            console.error('Failed to start PowerShell:', err);
            mainWindow.webContents.send('game-error', err.message);
        });

        ikemenProcess.on('exit', (code, signal) => {
            if (code === 0) {
                // PowerShell started successfully, now wait for the game window
                setTimeout(() => {
                    mainWindow.webContents.send('game-started');
                }, 3000);
            } else {
                console.error(`PowerShell process exited with code ${code} and signal ${signal}`);
                mainWindow.webContents.send('game-error', `Failed to start game (exit code ${code})`);
            }
        });
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