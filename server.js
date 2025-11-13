require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const fs = require('fs');
const { exec, spawn } = require('child_process');
const os = require('os');
// Don't require electron in the server - we'll handle screen size differently
const si = require('systeminformation');

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger-output.json');
const auth = require('./Middleware/auth')
const rolecheck = require('./Middleware/roleCheck')
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: multer.memoryStorage() });
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');


const FrameLabs = express();

// Basic CORS middleware
FrameLabs.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  next();
});

FrameLabs.use(express.json());
FrameLabs.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const path = require('path');

// Serve static files from public directory
FrameLabs.use(express.static(path.join(__dirname, 'public')));

// Log all requests
FrameLabs.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

//Connect to MongoDB
const connectDB = require('./db.js');

connectDB();

//Databases Used for FrameLab Services
const communityGuide = require('./models/communityGuide');

const communityStage = require('./models/communityStage');

const communityTrial = require('./models/communityTrial');

const communityCharacter= require('./models/communityCharacter');

const playStyles = require('./models/playStyles.js');

const systemCharacter = require('./models/systemCharacter.js');

const systemTrial = require('./models/systemTrial');

const systemTutorial = require('./models/systemTutorial');

const leaderboard = require('./models/leaderboard'); 

const userAccount= require('./models/userAccount');

const user = require('./models/user');

const buttonMapping = require('./models/buttonMapping');

// Graceful shutdown route (admin only!)
FrameLabs.post('/shutdown', (req, res) => {
  res.json({ message: 'Server shutting down...' });

  // Give the response time to send before exiting
  setTimeout(() => {
    console.log('Server shutting down...');
    process.exit(0);
  }, 500);
});

FrameLabs.post('/api/login', async (req, res) => {
  const { user_name, password } = req.body;

  console.log('Login attempt:', req.body);

  try {
    const existingUser = await user.findOne({ name: user_name });
    console.log('Found user:', existingUser);

    if (!existingUser) {
      console.log('User not found');
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const isMatch = await bcrypt.compare(password, existingUser.password);
    console.log('Password match:', isMatch);

    if (!isMatch) {
      console.log('Password mismatch');
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { id: existingUser._id, role: existingUser.role || 'user' },
      process.env.JWT_SECRET,
      { expiresIn: '2h' }
    );

    console.log('Login successful, token generated');
    res.json({
      token,
      userId: existingUser._id
    });
  } catch (err) {
    console.error('Login error:', err);
    res.status(500).json({ error: 'Server error during login' });
  }
});

//Create a Community Guide
FrameLabs.post('/api/community/guide', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newGuide = await communityGuide.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newGuide);
})

//Create a Community Stage
FrameLabs.post('/api/community/stage', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newStage = await communityStage.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newStage);
})

//Create a Community Trial
FrameLabs.post('/api/community/trial', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTrial = await communityTrial.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newTrial);
})

//Create a Community Character
FrameLabs.post('/api/community/characters', async (req , res) => {
    const {name , description }  = req.body;
    if (!name || !description) {
        return res.status(400).json({ error: "Name and description are required." });
      }
    const newChara = await communityCharacter.create({
        name,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newChara);
})

//Add a new playstyle
FrameLabs.post('/api/system/playstyle', async (req, res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newStyle = await playStyles.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newStyle);
})

//Add a new playable character
FrameLabs.post('/api/system/characters', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newChara = await systemCharacter.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newChara);
})

//Add a new Combo Trial
FrameLabs.post('/api/system/trials', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTrial = await systemTrial.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newTrial);
})

//Add a new tutorial
FrameLabs.post('/api/system/tutorial', async (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTutorial = await systemTutorial.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newTutorial);
})

//Create a new leaderboard score
FrameLabs.post('/api/system/leaderboard', async (req, res) => {
    const {player_name , score }  = req.body;
    if (!player_name || !score) {
        return res.status(400).json({ error: "Player Name and Score are required." });
      }
    const newLeader = await leaderboard.create({
        player_name,
        score,
        createdAt: new Date()
      });
      res.status(201).json(newLeader);
})

FrameLabs.post('/api/user', upload.single('profilePicture'), async (req, res) => {
  try {
    const { user_name, password } = req.body;

    if (!user_name || !password || !req.file) {
      return res.status(400).json({ error: "Username, password, and profile picture are required." });
    }

    const newUser = new user({
      name: user_name,
      password,
    });
    await newUser.save();

    const newAccount = new userAccount({
      userId: newUser._id,
      name: user_name,
      profilePicture: {
        data: req.file.buffer,
        contentType: req.file.mimetype,
      },
    });
    await newAccount.save();

    res.status(201).json({ message: "User and account created successfully!" });
  } catch (err) {
    console.error('User creation error:', err);
    res.status(500).json({ error: 'Server error while creating user and account.' });
  }
});

