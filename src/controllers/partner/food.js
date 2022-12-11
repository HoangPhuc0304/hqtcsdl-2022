const { DB_PARTNER } = require("../../config/database");

const FoodController = {
  async add(req, res) {
    try {
      const { id } = req.params;
      res.render('partner/food/create', { ID_CuaHang: id });
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/partner');
    }
  },
  async create(req, res, next) {
    try {
      const pool = await DB_PARTNER;
      const { id } = req.params;
      const { name, description, price, status } = req.body;

      const foodsData = await pool.request().query(`
      SELECT * FROM MON
      `)
      const foods = foodsData.recordset;
      const maxIdFood = Math.max(...foods.map(item => Number(item.ID_Mon.slice(1).trim())));
      const idNewFood = maxIdFood + 1 < 10 ? `M00${maxIdFood + 1}` : `M0${maxIdFood + 1}`;

      //Thêm Món
      const insertedFood = await pool.request().query(`
      EXEC sp_ThemMon '${id}','${idNewFood}',N'${name}',N'${description}',${price},N'${status}'
      `);
      req.flash('Success', 'Create a food successfully');
      res.redirect('/partner');
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/partner');
    }
  },
  async view(req, res, next) {
    try {
      const pool = await DB_PARTNER;
      const { id } = req.params;
      const foodData = await pool.request().query(`
      SELECT * 
      FROM MON
      WHERE ID_Mon = '${id}'
      `);
      const food = foodData.recordset[0];
      res.render('partner/food/edit', {
        food: {
          ...food,
          ID_Mon: food.ID_Mon.trim(),
        },
      });
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/partner');
    }
  },
  async edit(req, res, next) {
    try {
      const pool = await DB_PARTNER;
      const { id } = req.params;
      const { name, description, change, status } = req.body;
      if (Number(change) != 0) {
        const priceData = await pool.request().query(`
        exec usp_capNhatGiaMon_T1 '${id}', ${Number(change)}
        `);
      }

      if (status) {
        const oldStatusData = await pool.request().query(`
        SELECT TinhTrangMon
        FROM MON
        WHERE ID_Mon = '${id}'`);
        const oldStatus = oldStatusData.recordset[0];

        if (status != oldStatus.TinhTrangMon) {
          const foodData = await pool.request().query(`
          update MON
          set TinhTrangMon = N'${status}'
          where ID_Mon = '${id}'
          `)
        }
      }
      req.flash('Success', 'Update a food successfully');
      res.redirect('/partner');
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/partner');
    }
  },
  async delete(req, res, next) {
    try {
      req.flash('Error', `This feature hasn't been created`);
      res.redirect('/partner');
    } catch (err) {
      console.log(err);
      req.flash('Error', `${err}`);
      res.redirect('/partner');
    }
  },
};

module.exports = FoodController;
