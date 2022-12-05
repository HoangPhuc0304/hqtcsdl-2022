const express = require('express');
const homeRouter = require('./home');
const partnerRouter = express.Router();

partnerRouter.use('/', homeRouter);

module.exports = partnerRouter;