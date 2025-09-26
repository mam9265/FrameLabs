const express = require('express');
const app = express();
app.use(express.json());

let community = [];

app.put('/api/system/community/:id', (req, res) => {
    const guide = community.find(t => t.id === parseInt(req.params.id)); 
    if (!guide){
        return res.status(404).send(`Guide not found.`)
    }
    guide.text = req.body.text;
    res.json (guide);
    res.status(204).send(`Guide updated.`);
})


const PORT = 3000;

app.listen(PORT, () => console.log (`Server running on port ${PORT}`));