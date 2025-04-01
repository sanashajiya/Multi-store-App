const express = require('express');
const User = require('../models/user'); 
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();
const JWT_SECRET = "your-secret-key";  // Change this to an environment variable

// Signup API
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { fullName, email, password } = req.body;

        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({ msg: 'User with this email already exists' });
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        let user = new User({ fullName, email, password: hashedPassword });
        user = await user.save();
        res.json({ user });

    } catch (error) {
        console.error("Signup Error:", error);
        res.status(500).json({ error: error.message });
    }
});

// Sign-in API
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(400).json({ msg: 'User with this email does not exist' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Invalid password' });
        }

        const token = jwt.sign({ id: user._id }, JWT_SECRET, { expiresIn: "1h" });
        const { password: _, ...userWithoutPassword } = user._doc; // Remove password from response

        res.json({ token, ...userWithoutPassword });

    } catch (e) {
        console.error("Signin Error:", e);
        res.status(500).json({ error: e.message });
    }
});

module.exports = authRouter;
