const mongoose = require('mongoose');

const userAccountSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  name: { type: String, required: true },
  email: { type: String },
  skill: {
    type: String,
    enum: ['baby', 'child', 'average', 'lord', 'king', 'force', 'god'],
    default: 'average',
  },
  profilePicture: {
    data: Buffer,
    contentType: String,
  },
});

module.exports = mongoose.model('UserAccount', userAccountSchema);
