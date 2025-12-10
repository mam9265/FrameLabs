require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const fs = require('fs');
const { exec, spawn } = require('child_process');


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
FrameLabs.use(express.json());
FrameLabs.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const path = require('path');

FrameLabs.use(express.static(path.join(__dirname, 'public')));

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

const dailyChallenge = require('./models/dailyChallenge');

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


FrameLabs.post('/launch-training-ikemen', (req, res) => {
  const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
  const cwd = path.dirname(ikemenPath);

  console.log(`Launching Ikemen GO from: ${ikemenPath}`);

  try {
    const ikemenProcess = spawn(ikemenPath, [], {
      cwd,
      env: { ...process.env, AUTOTRAIN: '1' },
    });

    // Log Ikemen output
    ikemenProcess.stdout.on('data', (data) => {
      console.log(`Ikemen: ${data.toString().trim()}`);
    });

    ikemenProcess.stderr.on('data', (data) => {
      console.error(`Ikemen Error: ${data.toString().trim()}`);
    });

    ikemenProcess.on('error', (err) => {
      console.error('Failed to start Ikemen GO:', err);
    });

    ikemenProcess.on('exit', (code, signal) => {
      console.log(`Ikemen GO exited with code ${code} (signal: ${signal})`);
      // Optional: trigger cleanup or callback logic here
    });

    // Respond to the HTTP request
  } catch (err) {
    console.error('Unexpected error:', err);
    res.status(500).json({ error: 'Failed to launch Ikemen GO' });
  }
});

FrameLabs.post('/launch-trail-ikemen', (req, res) => {
  const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
  const cwd = path.dirname(ikemenPath);

  console.log(`Launching Ikemen GO from: ${ikemenPath}`);

  try {
    // AUTOTRAIN = 2 means regular trials mode (go to character select)
    // AUTOTRAIN = 3 means daily challenge (auto-launch)
    const ikemenProcess = spawn(ikemenPath, [], {
      cwd,
      env: { ...process.env, AUTOTRAIN: '2' }, // Regular trials - go to character select
    });

    // Log Ikemen output
    ikemenProcess.stdout.on('data', (data) => {
      console.log(`Ikemen: ${data.toString().trim()}`);
    });

    ikemenProcess.stderr.on('data', (data) => {
      console.error(`Ikemen Error: ${data.toString().trim()}`);
    });

    ikemenProcess.on('error', (err) => {
      console.error('Failed to start Ikemen GO:', err);
    });

    ikemenProcess.on('exit', (code, signal) => {
      console.log(`Ikemen GO exited with code ${code} (signal: ${signal})`);
      // Optional: trigger cleanup or callback logic here
    });

  } catch (err) {
    console.error('Unexpected error:', err);
    res.status(500).json({ error: 'Failed to launch Ikemen GO' });
  }
});

FrameLabs.post('/launch-tutorial-ikemen', (req, res) => {
  const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
  const cwd = path.dirname(ikemenPath);

  console.log(`Launching Ikemen GO tutorial mode from: ${ikemenPath}`);

  try {
    const ikemenProcess = spawn(ikemenPath, [], {
      cwd,
      env: { ...process.env, AUTOTRAIN: '1', AUTOTUTORIAL: '1' },
    });

    // Log Ikemen output
    ikemenProcess.stdout.on('data', (data) => {
      console.log(`Ikemen: ${data.toString().trim()}`);
    });

    ikemenProcess.stderr.on('data', (data) => {
      console.error(`Ikemen Error: ${data.toString().trim()}`);
    });

    ikemenProcess.on('error', (err) => {
      console.error('Failed to start Ikemen GO:', err);
    });

    ikemenProcess.on('exit', (code, signal) => {
      console.log(`Ikemen GO exited with code ${code} (signal: ${signal})`);
      // Optional: trigger cleanup or callback logic here
    });

  } catch (err) {
    console.error('Unexpected error:', err);
    res.status(500).json({ error: 'Failed to launch Ikemen GO' });
  }
});

