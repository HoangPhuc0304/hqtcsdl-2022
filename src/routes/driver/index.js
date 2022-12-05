const express = require('express');
const homeRouter = require('./home');
const driverRouter = express.Router();

driverRouter.use('/', homeRouter);

module.exports = driverRouter;