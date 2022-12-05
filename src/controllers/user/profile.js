const { DB_USER, DB_ADMIN } = require("../../config/database");

const ProfileController = {
    async index(req, res, next) {
        try {
            const userId = req.cookies.Id;
            const pool = await DB_ADMIN;
            const data = await pool.request().query(`SELECT * FROM KHACH_HANG WHERE ID_KhachHang = '${userId}'`);
            const user = data.recordset[0];
            res.render('user/profile', { user: user });
        } catch (err) {
            console.log(err);
            res.render('user/profile', { type: 'error', message: 'Something wrong!!! Please try again.' });
        }
    },
};

module.exports = ProfileController;
