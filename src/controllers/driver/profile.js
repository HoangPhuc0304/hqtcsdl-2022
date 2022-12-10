const { DB_DRIVER, DB_ADMIN } = require("../../config/database");

const ProfileController = {
    async index(req, res, next) {
        try {
            const driverId = req.cookies.Id;
            const pool = await DB_ADMIN;
            const data = await pool.request().query(`SELECT * FROM TAI_XE WHERE ID_TaiXe = '${driverId}'`);
            const driver = data.recordset[0];
            res.render('driver/profile', { driver: driver });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/driver');
        }
    },
};

module.exports = ProfileController;
