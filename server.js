const express = require('express');
const mongoose = require('mongoose');

const FrameLabs = express();
FrameLabs.use(express.json());

//Connect to MongoDB
mongoose.connect('mongodb+srv://jvw6185_db_user:EAYWIY8dLjvFPJPP@cluster0.wgxd48f.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));
const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));


//Array that acts as a "Database"
let community = [];

//Get Endpoint
FrameLabs.get('/api/system/community', (req, res) => {
    //Return all the community guides
    res.json(community);
})

// Make Community Guide 
let guide = []

app.post('/api/community/guide' , (req , res) => {

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

//Port the system runs on :)
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));