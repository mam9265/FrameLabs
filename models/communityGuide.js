const mongoose = require('mongoose');

const communityGuideSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
    unique: true,
  },
});

const communityGuide = mongoose.model('CommunityGuide', communityGuideSchema);

module.exports = communityGuide;