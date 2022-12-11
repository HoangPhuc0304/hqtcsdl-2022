const { DB_USER, DB_ADMIN } = require("../../config/database");

const FoodController = {
  async index(req, res, next) {
    try {
      const successMsg = req.flash('Success')[0];
      const errorMsg = req.flash('Error')[0];
      const pool = await DB_USER;
      const data = await pool.request().query(`SELECT * FROM DOI_TAC DT`);
      var partners = data.recordset;
      partners = partners.map(partner => ({
        ...partner,
        ID_DoiTac: partner.ID_DoiTac.trim(),
      }));
      if (successMsg) {
        res.render('user', { partners, type: 'success', message: successMsg });
      } else if (errorMsg) {
        res.render('user', { partners, type: 'error', message: errorMsg });
      } else {
        res.render('user', { partners });
      }

    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/');
    }
  },
  async view(req, res, next) {
    try {
      const pool = await DB_ADMIN;
      const { id } = req.params;
      const data = await pool.request().query(`
      EXEC sp_XemDanhSachMon '${id}'
      `);
      var foods = data.recordsets[1];
      foods = foods.map(food => ({
        ...food,
        ID_Mon: food.ID_Mon.trim(),
      }));
      res.render('user/food', { foods, ID_DoiTac: id });
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/');
    }
  },
  details: async (req, res) => {
    try {
      const pool = await DB_USER;
      const { id } = req.params;
      console.log(id);
      const data = await pool.request().query(`
      SELECT M.*, CH.ID_CuaHang, CH.TenCuaHang, CH.TgHoatDong, CH.TinhTrangCuaHang
      FROM MON M, THUC_DON TD, CUA_HANG CH
      WHERE M.ID_MON = '${id}' AND M.ID_Mon = TD.ID_Mon AND TD.ID_CuaHang = CH.ID_CuaHang  
      `)
      const food = data.recordset[0];
      res.render('user/food/details', {
        food: {
          ...food,
          ID_Mon: food.ID_Mon.trim(),
          ID_CuaHang: food.ID_CuaHang.trim(),
        }
      });
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/');
    }
  },
};

module.exports = FoodController;
