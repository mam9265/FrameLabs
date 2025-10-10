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
// Make Community Guide Array
let communityGuide = [];
// Make Community Stage Array
let communityStage = [];
//Make Community Trial Array
let communityTrial = [];
//Make Community Character Character Array
let communityCharacter = [];
//Make an Array to Display All Playstyles
let playStyles = [];
//Display all avaiable fighters
let systemCharacter = [];
//Make a Combo Trial Array
let systemTrial = [];
//Make a Tutorial Array
let systemTutorial = [];
//Make leaderboard score array
let leaderboard = [];
//Make an database to store user account info
let userAccount = [];
//Make an account to store the users data
let user = []
//Make Button Mapping Arrau
let buttonMapping = [];

//Return all the Community Guides
FrameLabs.get('/api/community/guide', (req, res) => {
    res.json(communityGuide);
})

//Create a Community Guide
FrameLabs.post('/api/community/guide', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newGuide = {
        id: communityGuide.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      communityGuide.push(newGuide);
      res.status(201).json(newGuide);
})

//Create a Community Stage
FrameLabs.post('/api/community/stage', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newStage = {
        id: communityStage.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      communityStage.push(newStage);
      res.status(201).json(newStage);
})

//Create a Community Trial
FrameLabs.post('/api/community/trial', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTrial = {
        id: communityTrial.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      communityTrial.push(newTrial);
      res.status(201).json(newTrial);
})

//Create a Community Character
FrameLabs.post('/api/community/characters', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newChara = {
        id: communityCharacter.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      communityCharacter.push(newChara);
      res.status(201).json(newChara);
})

