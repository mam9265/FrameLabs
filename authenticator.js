const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

const loginUser = (req, res) => {
    if (req.body.username !== 'admin' || req.body.password !== 'secure') {
        return res.status(401).send('Invalid Credentials')
    }
}

const payload = {
    id: 101,
    username: 'admin',
    role: 'Admin'
}

const token = jwt.sign(payload, JWT_SECRET, { expiresIn: '1h' });

res.json({ message: 'login successful', token });

