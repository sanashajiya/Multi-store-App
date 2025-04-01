const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./routes/auth');
const bannerRouter = require('./routes/banner');

const PORT = 3000;
const app = express();

// MongoDB connection string (move this to an environment variable later)
const DB = 'mongodb+srv://sanashajiya:multistoreapp@cluster0.h4tfmnt.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

// Middleware
app.use(cors());  // Moved above to apply before routes
app.use(express.json());
app.use(authRouter);
app.use(bannerRouter);

// Connect to MongoDB with error handling
mongoose.connect(DB)
    .then(() => console.log("MongoDB Connected"))
    .catch(err => console.error("MongoDB Connection Error:", err));

// Start the server and listen on all interfaces
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});