//Add a new playstyle
FrameLabs.post('api/system/playstyle', (req, res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newStyle = {
        id: playStyles.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      communityCharacter.push(newStyle);
      res.status(201).json(newStyle);
})

//Add a new playable character
FrameLabs.post('api/system/characters', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newChara = {
        id: systemCharacter.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      systemCharacter.push(newChara);
      res.status(201).json(newChara);
})

//Add a new Combo Trial
FrameLabs.post('api/system/trials', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTrial = {
        id: systemTrial.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      systemTrial.push(newTrial);
      res.status(201).json(newTrial);
})

//Add a new tutorial
FrameLabs.post('api/system/tutorial', (req , res) => {
    const {title , description }  = req.body;
    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newTutorial = {
        id: systemTutorial.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      systemTrial.push(newTutorial);
      res.status(201).json(newTutorial);
})

//Create a new leaderboard score
FrameLabs.post('/api/system/leaderboard', (req, res) => {
    const {player_name , score }  = req.body;
    if (!player_name || !score) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newLeader = {
        id: leaderboard.length + 1,
        player_name,
        score,
        createdAt: new Date()
      };
      leaderboard.push(newLeader);
      res.status(201).json(newLeader);
})

//Create a new user and the user's account
FrameLabs.post('/api/user', (req, res) => {
    const {user_name, password, profilePicture } = req.body;
    if (!user_name || !password || !profilePicture) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newUser = {
        id: user.length + 1,
        user_name,
        password,
        createdAt: new Date()
      };
      User.push(newUser);
      res.status(201).json(newUser);

    const newAccount = {
        id: userAccount.length + 1,
        user_name,
        profilePicture,
        createdAt: new Date()
    };
    userAccount.push(newAccount);
    res.status(201).json(newAccount)
})

//Create a button mapping
FrameLabs.post('/api/user/:id/controller', (req, res) => {
    const {preset_name , preset_description }  = req.body;
    if (!preset_name || !preset_description) {
        return res.status(400).json({ error: "Title and description are required." });
      }
    const newPreset = {
        id: buttonMapping.length + 1,
        preset_name,
        preset_description,
        createdAt: new Date()
      };
      buttonMapping.push(newPreset);
      res.status(201).json(newPreset);
})

//Get a Community Guide
FrameLabs.get('/api/community/guide/:id', (req, res) => {
    const guideID = req.params.id;
    const guide = communityGuide.find(t => t.id === guideID);
    if (guide) {
        res.json(communityGuide);
    } else {
        res.status(404).json({ error: 'Guide not found' });
    }
})


//Return all Community Stages
FrameLabs.get('/api/community/stage', (req, res) => {
    res.json(communityStage);
})

//Get a Community Stage
FrameLabs.get('/api/community/stage/:id', (req, res) => {
    const stageID = req.params.id;
    const stage = communityStage.find(t => t.id === stageID);
    if (stage) {
        res.json(communityStage);
    } else {
        res.status(404).json({ error: 'Stage not found' });
    }
})

//Return all Community Trials
FrameLabs.get('/api/community/trial', (req, res) => {
    res.json(communityTrial);
})

//Open a Community Trial
FrameLabs.get('/api/community/trial/:id', (req, res) => {
    const trialID = req.params.id;
    const trial = communityTrial.find(t => t.id === trialID);
    if (trial) {
        res.json(communityTrial);
    } else {
        res.status(404).json({ error: 'Trial not found' });
    }
})

//Return all Community Characters
FrameLabs.get('/api/community/characters', (req, res) => {
    res.json(communityCharacter);
})

//Get a Community Character
FrameLabs.get('/api/community/characters/:id', (req, res) => {
    const charaID = req.params.id;
    const chara = communityCharacter.find(t => t.id === charaID);
    if (chara) {
        res.json(communityCharacter);
    } else {
        res.status(404).json({ error: 'Character not found' });
    }
})

//Return all different playstyles
FrameLabs.get('api/system/playstyle', (req, res) => {
    res.json(playStyles);
})

//Get a Specific Playstyle
FrameLabs.get('/api/system/playstyle/:id', (req, res) => {
    const styleID = req.params.id;
    const style = playStyles.find(t => t.id === styleID);
    if (style) {
        res.json(communityTrial);
    } else {
        res.status(404).json({ error: 'Style not found' });
    }
})

//Return all Playable Characters
FrameLabs.get('api/system/characters', (req, res) => {
    res.json(systemCharacter);
})

//Get a Playable Character
FrameLabs.get('/api/system/characters/:id', (req, res) => {
    const charaID = req.params.id;
    const chara = systemCharacter.find(t => t.id === charaID);
    if (chara) {
        res.json(communityCharacter);
    } else {
        res.status(404).json({ error: 'Character not found' });
    }
})

//Return all Combo Trails
FrameLabs.get('api/system/trials', (req, res) => {
    res.json(systemTrial);
})

//Open a Combo Trial
FrameLabs.get('/api/system/trials/:id', (req, res) => {
    const trialID = req.params.id;
    const trial = systemTrial.find(t => t.id === trialID);
    if (trial) {
        res.json(systemTrial);
    } else {
        res.status(404).json({ error: 'Trial not found' });
    }
})

//Return all available Tutorials
FrameLabs.get('api/system/tutorial', (req, res) => {
    res.json(systemTutorial);
})

//Open a Specific Tutorial
FrameLabs.get('/api/system/tutorial/:id', (req, res) => {
    const tutorialID = req.params.id;
    const tutorial = systemTutorial.find(t => t.id === tutorialID);
    if (tutorial) {
        res.json(systemTutorial);
    } else {
        res.status(404).json({ error: 'Tutorial not found' });
    }
})

//Get all Leaderboard Scores
FrameLabs.get('/api/system/leaderboard', (req, res) => {
    //Return all the leaderboard scores
    res.json(leaderboard);
})

//Get a leaderboard score
FrameLabs.get('/api/system/leaderboard/:id', (req, res) => {
    const leaderID = req.params.id;
    const leader = leaderboard.find(t => t.id === leaderID);
    if (leader) {
        res.json(Leaderboard);
    } else {
        res.status(404).json({ error: 'Leaderboard Score not found' });
    }
})

//Get all user account information
FrameLabs.get('/api/user/:id/account', (req, res) => {
    //Return all the user account info
    res.json(userAccount);
})

//Get all button mapping presets
FrameLabs.get('api/user/:id/controller', (req, res) => {
    //Return all the user's preset button mapping
    res.json(buttonMapping);
})

//Get a specific button preset
FrameLabs.get('api/user/:id/controller/:id', (req,res) =>{
    const presetID = req.params.id;
    const preset = buttonMapping.find(t => t.id === presetID);
    if (preset) {
        res.json(buttonMapping);
    } else {
        res.status(404).json({ error: 'Preset Not Found'});
    }
})

//Delete Community Guide
FrameLabs.delete('/api/community/guide/:id', (req, res) => {
    const deleteIndex = communityGuide.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityGuide.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Stage
FrameLabs.delete('/api/community/stage/:id', (req, res) => {
    const deleteIndex = communityStage.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityStage.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Trial
FrameLabs.delete('/api/community/trial/:id', (req, res) => {
    const deleteIndex = communityTrial.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityTrial.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Character
FrameLabs.delete('/api/community/characters/:id', (req, res) => {
    const deleteIndex = communityCharacter.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityCharacter.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Playstyle
FrameLabs.delete('/api/system/playstyle/:id', (req, res) => {
    const deleteIndex = playStyles.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    playStyles.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Playable Character
FrameLabs.delete('/api/system/characters/:id', (req, res) => {
    const deleteIndex = systemCharacter.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    systemCharacter.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

FrameLabs.delete('/api/system/trials/:id', (req, res) => {
    const deleteIndex = systemTrial.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    systemTrial.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete System Tutorial
FrameLabs.delete('/api/system/tutorial/:id', (req, res) => {
    //Delete system item
    const deleteIndex = systemTutorial.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    systemTutorial.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Remove all Leaderboard Scores
FrameLabs.delete('/api/system/leaderboard', (req, res) => {
    leaderboard.length = 0;
    res.json({ message: 'Leaderboard cleared successfully.' });
})

//Remove a single Leaderboard Score
FrameLabs.delete('/api/system/leaderboard/:id', (req, res) => {
    const deleteIndex = Leaderboard.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    Leaderboard.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Remove a button mapping preset
FrameLabs.delete('api/user/:id/controller/:id', (req,res) => {
    const deleteIndex = buttonMapping.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    buttonMapping.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete a user and their account
FrameLabs.delete('api/user/:id', (req, res) => {
    const deleteIndex = user.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    user.splice(deleteIndex, 1);
    userAccount.splice(deleteIndex, 1);
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

//Edit a Community Trial
FrameLabs.put('/api/community/trial/:id', (req, res) => {
    const trial = communityTrial.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Trial not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
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

//Edit Controller Mapping
FrameLabs.put('/api/system/user/:id/controller/:id', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.controllerMapping = req.body.controllerMapping || user.controllerMapping;
    res.status(200).json(user);
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
//Edit Profile Picture
FrameLabs.put('/api/system/user/:id/account/:id/picture', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.profilePicture = req.body.profilePicture || user.profilePicture;
    res.status(200).json(user);
});

//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
FrameLabs.listen(PORT, () => console.log(`API Docs Available at http://localhost:${PORT}/api-docs`));
