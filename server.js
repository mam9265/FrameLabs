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
let communityGuide = []
// Make Community Stage Array
let communityStage = []
//Make Community Trial Array
let communityTrial = []
//Make Community Character Character Array
let communityCharacter = []
//Make leaderboard score array
let leaderboard = []
//Make an database to store user account info
let userAccount = []

//Return all the community guides
FrameLabs.get('/api/community/guide', (req, res) => {
    res.json(communityGuide);
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

//Delete Community Guide
FrameLabs.delete('/api/community/guide/:id', (req, res) => {
    //Delete community item
    const deleteIndex = communityGuide.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    communityGuide.splice(deleteIndex, 1);
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

//Return all Community Stages
FrameLabs.get('/api/community/stage', (req, res) => {
    res.json(communityStage);
})

//Update a Community Stage
FrameLabs.put('/api/community/stage/:id', (req, res) => {
    const stage = communityStage.find(s => s.id === parseInt(req.params.id));
    if (!stage) return res.status(404).send("Stage not found.");
    Object.assign(stage, req.body);
    res.status(200).json(stage);
});

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

//Update a Community Character
FrameLabs.put('/api/community/character/:id', (req, res) => {
    const character = communityCharacter.find(c => c.id === parseInt(req.params.id));
    if (!character) return res.status(404).send("Character not found.");
    Object.assign(character, req.body);
    res.status(200).json(character);
});

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

//Get all Leaderboard Scores
FrameLabs.get('/api/system', (req, res) => {
    //Return all the leaderboard scores
    res.json(leaderboard);
})

FrameLabs.get('/api/user', (req, res) => {
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

//Edit Profile Picture
FrameLabs.put('/api/system/user/:id/picture', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.profilePicture = req.body.profilePicture || user.profilePicture;
    res.status(200).json(user);
});

//Edit Controller Mapping
FrameLabs.put('/api/system/user/:id/controller', (req, res) => {
    const user = userAccount.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).send("User not found.");
    user.controllerMapping = req.body.controllerMapping || user.controllerMapping;
    res.status(200).json(user);
});

//Edit a Tutorial
FrameLabs.put('/api/system/tutorial/:id', (req, res) => {
    const tutorial = system.find(t => t.id === parseInt(req.params.id));
    if (!tutorial) return res.status(404).send("Tutorial not found.");
    Object.assign(tutorial, req.body);
    res.status(200).json(tutorial);
});

//Edit a Combo Trial
FrameLabs.put('/api/system/combotrial/:id', (req, res) => {
    const trial = system.find(t => t.id === parseInt(req.params.id));
    if (!trial) return res.status(404).send("Combo Trail not found.");
    Object.assign(trial, req.body);
    res.status(200).json(trial);
});

//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
FrameLabs.listen(PORT, () => console.log(`API Docs Available at http://localhost:${PORT}/api-docs`));
