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
const upload = multer({ storage });
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
    res.json({ token });
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

const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');


//Launch Ikemen GO
FrameLabs.post('/launch-ikemen', (req, res) => {
  try {
      // Path to the Ikemen GO executable
      const ikemenPath = path.join(__dirname, 'Ikemen-GO', 'Ikemen_GO.exe');

      // Optional: automatically detect primary screen resolution
      // For now, set manually
      const screenWidth = 1920;
      const screenHeight = 1080;

      // Command-line arguments for fullscreen and proper zoom
      const args = [
          '-fullscreen', '1',
          '-screenwidth', screenWidth,
          '-screenheight', screenHeight,
          '-zoom', '1'
      ];

      // Spawn the process
      const ikemenProcess = spawn(ikemenPath, args, { cwd: path.dirname(ikemenPath) });

      // Optional: listen for stdout/stderr
      ikemenProcess.stdout.on('data', (data) => {
          console.log(`Ikemen GO stdout: ${data}`);
      });

      ikemenProcess.stderr.on('data', (data) => {
          console.error(`Ikemen GO stderr: ${data}`);
      });

      ikemenProcess.on('close', (code) => {
          console.log(`Ikemen GO exited with code ${code}`);
      });

      res.json({ message: 'Ikemen GO launched!' });

  } catch (err) {
      console.error('Error launching Ikemen GO:', err);
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

//Get all user account information
FrameLabs.get('/api/user/:id/account', async (req, res) => {
    const userId = req.params.id;
    try {
      const account = await userAccount.findOne({ userId: userId });
      if (account) {
          res.json(account);
      } else {
          res.status(404).json({ error: 'User account not found' });
      }
  } catch (error) {
      res.status(500).json({ error: 'Server error', details: error.message });
  }
})

FrameLabs.get('/api/user/:id/profilePicture', async (req, res) => {
  try {
    const userId = req.params.id;
    console.log('GET profilePicture for userId =', userId);

    const account = await userAccount.findOne({ userId });
    console.log('Account found:', account);

    if (!account || !account.profilePicture || !account.profilePicture.data) {
      console.warn('Profile picture not found for userId', userId);
      return res.status(404).json({ error: 'Profile picture not found' });
    }

    console.log('Sending picture contentType =', account.profilePicture.contentType);
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