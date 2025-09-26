const express = require('express');
const FrameLabs = express();
FrameLabs.use(express.json());

//Array that acts as a "Database"
let community = [];

//Get Endpoint
FrameLabs.get('/api/system/community', (req, res) => {
    //Return all the community guides
    res.json(community);
})

//Delete Community Item
FrameLabs.delete('/api/system/community', (req, res) => {
    //Delete community item
    const deleteIndex = community.findIndex(t => t.id === parseInt(req.params.id));
    if (deleteIndex === -1) {return res.status(404).send('Given ID was not found.');}
    community.splice(deleteIndex, 1);
    res.status(204).send();     //204 - No content for successful deletion
})

//Port the system runs on :)
const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));