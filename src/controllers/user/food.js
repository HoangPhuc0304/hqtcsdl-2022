const { DB_USER } = require("../../config/database");

const FoodController = {
  async index(req, res, next) {
    try {
      const pool = await DB_USER;
      const data = await pool.request().query(`
      SELECT M.*, CH.ID_CuaHang, CH.TenCuaHang, CH.TgHoatDong, CH.TinhTrangCuaHang
      FROM MON M, THUC_DON TD, CUA_HANG CH
      WHERE M.ID_Mon = TD.ID_Mon AND TD.ID_CuaHang = CH.ID_CuaHang`);
      var foods = data.recordset;
      foods = foods.map(food => ({
        ...food,
        ID_Mon: food.ID_Mon.trim(),
        ID_CuaHang: food.ID_CuaHang.trim(),
      }))
      res.render('user', { foods });
    } catch (err) {
      console.log(err);
      res.render('user', { type: 'error', message: 'Something wrong!!! Please try again.' });
    }
  },
};

module.exports = FoodController;
