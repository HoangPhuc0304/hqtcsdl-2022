const { DB_USER, DB_ADMIN } = require("../../config/database");

const ProfileController = {
    async index(req, res, next) {
        try {
            const userId = req.cookies.Id;
            const pool = await DB_ADMIN;
            const data = await pool.request().query(`SELECT * FROM KHACH_HANG WHERE ID_KhachHang = '${userId}'`);
            const user = data.recordset[0];
            console.log(userId);
            res.render('user/profile', { user: user });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
};

module.exports = ProfileController;
