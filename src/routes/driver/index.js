const express = require('express');
const { ProfileController, PackageController } = require('../../controllers/driver');
const partnerRouter = express.Router();

partnerRouter.get('/package/:id/edit', PackageController.view);
partnerRouter.post('/package/:id/edit', PackageController.edit);
partnerRouter.get('/profile', ProfileController.index);
partnerRouter.get('/', PackageController.index);

module.exports = partnerRouter;