const express = require('express');
const { ProfileController, FoodController, ShopController, PackageController } = require('../../controllers/partner');
const partnerRouter = express.Router();

partnerRouter.get('/shop/:id', ShopController.details);
partnerRouter.get('/shop/:id/view', ShopController.view);
partnerRouter.post('/shop/:id/edit', ShopController.edit);
partnerRouter.get('/food/:id/create', FoodController.add);
partnerRouter.post('/food/:id/create', FoodController.create);
partnerRouter.get('/food/:id', FoodController.view);
partnerRouter.post('/food/:id/edit', FoodController.edit);
partnerRouter.post('/food/:id/delete', FoodController.delete);
partnerRouter.get('/package/:id', PackageController.index);
partnerRouter.get('/package/:id/edit', PackageController.view);
partnerRouter.post('/package/:id/edit', PackageController.edit);
partnerRouter.get('/profile', ProfileController.index);
partnerRouter.get('/', ShopController.index);

module.exports = partnerRouter;