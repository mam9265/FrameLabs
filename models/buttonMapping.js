const mongoose = require('mongoose');

const buttonMappingSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  preset_name: {
    type: String,
    required: true,
  },
  preset_description: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('buttonMapping', buttonMappingSchema);
