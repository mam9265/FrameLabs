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

module.exports = mongoose.model('CommunityGuide', communityGuideSchema);

