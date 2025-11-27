const mongoose = require('mongoose');

const dailyChallengeSchema = new mongoose.Schema({
  date: {
    type: String, // Format: YYYY-MM-DD
    required: true,
    unique: true,
  },
  character: {
    type: String,
    required: true,
  },
  completedBy: [{
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'user',
    },
    completedAt: {
      type: Date,
      default: Date.now,
    },
    completedTrials: [{
      type: Number,
    }],
  }],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('dailyChallenge', dailyChallengeSchema);

