const { DB_PARTNER } = require("../../config/database");

const ShopController = {
    async index(req, res, next) {
        try {
            const successMsg = req.flash('Success')[0];
            const errorMsg = req.flash('Error')[0];
            const pool = await DB_PARTNER;
            const partnerId = req.cookies.Id;
            const shopData = await pool.request().query(`
            SELECT CH.*
            FROM HOP_DONG HD, CUA_HANG CH
            WHERE HD.ID_DoiTac = '${partnerId}' AND HD.ID_HopDong = CH.ID_HopDong`);
            var shops = shopData.recordset;
            shops = shops.map(shop => ({
                ...shop,
                ID_CuaHang: shop.ID_CuaHang.trim(),
                ID_HopDong: shop.ID_HopDong.trim(),
            }))

            var foods;
            if (shops && shops.length > 0) {
                const foodData = await pool.request().query(`
                SELECT M.*
                FROM CUA_HANG CH, THUC_DON TD, MON M
                WHERE CH.ID_CuaHang = '${shops[0].ID_CuaHang}' AND CH.ID_CuaHang = TD.ID_CuaHang AND TD.ID_Mon = M.ID_Mon`);
                var foods = foodData.recordset;
                foods = foods.map(food => ({
                    ...food,
                    ID_Mon: food.ID_Mon.trim(),
                }))
            }

            if (successMsg) {
                res.render('partner/food', { shops, foods, type: 'success', message: successMsg });
            } else if (errorMsg) {
                res.render('partner/food', { shops, foods, type: 'error', message: errorMsg });
            } else {
                res.render('partner/food', { shops, foods, });
            }

        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    },
    details: async (req, res) => {
        try {
            const pool = await DB_PARTNER;
            const { id } = req.params;
            const partnerId = req.cookies.Id;
            const shopsData = await pool.request().query(`
            SELECT CH.*
            FROM HOP_DONG HD, CUA_HANG CH
            WHERE HD.ID_DoiTac = '${partnerId}' AND HD.ID_HopDong = CH.ID_HopDong`);
            var shops = shopsData.recordset;
            shops = shops.map(shop => ({
                ...shop,
                ID_CuaHang: shop.ID_CuaHang.trim(),
                ID_HopDong: shop.ID_HopDong.trim(),
            }))

            const shopData = await pool.request().query(`
            SELECT CH.*
            FROM CUA_HANG CH
            WHERE CH.ID_CuaHang = '${id}'`);
            const shop = shopData.recordset[0];

            const foodsData = await pool.request().query(`
            SELECT M.*
            FROM CUA_HANG CH, THUC_DON TD, MON M
            WHERE CH.ID_CuaHang = '${id}' AND CH.ID_CuaHang = TD.ID_CuaHang AND TD.ID_Mon = M.ID_Mon`);
            var foods = foodsData.recordset;
            foods = foods.map(s => ({
                ...s,
                ID_Mon: s.ID_Mon.trim(),
            }))
            res.render('partner/shop', {
                shop: {
                    ...shop,
                    ID_CuaHang: shop.ID_CuaHang.trim(),
                    ID_HopDong: shop.ID_HopDong.trim(),
                }, shops, foods
            });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    },
    view: async (req, res) => {
        try {
            const pool = await DB_PARTNER;
            const { id } = req.params;
            const shopData = await pool.request().query(`
            SELECT CH.*
            FROM CUA_HANG CH
            WHERE CH.ID_CuaHang = '${id}'`);
            const shop = shopData.recordset[0];
            console.log(shop);
            res.render('partner/shop/view', {
                shop: {
                    ...shop,
                    ID_CuaHang: shop.ID_CuaHang.trim(),
                    ID_HopDong: shop.ID_HopDong.trim(),
                },
            });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    },
    edit: async (req, res) => {
        try {
            const pool = await DB_PARTNER;
            const { id } = req.params;
            const { name, status } = req.body;

            if (status) {
                const updatedStatus = await pool.request().query(`
                UPDATE CUA_HANG
                SET TinhTrangCuaHang = N'${status}'
                WHERE ID_CuaHang = '${id}'`);
            }
            if (name) {
                const oldNameData = await pool.request().query(`
                SELECT TenCuaHang 
                FROM CUA_HANG 
                WHERE ID_CuaHang = '${id}'`);
                const oldName = oldNameData.recordset[0];

                if (name != oldName.TenCuaHang) {
                    const updatedName = await pool.request().query(`
                    UPDATE CUA_HANG
                    SET TenCuaHang = N'${name}'
                    WHERE ID_CuaHang = '${id}'`);
                }
            }

            req.flash('Success', 'Update shop info successfully');
            res.redirect('/partner');
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    }
};

module.exports = ShopController;