//Create a button mapping
FrameLabs.post('/api/user/:id/controller', async (req, res) => {
    const {preset_name , preset_description }  = req.body;
    if (!preset_name || !preset_description) {
        return res.status(400).json({ error: "Preset Name and description are required." });
      }
    const newPreset = await buttonMapping.create({
        preset_name,
        preset_description,
        createdAt: new Date()
      });
      res.status(201).json(newPreset);
})

FrameLabs.post('/launch-ikemen', async (req, res) => {
  try {
    console.log('Received launch-ikemen request');
    
    // Path to Ikemen GO executable
    const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
    console.log('Ikemen path:', ikemenPath);

    if (!fs.existsSync(ikemenPath)) {
      console.error('Ikemen executable not found at:', ikemenPath);
      return res.status(500).json({ error: 'Ikemen GO executable not found' });
    }

  // Read optional target position/size from the request body (sent by the browser)
  // Expect numbers: { x, y, width, height }
  const reqX = Number.isFinite(req.body?.x) ? req.body.x : null;
  const reqY = Number.isFinite(req.body?.y) ? req.body.y : null;
  const reqW = Number.isFinite(req.body?.width) ? req.body.width : null;
  const reqH = Number.isFinite(req.body?.height) ? req.body.height : null;

  // Fixed size (use passed width/height or default)
  const gameWidth = reqW || 1280;
  const gameHeight = reqH || 720;

  // If the client provided coordinates, use them. Otherwise default to 0,0
  // Note: a browser cannot actually "embed" a native window. What we do here is
  // move the native game window to the given screen coordinates so it visually
  // overlaps the browser page area. The page should compute its element's
  // absolute screen coordinates and POST them to this endpoint.
  const targetX = reqX !== null ? reqX : 0;
  const targetY = reqY !== null ? reqY : 0;

  console.log('Setting up game window...');
  console.log('Requested position/size:', { x: targetX, y: targetY, width: gameWidth, height: gameHeight });

    // Allow client to request fullscreen instead of windowed placement
    const fullscreen = !!req.body?.fullscreen;

    // Launch args for Ikemen GO. In fullscreen mode we use fullscreen flags,
    // otherwise request windowed with the requested client size to make positioning work.
    const args = fullscreen ? [
      '-fullscreen', '1'
    ] : [
      '-windowed', '1',
      '-screenwidth', gameWidth.toString(),
      '-screenheight', gameHeight.toString()
    ];

    // PowerShell script to launch and position the window.
    // Start-Process may return before the game's main window appears; poll for the MainWindowHandle.
    const psScript = `
      $ErrorActionPreference = 'Stop'
      # Launch game and get process id
      $proc = Start-Process -FilePath '${ikemenPath}' -ArgumentList '${args.join(' ')}' -WorkingDirectory '${path.dirname(ikemenPath)}' -WindowStyle Normal -PassThru
      $gamePid = $proc.Id

      # Wait up to 10 seconds for the main window handle to be available
      $hwnd = $null
      for ($i = 0; $i -lt 20; $i++) {
        Start-Sleep -Milliseconds 500
        try {
          $p = Get-Process -Id $gamePid -ErrorAction Stop
          if ($p.MainWindowHandle -ne 0) { $hwnd = $p.MainWindowHandle; break }
        } catch {
          # process may not yet be listed; continue polling
        }
      }

      if ($hwnd) {
        Add-Type -TypeDefinition @"
          using System;
          using System.Runtime.InteropServices;
          public class Win32 {
            [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
            [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
          }
"@
        # Suppress boolean return values so PowerShell doesn't emit 'True'/'False' to stdout
        [void][Win32]::SetWindowPos([IntPtr]$hwnd, [IntPtr]::new(-1), ${targetX}, ${targetY}, ${gameWidth}, ${gameHeight}, 0x0040)
        [void][Win32]::ShowWindow([IntPtr]$hwnd, 1)
      }

  # Output the pid so Node can read it
  Write-Output $gamePid
    `;

    console.log('Executing PowerShell script to launch and position game...');
    const psProcess = spawn('powershell.exe', ['-NoProfile', '-Command', psScript], { windowsHide: false });

    let launchedPid = null;
    let errorOutput = '';

    psProcess.stdout.on('data', data => {
      const raw = data.toString();
      // PowerShell may emit multiple lines; process each
      raw.split(/\r?\n/).forEach(line => {
        const text = line.trim();
        if (!text) return;
        console.log('PowerShell stdout:', text);
        // Ignore non-informational boolean outputs from Win32 calls
        if (text === 'True' || text === 'False') return;
        const parsed = parseInt(text, 10);
        if (!isNaN(parsed) && parsed > 0) {
          launchedPid = parsed;
        } else {
          // Any other non-numeric text is appended to errorOutput
          errorOutput += text + '\n';
        }
      });
    });

    psProcess.stderr.on('data', data => {
      const text = data.toString().trim();
      console.error('PowerShell stderr:', text);
      errorOutput += text + '\n';
    });

    // Wait for the PowerShell helper to finish
    await new Promise((resolve, reject) => {
      psProcess.on('close', code => {
        console.log('PowerShell helper exit code:', code);
        if (code === 0) resolve();
        else reject(new Error(`PowerShell helper failed (code ${code}): ${errorOutput}`));
      });
    });

    // We already captured the launched PID from the script run (launchedPid).
    if (errorOutput) {
      throw new Error('Failed to launch game: ' + errorOutput);
    }

    if (!launchedPid) {
      throw new Error('Game process ID not received from PowerShell script');
    }

    console.log('Game launched successfully with PID:', launchedPid);
  // If the client requested a specific position/size and we're NOT launching fullscreen,
  // attempt to adjust the running window so the game's client area matches the requested width/height.
  if (!fullscreen && typeof targetX === 'number' && typeof targetY === 'number') {
      try {
        console.log('Attempting to position game window to', { x: targetX, y: targetY, width: gameWidth, height: gameHeight });

        const psPositionScript = `
          $ErrorActionPreference = 'Stop'
          $pid = ${launchedPid}
          $hwnd = $null
          for ($i=0; $i -lt 20; $i++) {
            Start-Sleep -Milliseconds 250
            try { $p = Get-Process -Id $pid -ErrorAction Stop; if ($p.MainWindowHandle -ne 0) { $hwnd = $p.MainWindowHandle; break } } catch { }
          }
          if (-not $hwnd) { Write-Error "Could not find main window for pid $pid"; exit 1 }

          Add-Type -TypeDefinition @"
            using System;
            using System.Runtime.InteropServices;
            public struct RECT { public int left; public int top; public int right; public int bottom; }
            public class Win32 {
              [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
              [DllImport("user32.dll")] public static extern bool AdjustWindowRectEx(ref RECT lpRect, uint dwStyle, bool bMenu, uint dwExStyle);
              [DllImport("user32.dll")] public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
            }
"@
          $style = [Win32]::GetWindowLong([IntPtr]$hwnd, -16)
          $exStyle = [Win32]::GetWindowLong([IntPtr]$hwnd, -20)

          Write-Output "FOUND_HWND:$hwnd"
          Write-Output "STYLE:$style"
          Write-Output "EXSTYLE:$exStyle"

          $rect = New-Object RECT
          $rect.left = 0; $rect.top = 0; $rect.right = ${gameWidth}; $rect.bottom = ${gameHeight}
          [void][Win32]::AdjustWindowRectEx([ref]$rect, [uint32]$style, $false, [uint32]$exStyle)

          $outerW = $rect.right - $rect.left
          $outerH = $rect.bottom - $rect.top

          Write-Output "OUTER_SIZE:${outerW},${outerH}"

          [void][Win32]::MoveWindow([IntPtr]$hwnd, ${targetX}, ${targetY}, $outerW, $outerH, $true)
          Write-Output "POSITIONED"
        `;

        const posProcess = spawn('powershell.exe', ['-NoProfile', '-Command', psPositionScript], { windowsHide: false });
        let posErr = '';
        posProcess.stdout.on('data', d => console.log('position stdout:', d.toString().trim()));
        posProcess.stderr.on('data', d => { console.error('position stderr:', d.toString().trim()); posErr += d.toString(); });

        await new Promise((resolve, reject) => {
          posProcess.on('close', code => {
            console.log('Position helper exit code:', code);
            if (code === 0) resolve(); else reject(new Error('Position helper failed: ' + posErr));
          });
        });

        console.log('Window positioned successfully');
      } catch (posErr) {
        console.warn('Window positioning failed:', posErr);
        // We don't fail the entire request if positioning fails; return success with warning
      }
    }

    res.json({ 
      success: true,
      message: 'Game launched',
      pid: launchedPid
    });

  } catch (err) {
    console.error('Error launching Ikemen GO:', err);
    res.status(500).json({ 
      error: 'Failed to launch Ikemen GO',
      details: err.message
    });
  }
});

