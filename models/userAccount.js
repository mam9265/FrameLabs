const mongoose = require('mongoose');

const userAccountSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  profilePicture: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model('UserAccount', userAccountSchema);
