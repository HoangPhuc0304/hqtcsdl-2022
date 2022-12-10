const { DB_PARTNER, DB_ADMIN } = require("../../config/database");

const ProfileController = {
    async index(req, res, next) {
        try {
            const partnerId = req.cookies.Id;
            const pool = await DB_ADMIN;
            const data = await pool.request().query(`SELECT * FROM DOI_TAC WHERE ID_DoiTac = '${partnerId}'`);
            const partner = data.recordset[0];
            res.render('partner/profile', { partner: partner });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    },
};

module.exports = ProfileController;
