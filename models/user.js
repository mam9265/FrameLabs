const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  password: { type: String, required: true },
});

userSchema.pre('save', async function (next) {
  try {
    if (!this.isModified('password')) return next();

    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);

    console.log('✅ Password hashed before saving');
    next();
  } catch (err) {
    console.error('❌ Error hashing password:', err);
    next(err);
  }
});

module.exports = mongoose.model('user', userSchema);