const express = require('express');
const router = express.Router();
const todoController = require('../controllers/todoController');

// Route to get all todos
router.get('/', todoController.getAllTodos);

// Route to create a new todo
router.post('/', todoController.createTodo);

// Route to get a single todo by id
router.get('/:id', todoController.getTodoById);

// Route to update a todo by id
router.put('/:id', todoController.updateTodo);

// Route to delete a todo by id
router.delete('/:id', todoController.deleteTodo);

module.exports = router;
