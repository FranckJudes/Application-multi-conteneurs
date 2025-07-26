const express = require('express');
const cors = require('cors');
const connectDB = require('../config/database');
require('dotenv').config();

connectDB();

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use('/todos', require('./routes/todoRoutes'));

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the Todo API' });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
