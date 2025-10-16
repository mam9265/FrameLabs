const express = require('express');

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger-output.json');

const FrameLabs = express();
FrameLabs.use(express.json());
FrameLabs.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

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
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newChara = await communityCharacter.create({
        title,
        description,
        createdAt: new Date()
      });
      res.status(201).json(newChara);
})

//Add a new playstyle
FrameLabs.post('api/system/playstyle', async (req, res) => {
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
FrameLabs.post('api/system/characters', async (req , res) => {
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
FrameLabs.post('api/system/trials', async (req , res) => {
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
FrameLabs.post('api/system/tutorial', async (req , res) => {
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
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newLeader = await leaderboard.create({
        player_name,
        score,
        createdAt: new Date()
      });
      res.status(201).json(newLeader);
})

//Create a new user and the user's account
FrameLabs.post('/api/user', async (req, res) => {
    const {user_name, password, profilePicture } = req.body;
    if (!user_name || !password || !profilePicture) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newUser = await user.create({
        user_name,
        password,
        createdAt: new Date()
      });
      res.status(201).json(newUser);

    const newAccount = await userAccount.create({
        user_name,
        profilePicture,
        createdAt: new Date()
    });
    res.status(201).json(newAccount)
})

//Create a button mapping
FrameLabs.post('/api/user/:id/controller', async (req, res) => {
    const {preset_name , preset_description }  = req.body;
    if (!preset_name || !preset_description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newPreset = await buttonMapping.create({
        preset_name,
        preset_description,
        createdAt: new Date()
      });
      res.status(201).json(newPreset);
})

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
    const stages = await communityStage.find({});
    res.json(stages);
})

//Get a Community Stage
FrameLabs.get('/api/community/stage/:id', async (req, res) => {
    const stage = await communityStage.findById(req.params.id);
    if (stage) {
        res.json(stage);
    } else {
        res.status(404).json({ error: 'Stage not found' });
    }
})

//Return all Community Trials
FrameLabs.get('/api/community/trial', async (req, res) => {
    const trials = await communityTrial.find({});
    res.json(trials);
})

//Open a Community Trial
FrameLabs.get('/api/community/trial/:id', async (req, res) => {
    const trial = await communityTrial.findById(req.params.id);
    if (trial) {
        res.json(trial);
    } else {
        res.status(404).json({ error: 'Trial not found' });
    }
})

//Return all Community Characters
FrameLabs.get('/api/community/characters', async (req, res) => {
    const characters = await communityCharacter.find({});
    res.json(characters);
})

//Get a Community Character
FrameLabs.get('/api/community/characters/:id', async (req, res) => {
    const character = await communityCharacter.findById(req.params.id);
    if (character) {
        res.json(character);
    } else {
        res.status(404).json({ error: 'Character not found' });
    }
})

//Return all different playstyles
FrameLabs.get('/api/system/playstyle', async (req, res) => {
    const styles = await playStyles.find({});
    res.json(styles);
})

//Get a Specific Playstyle
FrameLabs.get('/api/system/playstyle/:id', async (req, res) => {
    const style = await playStyles.findById(req.params.id);
    if (style) {
        res.json(style);
    } else {
        res.status(404).json({ error: 'Style not found' });
    }
})

//Return all Playable Characters
FrameLabs.get('/api/system/characters', async (req, res) => {
    const characters = await systemCharacter.find({});
    res.json(characters);
})

//Get a Playable Character
FrameLabs.get('/api/system/characters/:id', async (req, res) => {
    const character = await systemCharacter.findById(req.params.id);
    if (character) {
        res.json(character);
    } else {
        res.status(404).json({ error: 'Character not found' });
    }
})

//Return all Combo Trails
FrameLabs.get('/api/system/trials', async (req, res) => {
    const trials = await systemTrial.find({});
    res.json(trials);
})

//Open a Combo Trial
FrameLabs.get('/api/system/trials/:id', async (req, res) => {
    const trial = await systemTrial.findById(req.params.id);
    if (trial) {
        res.json(trial);
    } else {
        res.status(404).json({ error: 'Trial not found' });
    }
})

//Return all available Tutorials
FrameLabs.get('/api/system/tutorial', async (req, res) => {
    const tutorials = await systemTutorial.find({});
    res.json(tutorials);
})

//Open a Specific Tutorial
FrameLabs.get('/api/system/tutorial/:id', async (req, res) => {
    const tutorial = await systemTutorial.findById(req.params.id);
    if (tutorial) {
        res.json(tutorial);
    } else {
        res.status(404).json({ error: 'Tutorial not found' });
    }
})

//Get all Leaderboard Scores
FrameLabs.get('/api/system/leaderboard', async (req, res) => {
    const scores = await leaderboard.find({});
    res.json(scores);
})

//Get a leaderboard score
FrameLabs.get('/api/system/leaderboard/:id', async (req, res) => {
    const score = await leaderboard.findById(req.params.id);
    if (score) {
        res.json(score);
    } else {
        res.status(404).json({ error: 'Leaderboard Score not found' });
    }
})

//Get all user account information
FrameLabs.get('/api/user/:id/account', async (req, res) => {
    const userInfo = await user.findById(req.params.id);
    if (userInfo) {
        res.json(userInfo);
    } else {
        res.status(404).json({ error: 'User not found' });
    }
})

//Get all button mapping presets
FrameLabs.get('/api/user/:id/controller', async (req, res) => {
    const mappings = await buttonMapping.find({});
    res.json(mappings);
})

//Get a specific button preset
FrameLabs.get('api/user/:id/controller/:id', async (req,res) =>{
    const mapping = await buttonMapping.findById(req.params.id);
    if (mapping) {
        res.json(mapping);
    } else {
        res.status(404).json({ error: 'Preset Not Found'});
    }
})

//Delete Community Guide
FrameLabs.delete('/api/community/guide/:id', async (req, res) => {
    const deleted = await communityGuide.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Guide not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Stage
FrameLabs.delete('/api/community/stage/:id', async (req, res) => {
    const deleted = await communityStage.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Stage not found.');}
    communityStage.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Trial
FrameLabs.delete('/api/community/trial/:id', async (req, res) => {
    const deleted = await communityTrial.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Trial not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Character
FrameLabs.delete('/api/community/characters/:id', async (req, res) => {
    const deleted = await communityCharacter.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Character not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Playstyle
FrameLabs.delete('/api/system/playstyle/:id', async (req, res) => {
    const deleted = await playStyles.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Playstyle not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Playable Character
FrameLabs.delete('/api/system/characters/:id', async (req, res) => {
    const deleted = await systemCharacter.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Character not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Combo Trial
FrameLabs.delete('/api/system/trials/:id', async (req, res) => {
    const deleted = await systemTrial.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Trial not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete System Tutorial
FrameLabs.delete('/api/system/tutorial/:id', async (req, res) => {
    const deleted = await systemTutorial.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Tutorial not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Remove all Leaderboard Scores
FrameLabs.delete('/api/system/leaderboard', async (req, res) => {
    const result = await leaderboard.deleteMany({});
    if (result.deletedCount === 0) {
      return res.status(404).send('No leaderboard scores to delete.');
    }
    res.json({ message: 'Leaderboard cleared successfully.' });
})

//Remove a single Leaderboard Score
FrameLabs.delete('/api/system/leaderboard/:id', async (req, res) => {
    const deleted = await leaderboard.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Score not found.');}
    Leaderboard.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Remove a button mapping preset
FrameLabs.delete('api/user/:id/controller/:id', async (req,res) => {
    const deleted = await buttonMapping.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('Given ID was not found.');}
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete a user and their account
FrameLabs.delete('api/user/:id', async (req, res) => {
    const deleted = await user.findByIdAndDelete(req.params.id);
    if (!deleted) {return res.status(404).send('User not found.');}
    const result = await userAccount.findByIdAndDelete(req.params.id);
    if (!result) {return res.status(404).send('User account found.');}
    res.status(204).send();     //204 - No content for successful deletion
})


//Modify Community Guide
FrameLabs.put('/api/community/guide/:id', (req, res) => {
    const guide = communityGuide.find(t => t.id === parseInt(req.params.id)); 
    if (!guide){
        return res.status(404).send(`Guide not found.`)
    }
    guide.text = req.body.text;
    res.json (communityGuide);
    res.status(204).send(`Guide updated.`);
})

//Edit a Community Stage
FrameLabs.put('/api/community/stage/:id', (req, res) => {
    const stage = communityStage.find(t => t.id === parseInt(req.params.id));
    if (!stage) return res.status(404).send("Stage not found.");
    Object.assign(stage, req.body);
    res.status(200).json(stage);
});

//Edit a Community Trial
FrameLabs.put('/api/community/trial/:id', (req, res) => {
    const trial = communityTrial.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Trial not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
});

//Update a Community Character
FrameLabs.put('/api/community/character/:id', (req, res) => {
    const character = communityCharacter.find(c => c.id === parseInt(req.params.id));
    if (!character) return res.status(404).send("Character not found.");
    Object.assign(character, req.body);
    res.status(200).json(character);
});

//Update a Playstyle
FrameLabs.put('/api/system/playstyle/:id', (req, res) => {
    const Playstyle = playStyles.find(c => c.id === parseInt(req.params.id));
    if (!Playstyle) return res.status(404).send("Playstyle not found.");
    Object.assign(Playstyle, req.body);
    res.status(200).json(Playstyle);
});

//Update a playable character
FrameLabs.put('/api/system/character/:id', (req, res) => {
    const character = systemCharacter.find(c => c.id === parseInt(req.params.id));
    if (!character) return res.status(404).send("Character not found.");
    Object.assign(character, req.body);
    res.status(200).json(character);
});

//Edit a Combo Trial
FrameLabs.put('/api/system/trial/:id', (req, res) => {
    const trial = system.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Combo Trial not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
});

//Edit a Tutorial
FrameLabs.put('/api/system/tutorial/:id', (req, res) => {
    const tutorial = system.find(t => t.id === parseInt(req.params.id));
    if (!tutorial) return res.status(404).send("Tutorial not found.");
    Object.assign(tutorial, req.body);
    res.status(200).json(tutorial);
});

//Update User Account
FrameLabs.put('/api/system/user/:id', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    Object.assign(user, req.body);
    res.status(200).json(user);
});

//Edit Leaderboard Score
FrameLabs.put('/api/system/leaderboard/:id', (req, res) => {
    const leaderboard = leaderboard.find(u => u.id === parseInt(req.params.id));
    if (!leaderboard) return res.status(404).send("Score not found.");
    Object.assign(leaderboard, req.body);
    res.status(200).json(leaderboard);
});

//Edit Controller Mapping
FrameLabs.put('/api/system/user/:id/controller/:id', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.controllerMapping = req.body.controllerMapping || user.controllerMapping;
    res.status(200).json(user);
});

//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
FrameLabs.listen(PORT, () => console.log(`API Docs Available at http://localhost:${PORT}/api-docs`));
