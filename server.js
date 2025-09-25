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

const PORT = 3000;
FrameLabs.listen(PORT, () => console.log(`Server running on port: ${PORT}`));