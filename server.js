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
//Make Button Mapping Arrau
let buttonMapping = [];

//Return all the Community Guides
FrameLabs.get('/api/community/guide', (req, res) => {
    res.json(communityGuide);
})

//Get a Community Guide
FrameLabs.get('/api/community/guide/:id', (req, res) => {
    const guideID = req.params.id
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
    const stageID = req.params.id
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
    const trialID = req.params.id
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
    const charaID = req.params.id
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
    const styleID = req.params.id
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
    const charaID = req.params.id
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
    const trialID = req.params.id
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
    const tutorialID = req.params.id
    const tutorial = systemTutorial.find(t => t.id === trialID);
    if (trial) {
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

//Get all user account information
FrameLabs.get('/api/user/account', (req, res) => {
    //Return all the user account info
    res.json(userAccount);
})

//Get all button mapping presets
FrameLabs.get('api/user/controller', (req, res) => {
    //Return all the user's preset button mapping
    res.json(buttonMapping);
})

//Delete System Item
FrameLabs.delete('/api/system/:id', (req, res) => {
    //Delete system item
    const deleteIndex = system.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    system.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete User Item
FrameLabs.delete('/api/user/:id', (req, res) => {
    //Delete user item
    const deleteIndex = user.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    user.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete Community Guide
FrameLabs.delete('/api/community/guide/:id', (req, res) => {
    //Delete community item
    const deleteIndex = communityGuide.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityGuide.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})


FrameLabs.post('/api/community/guide' , (req , res) => {

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

//Return all Community Stages
FrameLabs.get('/api/community/stage', (req, res) => {
    res.json(communityStage);
})

//Return all Community Trials
FrameLabs.get('/api/community/trial', (req, res) => {
    res.json(communityTrial);
})

//Edit a Community Trial
FrameLabs.put('/api/community/trial/:id', (req, res) => {
    const trial = communityTrial.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Trial not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
});

//Return all Community Characters
FrameLabs.get('/api/community/characters', (req, res) => {
    res.json(communityCharacter);
})

//Return all different playstyles
FrameLabs.get('api/system/playstyle', (req, res) => {
    res.json(playStyles);
})

//Return all Playable Characters
FrameLabs.get('api/system/characters', (req, res) => {
    res.json(systemCharacter);
})

//Return all Combo Trails
FrameLabs.get('api/system/trials', (req, res) => {
    res.json(systemTrial);
})

//Edit a Combo Trial
FrameLabs.put('/api/system/combotrial/:id', (req, res) => {
    const trial = system.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Combo Trial not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
});

//Return all available Tutorials
FrameLabs.get('api/system/tutorial', (req, res) => {
    res.json(systemTutorial);
})

//Edit a Tutorial
FrameLabs.put('/api/system/tutorial/:id', (req, res) => {
    const tutorial = system.find(t => t.id === parseInt(req.params.id));
    if (!tutorial) return res.status(404).send("Tutorial not found.");
    Object.assign(tutorial, req.body);
    res.status(200).json(tutorial);
});

//Get all Leaderboard Scores
FrameLabs.get('/api/system/leaderboard', (req, res) => {
    //Return all the leaderboard scores
    res.json(leaderboard);
})

FrameLabs.get('/api/user/account', (req, res) => {
    //Return all the user account info
    res.json(userAccount);
})

//Update User Account
FrameLabs.put('/api/system/user/:id', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    Object.assign(user, req.body);
    res.status(200).json(user);
});

FrameLabs.get('api/user/controller', (req, res) => {
    //Return all the user's preset button mapping
    res.json(buttonMapping);
})

//Edit Controller Mapping
FrameLabs.put('/api/system/user/:id/controller', (req, res) => {
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

//Edit Profile Picture
FrameLabs.put('/api/system/user/:id/picture', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.profilePicture = req.body.profilePicture || user.profilePicture;
    res.status(200).json(user);
});


//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
FrameLabs.listen(PORT, () => console.log(`API Docs Available at http://localhost:${PORT}/api-docs`));
