const express = require('express');
const { FoodController, ProfileController } = require('../../controllers/user');
const CartController = require('../../controllers/user/cart');
const userRouter = express.Router();

userRouter.post('/cart/:id/edit', CartController.edit);
userRouter.get('/cart/:id', CartController.details);
userRouter.get('/cart/:id/order', CartController.view);
userRouter.get('/cart/:id/destroy', CartController.destroy);
userRouter.post('/cart/:id/order', CartController.order);
userRouter.get('/cart', CartController.index);
userRouter.get('/profile', ProfileController.index);
userRouter.get('/foods/:id/details', FoodController.details);
userRouter.get('/foods/:id', FoodController.view);
userRouter.get('/', FoodController.index);

module.exports = userRouter;