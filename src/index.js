const express = require('express');
const cors = require('cors');
const connectDB = require('../config/database');
require('dotenv').config();

// Connect to MongoDB
connectDB();

// Initialize Express
const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes
app.use('/todos', require('./routes/todoRoutes'));

// Root route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the Todo API' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!' });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
