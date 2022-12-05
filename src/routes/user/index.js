const express = require('express');
const { FoodController, ProfileController } = require('../../controllers/user');
const userRouter = express.Router();

userRouter.get('/', FoodController.index);
userRouter.get('/profile', ProfileController.index);

module.exports = userRouter;