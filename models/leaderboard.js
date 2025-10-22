const mongoose = require('mongoose');

const leaderboardSchema = new mongoose.Schema({
  player_name: {
    type: String,
    required: true,
    unique: true,
  },
  score: {
    type: Number,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('leaderboard', leaderboardSchema);