// Reposition an already-running game's window by PID
FrameLabs.post('/position-window', async (req, res) => {
  try {
    const { pid, x, y, width, height } = req.body || {};
    if (!pid || !Number.isInteger(pid)) return res.status(400).json({ error: 'pid (integer) is required' });
    const targetX = Number.isFinite(x) ? x : 0;
    const targetY = Number.isFinite(y) ? y : 0;
    const gameWidth = Number.isFinite(width) ? width : 1280;
    const gameHeight = Number.isFinite(height) ? height : 720;

    console.log('Position request for pid', pid, '->', { x: targetX, y: targetY, width: gameWidth, height: gameHeight });

    const psPositionScript = `
      $ErrorActionPreference = 'Stop'
      $pid = ${pid}
      $hwnd = $null
      for ($i=0; $i -lt 20; $i++) {
        Start-Sleep -Milliseconds 250
        try { $p = Get-Process -Id $pid -ErrorAction Stop; if ($p.MainWindowHandle -ne 0) { $hwnd = $p.MainWindowHandle; break } } catch { }
      }
      if (-not $hwnd) { Write-Error "Could not find main window for pid $pid"; exit 1 }

      Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public struct RECT { public int left; public int top; public int right; public int bottom; }
        public class Win32 {
          [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
          [DllImport("user32.dll")] public static extern bool AdjustWindowRectEx(ref RECT lpRect, uint dwStyle, bool bMenu, uint dwExStyle);
          [DllImport("user32.dll")] public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
        }
"@

      $style = [Win32]::GetWindowLong([IntPtr]$hwnd, -16)
      $exStyle = [Win32]::GetWindowLong([IntPtr]$hwnd, -20)

      Write-Output "FOUND_HWND:$hwnd"
      Write-Output "STYLE:$style"
      Write-Output "EXSTYLE:$exStyle"

      $rect = New-Object RECT
      $rect.left = 0; $rect.top = 0; $rect.right = ${gameWidth}; $rect.bottom = ${gameHeight}
      [void][Win32]::AdjustWindowRectEx([ref]$rect, [uint32]$style, $false, [uint32]$exStyle)

      $outerW = $rect.right - $rect.left
      $outerH = $rect.bottom - $rect.top

      Write-Output "OUTER_SIZE:${outerW},${outerH}"

      [void][Win32]::MoveWindow([IntPtr]$hwnd, ${targetX}, ${targetY}, $outerW, $outerH, $true)
      Write-Output "POSITIONED"
    `;

    const posProcess = spawn('powershell.exe', ['-NoProfile', '-Command', psPositionScript], { windowsHide: false });
    let posErr = '';
    posProcess.stdout.on('data', d => console.log('position stdout:', d.toString().trim()));
    posProcess.stderr.on('data', d => { console.error('position stderr:', d.toString().trim()); posErr += d.toString(); });

    await new Promise((resolve, reject) => {
      posProcess.on('close', code => {
        console.log('Position helper exit code:', code);
        if (code === 0) resolve(); else reject(new Error('Position helper failed: ' + posErr));
      });
    });

    res.json({ success: true, message: 'Window positioned' });
  } catch (err) {
    console.error('Error positioning window:', err);
    res.status(500).json({ error: 'Failed to position window', details: err.message });
  }
});

