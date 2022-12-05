const express = require('express');
const homeRouter = require('./home');
const adminRouter = express.Router();

adminRouter.use('/', homeRouter);

module.exports = adminRouter;