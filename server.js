const express = require('express');

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger-output.json');

const FrameLabs = express();
FrameLabs.use(express.json());
FrameLabs.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

//Connect to MongoDB
const connectDB = require('./db.js');

connectDB();

//Array that acts as a "Database"
let community = [];

//Get Endpoint
FrameLabs.get('/api/system/community', (req, res) => {
    //Return all the community guides
    res.json(community);
})

// Make Community Guide 
let guide = []

FrameLabs.post('/api/community/guide' , (req , res) => {

    const {title , description }  = req.body;

    if (!title || !description) {
        return res.status(400).json({ error: "Title and description are required." });
      }

    

    const newGuide = {
        id: guide.length + 1,
        title,
        description,
        createdAt: new Date()
      };
      guide.push(newGuide);

      res.status(201).json(newGuide);
    
})

//Delete Community Item
FrameLabs.delete('/api/system/community', (req, res) => {
    //Delete community item
    const deleteIndex = community.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    community.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Modify Community Item
FrameLabs.put('/api/system/community/:id', (req, res) => {
    const guide = community.find(t => t.id === parseInt(req.params.id)); 
    if (!guide){
        return res.status(404).send(`Guide not found.`)
    }
    guide.text = req.body.text;
    res.json (guide);
    res.status(204).send(`Guide updated.`);
})

//Delete System Item
FrameLabs.delete('/api/system/system', (req, res) => {
    //Delete system item
    const deleteIndex = system.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    system.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Delete User Item
FrameLabs.delete('/api/system/user', (req, res) => {
    //Delete user item
    const deleteIndex = user.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    user.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Make leaderboard score array
let leaderboard = []

//Get all Leaderboard Scores
FrameLabs.get('/api/system', (req, res) => {
    //Return all the leaderboard scores
    res.json(leaderboard);
})

//Make an database to store user account info
let userAccount = []

FrameLabs.get('/api/system/user', (req, res) => {
    //Return all the user account info
    res.json(leaderboard);
})

//Port the system runs on :)
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));
FrameLabs.listen(PORT, () => console.log(`API Docs Available at http://localhost:${PORT}/api-docs`));
