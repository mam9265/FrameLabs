const express = require('express');

const FrameLabs = express();
FrameLabs.use(express.json());

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

//Return all Community Trials
FrameLabs.get('/api/community/trial', (req, res) => {
    res.json(communityTrial);
})

//Return all Community Characters
FrameLabs.get('/api/community/characters', (req, res) => {
    res.json(communityCharacter);
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

//Get all Leaderboard Scores
FrameLabs.get('/api/system', (req, res) => {
    //Return all the leaderboard scores
    res.json(leaderboard);
})

FrameLabs.get('/api/user', (req, res) => {
    //Return all the user account info
    res.json(userAccount);
})

//Port the system runs on
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