FrameLabs.post('/launch-ikemen', (req, res) => {
  const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
  const cwd = path.dirname(ikemenPath);

  if (!fs.existsSync(ikemenPath)) {
    console.error(`Ikemen executable not found at path: ${ikemenPath}`);
    return res.status(404).json({ error: 'Ikemen executable not found' });
  }

  console.log('Received request to launch Ikemen GO with payload:', req.body);

  try {
    const ikemenProcess = spawn(ikemenPath, [], {
      cwd,
      env: { ...process.env, AUTOTRAIN: '1' },
      detached: false,
    });

    ikemenProcess.stdout.on('data', (data) => {
      console.log(`Ikemen: ${data.toString().trim()}`);
    });

    ikemenProcess.stderr.on('data', (data) => {
      console.error(`Ikemen Error: ${data.toString().trim()}`);
    });

    ikemenProcess.on('error', (err) => {
      console.error('Failed to start Ikemen GO:', err);
    });

    ikemenProcess.on('exit', (code, signal) => {
      console.log(`Ikemen GO exited with code ${code} (signal: ${signal})`);
    });

    res.status(200).json({
      pid: ikemenProcess.pid,
    });
  } catch (err) {
    console.error('Unexpected error launching Ikemen GO:', err);
    res.status(500).json({ error: 'Failed to launch Ikemen GO' });
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

// Controller Config API Endpoints (for controlConfig.html)
// These endpoints work with the local JSON file format used in controlConfig.html

// Get all controller configs
FrameLabs.get('/api/controller-configs', async (req, res) => {
  try {
    const configPath = path.join(__dirname, 'Ikemen-GO', 'save', 'config.json');
    
    if (!fs.existsSync(configPath)) {
      return res.status(200).json({});
    }

    const configs = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    res.status(200).json(configs);
  } catch (err) {
    console.error('Error loading controller configs:', err);
    res.status(500).json({ error: 'Server error while loading controller configs' });
  }
});

// Get a specific controller config by name
FrameLabs.get('/api/controller-configs/:name', async (req, res) => {
  try {
    const configName = decodeURIComponent(req.params.name);
    const configPath = path.join(__dirname, 'Ikemen-GO', 'save', 'config.json');
    
    if (!fs.existsSync(configPath)) {
      return res.status(404).json({ error: 'Config file not found' });
    }

    const configs = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    
    if (!configs[configName]) {
      return res.status(404).json({ error: 'Controller config not found' });
    }

    res.status(200).json(configs[configName]);
  } catch (err) {
    console.error('Error loading controller config:', err);
    res.status(500).json({ error: 'Server error while loading controller config' });
  }
});

// Save/Update a controller config
FrameLabs.post('/api/controller-configs', async (req, res) => {
  try {
    const { name, config } = req.body;
    
    if (!name || !config) {
      return res.status(400).json({ error: 'Name and config data are required' });
    }

    const configPath = path.join(__dirname, 'Ikemen-GO', 'save', 'config.json');
    const configDir = path.dirname(configPath);

    // Ensure directory exists
    if (!fs.existsSync(configDir)) {
      fs.mkdirSync(configDir, { recursive: true });
    }

    // Load existing configs or create new object
    let configs = {};
    if (fs.existsSync(configPath)) {
      try {
        configs = JSON.parse(fs.readFileSync(configPath, 'utf8'));
      } catch (err) {
        console.warn('Error parsing existing config file, creating new one:', err);
        configs = {};
      }
    }

    // Update or add the new config
    configs[name] = config;

    // Write back to file
    fs.writeFileSync(configPath, JSON.stringify(configs, null, 2));

    res.status(200).json({ message: 'Controller config saved successfully', name, config });
  } catch (err) {
    console.error('Error saving controller config:', err);
    res.status(500).json({ error: 'Server error while saving controller config' });
  }
});

// Delete a controller config
FrameLabs.delete('/api/controller-configs/:name', async (req, res) => {
  try {
    const configName = decodeURIComponent(req.params.name);
    const configPath = path.join(__dirname, 'Ikemen-GO', 'save', 'config.json');
    
    if (!fs.existsSync(configPath)) {
      return res.status(404).json({ error: 'Config file not found' });
    }

    const configs = JSON.parse(fs.readFileSync(configPath, 'utf8'));
    
    if (!configs[configName]) {
      return res.status(404).json({ error: 'Controller config not found' });
    }

    delete configs[configName];
    fs.writeFileSync(configPath, JSON.stringify(configs, null, 2));

    res.status(200).json({ message: 'Controller config deleted successfully', name: configName });
  } catch (err) {
    console.error('Error deleting controller config:', err);
    res.status(500).json({ error: 'Server error while deleting controller config' });
  }
});

// Helper function to get available characters from select.def
function getAvailableCharacters() {
  try {
    const selectDefPath = path.join(__dirname, 'Ikemen-GO', 'data', 'select.def');
    const content = fs.readFileSync(selectDefPath, 'utf8');
    const characters = [];
    
    // Parse select.def to extract character names
    const lines = content.split('\n');
    let inCharactersSection = false;
    
    for (const line of lines) {
      const trimmed = line.trim();
      
      // Check if we're in the [Characters] section
      if (trimmed === '[Characters]') {
        inCharactersSection = true;
        continue;
      }
      
      // Check if we've moved to another section
      if (trimmed.startsWith('[') && trimmed !== '[Characters]') {
        inCharactersSection = false;
        continue;
      }
      
      // Skip comments and empty lines
      if (!inCharactersSection || trimmed.startsWith(';') || trimmed === '' || trimmed === 'randomselect') {
        continue;
      }
      
      // Extract character name (first part before comma)
      const match = trimmed.match(/^([^,]+)/);
      if (match) {
        let charName = match[1].trim();
        
        // Remove .def extension if present, but preserve the full path
        // This is important for characters in subdirectories like "MortalKombatII_SHAOKAHN_Playable/MUGEN_Size.def"
        charName = charName.replace(/\.def$/i, '');
        
        // Clean up the name (remove extra spaces, etc.)
        charName = charName.trim();
        
        if (charName && charName !== 'randomselect' && charName.length > 0) {
          characters.push(charName);
        }
      }
    }
    
    return characters.filter((char, index, self) => self.indexOf(char) === index); // Remove duplicates
  } catch (err) {
    console.error('Error reading select.def:', err);
    // Fallback to known characters
    return ['kfmZ', 'Lilith_YX'];
  }
}

// Helper function to get or create today's daily challenge
async function getOrCreateDailyChallenge() {
  const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD format
  
  let challenge = await dailyChallenge.findOne({ date: today });
  
  if (!challenge) {
    // Get available characters
    const availableChars = getAvailableCharacters();
    
    if (availableChars.length === 0) {
      throw new Error('No characters available for daily challenge');
    }
    
    // Select a random character
    const randomChar = availableChars[Math.floor(Math.random() * availableChars.length)];
    
    // Create new daily challenge
    challenge = new dailyChallenge({
      date: today,
      character: randomChar,
      completedBy: [],
    });
    
    await challenge.save();
  }
  
  return challenge;
}

// Get today's daily challenge
FrameLabs.get('/api/daily-challenge', async (req, res) => {
  try {
    const challenge = await getOrCreateDailyChallenge();
    
    res.status(200).json({
      date: challenge.date,
      character: challenge.character,
      completedCount: challenge.completedBy.length,
    });
  } catch (err) {
    console.error('Error getting daily challenge:', err);
    res.status(500).json({ error: 'Server error while getting daily challenge' });
  }
});

// Check if user has completed today's daily challenge
FrameLabs.get('/api/daily-challenge/status/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const challenge = await getOrCreateDailyChallenge();
    
    const userCompletion = challenge.completedBy.find(
      completion => completion.userId.toString() === userId
    );
    
    const completedTrials = userCompletion && userCompletion.completedTrials 
      ? userCompletion.completedTrials 
      : [];
    
    res.status(200).json({
      completed: completedTrials.length > 0,
      completedTrials: completedTrials,
      trialsCompleted: completedTrials.length,
      date: challenge.date,
      character: challenge.character,
    });
  } catch (err) {
    console.error('Error checking daily challenge status:', err);
    res.status(500).json({ error: 'Server error while checking daily challenge status' });
  }
});

// Launch trial mode with daily challenge character
FrameLabs.post('/api/daily-challenge/launch', async (req, res) => {
  try {
    const { userId } = req.body; // Get userId from request
    const challenge = await getOrCreateDailyChallenge();
    const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');
    const cwd = path.dirname(ikemenPath);
    const configPath = path.join(cwd, 'save', 'config.json');
    
    console.log(`Launching daily challenge trial mode with character: ${challenge.character}`);
    
    // Remove any existing trial completion files
    for (let i = 1; i <= 100; i++) { // Check up to 100 trials
      const trialFile = path.join(cwd, `daily_challenge_trial_${i}_complete.txt`);
      if (fs.existsSync(trialFile)) {
        fs.unlinkSync(trialFile);
      }
    }
    
    // Update config.json to set TrainingChar for trial mode
    let config = {};
    if (fs.existsSync(configPath)) {
      try {
        config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
      } catch (err) {
        console.warn('Error parsing config.json, creating new one:', err);
      }
    }
    
    // Store original TrainingChar to restore later (optional)
    const originalTrainingChar = config.TrainingChar || '';
    
    // Set the daily challenge character
    config.TrainingChar = challenge.character;
    
    // Write updated config
    fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
    
    // Set environment variables for trial mode
    const env = {
      ...process.env,
      AUTOTRAIN: '3', // Daily challenge mode (auto-launch)
    };
    
    const ikemenProcess = spawn(ikemenPath, [], {
      cwd,
      env,
    });
    
    // Log Ikemen output
    ikemenProcess.stdout.on('data', (data) => {
      console.log(`Ikemen: ${data.toString().trim()}`);
    });
    
    ikemenProcess.stderr.on('data', (data) => {
      console.error(`Ikemen Error: ${data.toString().trim()}`);
    });
    
    ikemenProcess.on('error', (err) => {
      console.error('Failed to start Ikemen GO:', err);
      // Restore original TrainingChar on error
      if (originalTrainingChar !== undefined) {
        config.TrainingChar = originalTrainingChar;
        fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
      }
    });
    
    ikemenProcess.on('exit', async (code, signal) => {
      console.log(`Ikemen GO exited with code ${code} (signal: ${signal})`);
      
      // Check for individual trial completion files and award points incrementally
      if (userId) {
        try {
          const account = await userAccount.findOne({ userId: userId });
          if (!account) {
            console.log('User account not found, skipping point awards');
            return;
          }
          
          // Get the challenge once outside the loop
          const challengeCheck = await getOrCreateDailyChallenge();
          
          let totalPointsAwarded = 0;
          let trialsCompleted = [];
          
          // Check for trial completion files (up to 100 trials)
          for (let i = 1; i <= 100; i++) {
            const trialFile = path.join(cwd, `daily_challenge_trial_${i}_complete.txt`);
            if (fs.existsSync(trialFile)) {
              trialsCompleted.push(i);
              
              const userCompletion = challengeCheck.completedBy.find(
                c => c.userId.toString() === userId
              );
              
              // Check if this specific trial was already awarded
              const alreadyAwarded = userCompletion && 
                userCompletion.completedTrials && 
                userCompletion.completedTrials.includes(i);
              
              if (!alreadyAwarded) {
                // Award 100 points for this trial
                const pointsBefore = account.points || 0;
                account.points = pointsBefore + 100;
                totalPointsAwarded += 100;
                
                // Track which trials were completed
                if (!userCompletion) {
                  challengeCheck.completedBy.push({
                    userId: userId,
                    completedAt: new Date(),
                    completedTrials: [i],
                  });
                } else {
                  if (!userCompletion.completedTrials) {
                    userCompletion.completedTrials = [];
                  }
                  userCompletion.completedTrials.push(i);
                }
                
                // Clean up the trial completion file
                fs.unlinkSync(trialFile);
              } else {
                // Already awarded, just clean up the file
                fs.unlinkSync(trialFile);
              }
            }
          }
          
          if (totalPointsAwarded > 0) {
            await account.save();
            await challengeCheck.save();
            
            // Update or create leaderboard entry
            let leaderboardEntry = await leaderboard.findOne({ player_name: account.name });
            if (leaderboardEntry) {
              leaderboardEntry.score = account.points;
            } else {
              leaderboardEntry = new leaderboard({
                player_name: account.name,
                score: account.points,
              });
            }
            await leaderboardEntry.save();
            
            console.log(`✅ Daily Challenge Trials Completed! User: ${account.name} earned ${totalPointsAwarded} points (${trialsCompleted.length} trial(s): ${trialsCompleted.join(', ')}). Total points: ${(account.points || 0) - totalPointsAwarded} → ${account.points}`);
          }
        } catch (err) {
          console.error('Error awarding trial completion points:', err);
        }
      }
      
      // Optionally restore original TrainingChar after exit
      // Uncomment if you want to restore it:
      // if (originalTrainingChar !== undefined) {
      //   config.TrainingChar = originalTrainingChar;
      //   fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
      // }
    });
    
    res.status(200).json({
      message: 'Daily challenge trial mode launched',
      character: challenge.character,
      date: challenge.date,
    });
  } catch (err) {
    console.error('Error launching daily challenge:', err);
    res.status(500).json({ error: 'Server error while launching daily challenge' });
  }
});

// Complete daily challenge and award points
FrameLabs.post('/api/daily-challenge/complete', async (req, res) => {
  try {
    const { userId } = req.body;
    
    if (!userId) {
      return res.status(400).json({ error: 'User ID is required' });
    }
    
    const challenge = await getOrCreateDailyChallenge();
    
    // Check if user has already completed today's challenge
    const hasCompleted = challenge.completedBy.some(
      completion => completion.userId.toString() === userId
    );
    
    if (hasCompleted) {
      return res.status(400).json({ error: 'Daily challenge already completed for today' });
    }
    
    // Add user to completedBy array
    challenge.completedBy.push({
      userId: userId,
      completedAt: new Date(),
    });
    await challenge.save();
    
    // Award 100 points to user account
    const account = await userAccount.findOne({ userId: userId });
    if (!account) {
      return res.status(404).json({ error: 'User account not found' });
    }
    
    const pointsBefore = account.points || 0;
    account.points = pointsBefore + 100;
    await account.save();
    
    console.log(`✅ Daily Challenge Completed! User: ${account.name} earned 100 points. Total points: ${pointsBefore} → ${account.points}`);
    
    // Update or create leaderboard entry
    let leaderboardEntry = await leaderboard.findOne({ player_name: account.name });
    if (leaderboardEntry) {
      leaderboardEntry.score = account.points;
    } else {
      leaderboardEntry = new leaderboard({
        player_name: account.name,
        score: account.points,
      });
    }
    await leaderboardEntry.save();
    
    res.status(200).json({
      message: 'Daily challenge completed! You earned 100 points.',
      pointsAwarded: 100,
      totalPoints: account.points,
      character: challenge.character,
      date: challenge.date,
    });
  } catch (err) {
    console.error('Error completing daily challenge:', err);
    res.status(500).json({ error: 'Server error while completing daily challenge' });
  }
});

// Get daily challenge leaderboard (users with most points from daily challenges)
FrameLabs.get('/api/daily-challenge/leaderboard', async (req, res) => {
  try {
    const accounts = await userAccount.find({ points: { $gt: 0 } })
      .sort({ points: -1 })
      .limit(100)
      .select('name points userId');
    
    const leaderboardData = accounts.map(account => ({
      player_name: account.name,
      score: account.points,
      userId: account.userId,
    }));
    
    res.status(200).json(leaderboardData);
  } catch (err) {
    console.error('Error getting daily challenge leaderboard:', err);
    res.status(500).json({ error: 'Server error while getting leaderboard' });
  }
});

//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => {
  console.log(`Server running on port: ${PORT}`);
  console.log(`API Docs available at http://localhost:${PORT}/api-docs`);
  console.log(`Application running at http://localhost:${PORT}/homePage.html`);
});