//Return all the Community Guides
FrameLabs.get('/api/community/guide', async (req, res) => {
    try {
      const guides = await communityGuide.find(); 
      res.status(200).json(guides);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching guides' });
    }
  });

//Get a Community Guide
FrameLabs.get('/api/community/guide/:id', async (req, res) => {
    try{
        const guideID = req.params.id;
        const guide = await communityGuide.findById(guideID);
    if (guide) {
        res.json(guide);
      } else {
        res.status(404).json({ error: 'Guide not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching guide' });
    }
})


//Return all Community Stages
FrameLabs.get('/api/community/stage', async (req, res) => {
    try {
        const stages = await communityStage.find(); 
        res.status(200).json(stages);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching stages' });
      }
})

//Get a Community Stage
FrameLabs.get('/api/community/stage/:id', async (req, res) => {
    try{
        const StageID = req.params.id;
        const Stage = await communityStage.findById(StageID);
    if (Stage) {
        res.json(Stage);
      } else {
        res.status(404).json({ error: 'Stage not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching stage' });
    }
})

//Return all Community Trials
FrameLabs.get('/api/community/trial', async (req, res) => {
    try {
        const trials = await communityTrial.find(); 
        res.status(200).json(trials);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Trials' });
      }
})

//Open a Community Trial
FrameLabs.get('/api/community/trial/:id', async (req, res) => {
    try{
        const TrialID = req.params.id;
        const Trial = await communityTrial.findById(TrialID);
    if (Trial) {
        res.json(Trial);
      } else {
        res.status(404).json({ error: 'Trial not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching trial' });
    }
})

//Return all Community Characters
FrameLabs.get('/api/community/characters', async (req, res) => {
    try {
        const chara = await communityCharacter.find(); 
        res.status(200).json(chara);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Characters' });
      }
})

//Get a Community Character
FrameLabs.get('/api/community/characters/:id', async (req, res) => {
    try{
        const charaID = req.params.id;
        const chara = await communityCharacter.findById(charaID);
    if (chara) {
        res.json(chara);
      } else {
        res.status(404).json({ error: 'Character not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching Character' });
    }
})

//Return all different playstyles
FrameLabs.get('/api/system/playstyle', async (req, res) => {
    try {
        const styles = await playStyles.find(); 
        res.status(200).json(styles);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Styles' });
      }
})

//Get a Specific Playstyle
FrameLabs.get('/api/system/playstyle/:id', async (req, res) => {
    try{
        const StyleID = req.params.id;
        const styles = await playStyles.findById(StyleID);
    if (styles) {
        res.json(styles);
      } else {
        res.status(404).json({ error: 'Style not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching Styles' });
    }
})

//Return all Playable Characters
FrameLabs.get('/api/system/characters', async (req, res) => {
    try {
        const chara = await systemCharacter.find(); 
        res.status(200).json(chara);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Characters' });
      }
})

//Get a Playable Character
FrameLabs.get('/api/system/characters/:id', async (req, res) => {
    try{
        const charaID = req.params.id;
        const chara = await systemCharacter.findById(charaID);
    if (chara) {
        res.json(chara);
      } else {
        res.status(404).json({ error: 'Character not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching Character' });
    }
})

//Return all Combo Trails
FrameLabs.get('/api/system/trials', async (req, res) => {
    try {
        const trials = await systemTrial.find(); 
        res.status(200).json(trials);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Trials' });
      }
})

//Open a Combo Trial
FrameLabs.get('/api/system/trials/:id', async (req, res) => {
    try{
        const TrialID = req.params.id;
        const Trial = await systemTrial.findById(TrialID);
    if (Trial) {
        res.json(Trial);
      } else {
        res.status(404).json({ error: 'Trial not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching trial' });
    }
})

//Return all available Tutorials
FrameLabs.get('/api/system/tutorial', async (req, res) => {
    try {
        const tutorials = await systemTutorial.find(); 
        res.status(200).json(tutorials);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching Tutorials' });
      }
})

//Open a Specific Tutorial
FrameLabs.get('/api/system/tutorial/:id', async (req, res) => {
    try{
        const TutorialID = req.params.id;
        const Tutorial = await systemTutorial.findById(TutorialID);
    if (Tutorial) {
        res.json(Tutorial);
      } else {
        res.status(404).json({ error: 'Tutorial not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching tutorials' });
    }
})

//Get all Leaderboard Scores
FrameLabs.get('/api/system/leaderboard', async (req, res) => {
    try {
        const board = await leaderboard.find(); 
        res.status(200).json(board);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching leaderboard scores' });
      }
})

//Get a leaderboard score
FrameLabs.get('/api/system/leaderboard/:id', async (req, res) => {
    try{
        const boardID = req.params.id;
        const board = await leaderboard.findById(boardID);
    if (board) {
        res.json(board);
      } else {
        res.status(404).json({ error: 'Score not found' });
      }
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching leaderboard score' });
    }
})

//Get all Users
FrameLabs.get('/api/user', async (req, res) => {
  try {
      const users = await user.find(); 
      res.status(200).json(users);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Server error while fetching users' });
    }
})

// Get all user account information
FrameLabs.get('/api/user/:id/account', async (req, res) => {
  const userId = req.params.id;
  try {
    const account = await userAccount.findOne({ userId });
    if (!account) {
      return res.status(404).json({ error: 'User account not found' });
    }

    // Build response
    const response = {
      userId: account.userId,
      name: account.name,
      email: account.email || '',
      skill: account.skill || 'average',
      profilePicturePath: `/api/user/${userId}/profilePicture`,
    };

    res.json(response);
  } catch (error) {
    console.error('Error retrieving account:', error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
});


// Update user account info
FrameLabs.put('/api/user/:id/account', upload.single('profilePicture'), async (req, res) => {
  try {
    const userId = req.params.id;
    const { name, email, skill } = req.body;

    let account = await userAccount.findOne({ userId });
    if (!account) {
      return res.status(404).json({ error: 'User account not found' });
    }

    if (name) account.name = name;
    if (email) account.email = email;
    if (skill) account.skill = skill;

    if (req.file) {
      account.profilePicture = {
        data: req.file.buffer,
        contentType: req.file.mimetype
      };
    }

    await account.save();

    res.json({
      message: 'Account updated successfully',
      profilePicturePath: `/api/user/${userId}/profilePicture`
    });

  } catch (err) {
    console.error('Error updating account:', err);
    res.status(500).json({ error: 'Server error', details: err.message });
  }
});


// Get profile picture
FrameLabs.get('/api/user/:id/profilePicture', async (req, res) => {
  try {
    const userId = req.params.id;
    const account = await userAccount.findOne({ userId });

    if (!account || !account.profilePicture?.data) {
      return res.status(404).json({ error: 'Profile picture not found' });
    }

    res.contentType(account.profilePicture.contentType);
    res.send(account.profilePicture.data);
  } catch (err) {
    console.error('Error retrieving profile picture:', err);
    res.status(500).json({ error: 'Error retrieving profile picture' });
  }
});

//Get all button mapping presets
FrameLabs.get('/api/user/:id/controller', async (req, res) => {
    try {
        const mapping = await buttonMapping.find(); 
        res.status(200).json(mapping);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while fetching button presets' });
      }
})

//Get a specific button preset
FrameLabs.get('/api/user/:id/controller/:mappingid', async (req, res) => {
  const userId = req.params.id;
  const mappingId = req.params.mappingid;

  try {
    const mapping = await buttonMapping.findOne({ _id: mappingId, userId: userId });

    if (!mapping) {
      return res.status(404).json({ error: 'Preset not found or does not belong to user' });
    }

    res.status(200).json(mapping);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while fetching button preset' });
  }
});


//Delete Community Guide
FrameLabs.delete('/api/community/guide/:id', async (req, res) => {
    try {
        const guideID = req.params.id;
    
        const guide = await communityGuide.findById(guideID);
    
        if (!guide) {
          return res.status(404).json({ error: 'Guide not found' });
        }

        await guide.deleteOne();
    
        res.status(200).json(guide);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting guide' });
      }
})

//Delete Community Stage
FrameLabs.delete('/api/community/stage/:id', async (req, res) => {
    try {
        const stageID = req.params.id;
    
        const stage = await communityStage.findById(stageID);
    
        if (!stage) {
          return res.status(404).json({ error: 'Stage not found' });
        }

        await stage.deleteOne();
    
        res.status(200).json(stage);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting stage' });
      }
})

//Delete Community Trial
FrameLabs.delete('/api/community/trial/:id', async (req, res) => {
    try {
        const trialID = req.params.id;
    
        const trial = await communityTrial.findById(trialID);
    
        if (!trial) {
          return res.status(404).json({ error: 'Trial not found' });
        }

        await trial.deleteOne();
    
        res.status(200).json(trial);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting trial' });
      }
})

//Delete Community Character
FrameLabs.delete('/api/community/characters/:id', async (req, res) => {
    try {
        const charaID = req.params.id;
    
        const chara = await communityCharacter.findById(charaID);
    
        if (!chara) {
          return res.status(404).json({ error: 'Character not found' });
        }

        await chara.deleteOne();
    
        res.status(200).json(chara);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting character' });
      }
})

//Delete Playstyle
FrameLabs.delete('/api/system/playstyle/:id', async (req, res) => {
    try {
        const styleID = req.params.id;
    
        const style = await playStyles.findById(styleID);
    
        if (!style) {
          return res.status(404).json({ error: 'Playstyle not found' });
        }

        await style.deleteOne();
    
        res.status(200).json(style);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting Playstyle' });
      }
})

//Delete Playable Character
FrameLabs.delete('/api/system/characters/:id', async (req, res) => {
    try {
        const charaID = req.params.id;
    
        const chara = await systemCharacter.findById(charaID);
    
        if (!chara) {
          return res.status(404).json({ error: 'Character not found' });
        }

        await chara.deleteOne();
    
        res.status(200).json(chara);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting character' });
      }
})

//Delete Combo Trial
FrameLabs.delete('/api/system/trials/:id', async (req, res) => {
    try {
        const trialID = req.params.id;
    
        const trial = await systemTrial.findById(trialID);
    
        if (!trial) {
          return res.status(404).json({ error: 'Trial not found' });
        }

        await trial.deleteOne();
    
        res.status(200).json(trial);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting trial' });
      }
})

//Delete System Tutorial
FrameLabs.delete('/api/system/tutorial/:id', async (req, res) => {
    try {
        const tutorialID = req.params.id;
    
        const tutorial = await systemTutorial.findById(tutorialID);
    
        if (!tutorial) {
          return res.status(404).json({ error: 'Tutorial not found' });
        }

        await tutorial.deleteOne();
    
        res.status(200).json(tutorial);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting tutorial' });
      }
})

//Remove all Leaderboard Scores
FrameLabs.delete('/api/system/leaderboard', async (req, res) => {
    try {
        const board = await leaderboard.deleteMany({});

        if (board.deletedCount === 0) {
            return res.status(404).json({ error: 'No leaderboard scores to delete.' });
        }

        res.status(200).json({ message: 'Leaderboard cleared successfully.' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while clearing leaderboard' });
    }
})

//Remove a single Leaderboard Score
FrameLabs.delete('/api/system/leaderboard/:id', async (req, res) => {
    try {
        const boardID = req.params.id;
    
        const board = await leaderboard.findById(boardID);
    
        if (!board) {
          return res.status(404).json({ error: 'Score not found' });
        }

        await board.deleteOne();
    
        res.status(200).json(board);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while deleting score' });
      }
})

//Remove a button mapping preset
FrameLabs.delete('/api/user/:id/controller/:mappingid', async (req, res) => {
  const userId = req.params.id;
  const mappingId = req.params.mappingid;

  try {
    const mapping = await buttonMapping.findOne({ _id: mappingId, userId: userId });

    if (!mapping) {
      return res.status(404).json({ error: 'Preset not found or does not belong to user' });
    }

    await mapping.deleteOne();

    res.status(200).json({ message: 'Preset deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while deleting button preset' });
  }
});


//Delete a user and their account
FrameLabs.delete('/api/user/:id', async (req, res) => {
  try {
    const userId = req.params.id;

    // Delete the user
    const deletedUser = await user.findByIdAndDelete(userId);
    if (!deletedUser) {
      return res.status(404).json({ error: 'User not found.' });
    }

    // Delete the associated account
    const deletedAccount = await userAccount.findOneAndDelete({ userId: userId });
    if (!deletedAccount) {
      return res.status(404).json({ error: 'User account not found.' });
    }

    // Success
    res.status(200).json(deletedAccount); 
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while deleting user and account.' });
  }
})


//Modify Community Guide
FrameLabs.put('/api/community/guide/:id', async (req, res) => {
    try {
        const guideID = req.params.id;
        const { title, description } = req.body;
    
        const guide = await communityGuide.findById(guideID);
    
        if (!guide) {
          return res.status(404).json({ error: 'Guide not found' });
        }

        if (title) guide.title = title;
        if (description) guide.description = description;
    
        await guide.save();
    
        res.status(200).json(guide);
      } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error while updating guide' });
      }
})

//Edit a Community Stage
FrameLabs.put('/api/community/stage/:id', async (req, res) => {
  try {
    const StageID = req.params.id;
    const { title, description } = req.body;

    const stage = await communityStage.findById(StageID);

    if (!stage) {
      return res.status(404).json({ error: 'Stage not found' });
    }

    if (title) stage.title = title;
    if (description) stage.description = description;

    await stage.save();

    res.status(200).json(stage);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating guide' });
  }
});

//Edit a Community Trial
FrameLabs.put('/api/community/trial/:id', async (req, res) => {
  try {
    const trialID = req.params.id;
    const { title, description } = req.body;

    const trial = await communityTrial.findById(trialID);

    if (!trial) {
      return res.status(404).json({ error: 'Trial not found' });
    }

    if (title) trial.title = title;
    if (description) trial.description = description;

    await trial.save();

    res.status(200).json(trial);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating trial' });
  }
});

//Update a Community Character
FrameLabs.put('/api/community/characters/:id', async (req, res) => {
  try {
    const charaID = req.params.id;
    const { name, description } = req.body;

    const chara = await communityCharacter.findById(charaID);

    if (!chara) {
      return res.status(404).json({ error: 'Character not found' });
    }

    if (name) chara.name = name;
    if (description) chara.description = description;

    await chara.save();

    res.status(200).json(chara);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating character' });
  }
});

//Update a Playstyle
FrameLabs.put('/api/system/playstyle/:id', async (req, res) => {
  try {
    const styleID = req.params.id;
    const { title, description } = req.body;

    const style = await playStyles.findById(styleID);

    if (!style) {
      return res.status(404).json({ error: 'Playstyle not found' });
    }

    if (title) style.title = title;
    if (description) style.description = description;

    await style.save();

    res.status(200).json(style);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating playstyle' });
  }
});

//Update a playable character
FrameLabs.put('/api/system/characters/:id', async (req, res) => {
  try {
    const charaID = req.params.id;
    const { title, description } = req.body;

    const chara = await systemCharacter.findById(charaID);

    if (!chara) {
      return res.status(404).json({ error: 'Character not found' });
    }

    if (title) chara.title = title;
    if (description) chara.description = description;

    await chara.save();

    res.status(200).json(chara);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating character' });
  }
});

//Edit a Combo Trial
FrameLabs.put('/api/system/trials/:id', async (req, res) => {
  try {
    const trialID = req.params.id;
    const { title, description } = req.body;

    const trial = await systemTrial.findById(trialID);

    if (!trial) {
      return res.status(404).json({ error: 'Trial not found' });
    }

    if (title) trial.title = title;
    if (description) trial.description = description;

    await trial.save();

    res.status(200).json(trial);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating trial' });
  }
});

//Edit a Tutorial
FrameLabs.put('/api/system/tutorial/:id', async (req, res) => {
  try {
    const tutorialID = req.params.id;
    const { title, description } = req.body;

    const tutorial = await systemTutorial.findById(tutorialID);

    if (!tutorial) {
      return res.status(404).json({ error: 'Tutorial not found' });
    }

    if (title) tutorial.title = title;
    if (description) tutorial.description = description;

    await tutorial.save();

    res.status(200).json(tutorial);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating tutorial' });
  }
});

//Update User Account 
FrameLabs.put('/api/user/:id/account', async (req, res) => {
  try {
    const userId = req.params.id;
    const { name, profilePicture } = req.body;

    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ error: 'Invalid user ID' });
    }

    const account = await userAccount.findOne({ userId: new mongoose.Types.ObjectId(userId) });

    if (!account) {
      return res.status(404).json({ error: 'User account not found' });
    }

    if (name) account.name = name;
    if (profilePicture) account.profilePicture = profilePicture;

    await account.save();

    res.status(200).json(account);
  } catch (err) {
    console.error('Update user account error:', err);
    res.status(500).json({ error: 'Server error while updating user account' });
  }
});

//Edit Leaderboard Score
FrameLabs.put('/api/system/leaderboard/:id', async (req, res) => {
  try {
    const scoreID = req.params.id;
    const { player_name, score } = req.body;

    const leaderboardEntry = await leaderboard.findById(scoreID);

    if (!leaderboardEntry) {
      return res.status(404).json({ error: 'Score not found' });
    }

    if (player_name) leaderboardEntry.player_name = player_name;
    if (score) leaderboardEntry.score = score;

    await leaderboardEntry.save();

    res.status(200).json(leaderboardEntry);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating score' });
  }
});

//Edit Controller Mapping
FrameLabs.put('/api/user/:id/controller/:mappingid', async (req, res) => {
  const userId = req.params.id;
  const mappingId = req.params.mappingid;
  const { preset_name, preset_description } = req.body;

  try {
    const preset = await buttonMapping.findOne({ _id: mappingId, userId: userId });

    if (!preset) {
      return res.status(404).json({ error: 'Preset not found or does not belong to user' });
    }

    if (preset_name) preset.preset_name = preset_name;
    if (preset_description) preset.preset_description = preset_description;

    await preset.save();

    res.status(200).json(preset);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error while updating controller preset' });
  }
});


//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => {
  console.log(`Server running on port: ${PORT}`);
  console.log(`API Docs available at http://localhost:${PORT}/api-docs`);
  console.log(`Application running at http://localhost:${PORT}/homePage.html`);
});