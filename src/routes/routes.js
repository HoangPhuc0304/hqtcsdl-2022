const Authentication = require('../middlewares/authentication');
const adminRouter = require('./admin');
const driverRouter = require('./driver');
const loginRouter = require('./login');
const partnerRouter = require('./partner');
const userRouter = require('./user');

module.exports = function routes(app) {
    app.use('/auth', loginRouter);
    app.use('/admin', Authentication, adminRouter);
    app.use('/driver', Authentication, driverRouter);
    app.use('/partner', Authentication, partnerRouter);
    app.use('/', Authentication, userRouter);
};