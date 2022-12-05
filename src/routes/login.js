const express = require("express");
const loginController = require('../controllers/login');
const loginRouter = express.Router();

loginRouter.get("/login", loginController.index); 
loginRouter.post("/save", loginController.save);  
loginRouter.get("/out", loginController.destroy); 

module.exports = loginRouter;