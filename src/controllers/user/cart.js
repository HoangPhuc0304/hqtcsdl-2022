const { DB_USER, DB_ADMIN } = require("../../config/database");

const CartController = {
    async index(req, res, next) {
        try {
            const pool = await DB_USER;
            const userId = req.cookies.Id;
            const data = await pool.request().query(`
            SELECT * FROM DON_HANG DH, CHI_TIET_DON_HANG CTDH, MON M
            WHERE ID_KhachHang = '${userId}' AND DH.ID_DonHang = CTDH.ID_DonHang AND DH.TinhTrangDonHang != N'Đã hủy'
            AND CTDH.ID_Mon = M.ID_Mon`);
            var items = data.recordset;
            items = items.map(item => ({
                ...item,
                ID_DonHang: item.ID_DonHang[0].trim(),
                ID_KhachHang: item.ID_KhachHang.trim(),
                ID_Mon: item.ID_Mon[0].trim(),
            }))
            res.render('user/cart', { items });
        } catch (err) {
            console.log(err);
            // res.render('user', { type: 'error', message: 'Something wrong!!! Please try again.' });
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
    details: async (req, res) => {
        try {
            const pool = await DB_USER;
            const { id } = req.params;
            const foodData = await pool.request().query(`
            SELECT M.*, CH.ID_CuaHang, CH.TenCuaHang, CH.TgHoatDong, CH.TinhTrangCuaHang
            FROM MON M, THUC_DON TD, CUA_HANG CH
            WHERE M.ID_MON = '${id}' AND M.ID_Mon = TD.ID_Mon AND TD.ID_CuaHang = CH.ID_CuaHang  
            `)
            const optionsData = await pool.request().query(`
            SELECT DISTINCT TuyChon FROM CHI_TIET_DON_HANG
            `)

            const methodsData = await pool.request().query(`
            SELECT DISTINCT HinhThucThanhToan FROM CHI_TIET_DON_HANG
            `)

            const addressesData = await pool.request().query(`
            SELECT DISTINCT CTDH.DiaChiGiaoHang 
            FROM DON_HANG DH, CHI_TIET_DON_HANG CTDH
            WHERE DH.ID_KhachHang = 'KH01' AND DH.ID_DonHang = CTDH.ID_DonHang
            `)

            const food = foodData.recordset[0];
            const options = optionsData.recordset;
            const methods = methodsData.recordset;
            const addresses = addressesData.recordset;

            res.render('user/cart/confirm', {
                food: {
                    ...food,
                    ID_Mon: food.ID_Mon.trim(),
                    ID_CuaHang: food.ID_CuaHang.trim(),
                },
                options: options,
                methods: methods,
                addresses: addresses
            });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
    view: async (req, res) => {
        try {
            const pool = await DB_USER;
            const { id } = req.params;
            const itemData = await pool.request().query(`
            exec usp_kiemTraTinhTrangDonHang '${id}'
            `);

            const addressesData = await pool.request().query(`
            SELECT DISTINCT CTDH.DiaChiGiaoHang 
            FROM DON_HANG DH, CHI_TIET_DON_HANG CTDH
            WHERE DH.ID_KhachHang = 'KH01' AND DH.ID_DonHang = CTDH.ID_DonHang
            `)
            const item = itemData.recordsets[1][0];
            const addresses = addressesData.recordset;

            res.render('user/cart/edit', {
                item: {
                    ...item,
                    ID_KhachHang: item.ID_KhachHang.trim(),
                    ID_TaiXe: item.ID_TaiXe.trim(),
                    ID_DonHang: item.ID_DonHang.trim(),
                },
                addresses: addresses
            });
        } catch (err) {
            console.log(err);
            // res.render('user', { type: 'error', message: 'Something wrong!!! Please try again.' });
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
    order: async (req, res) => {
        try {
            const pool = await DB_ADMIN;
            const { id } = req.params;
            const { quantity, option, method, address } = req.body;
            const userId = req.cookies.Id;
            console.log(req.body);

            if (!id || !userId || !quantity || !option || !method || !address) {
                throw 'Miss inputs';
            }

            //Lựa chọn tài xế có ít đơn hàng nhất
            const driverData = await pool.request().query(`
            SELECT TX.ID_TaiXe
            FROM TAI_XE TX, DON_HANG DH
            WHERE TX.ID_TaiXe = DH.ID_TaiXe
            GROUP BY TX.ID_TaiXe
            HAVING COUNT(TX.ID_TaiXe) = (SELECT MIN(C.SoLuong) 
            FROM (
                SELECT COUNT(TX.ID_TaiXe) AS SoLuong
                FROM TAI_XE TX, DON_HANG DH
                WHERE TX.ID_TaiXe = DH.ID_TaiXe
                GROUP BY TX.ID_TaiXe
            ) AS C)
            `);
            const driverId = driverData.recordset[0].ID_TaiXe;
            //Tìm ngày giao dự kiến (mặc định là 3 ngày)
            const dateString = new Date().toISOString().slice(0, 10);
            var expectedDate = new Date(dateString);
            expectedDate.setDate(expectedDate.getDate() + 3);
            const expectedDateString = expectedDate.toISOString().slice(0, 10);
            //Tạo ID sao cho tránh trùng lặp
            const itemsData = await pool.request().query(`
             SELECT * FROM DON_HANG
             `)
            const items = itemsData.recordset;
            const maxIdItem = Math.max(...items.map(item => Number(item.ID_DonHang.slice(2).trim())));
            const idNewItem = maxIdItem + 1 < 10 ? `DH0${maxIdItem + 1}` : `DH${maxIdItem + 1}`;

            //Thêm đơn hàng
            const updateItems = await pool.request().query(`
            INSERT INTO DON_HANG
            VALUES ('${idNewItem}','${userId}','${driverId}',NULL,'${expectedDateString}',N'Chờ nhận')  
            `)
            //Thêm chi tiết đơn hàng
            const updateDetailItems = await pool.request().query(`
            INSERT INTO CHI_TIET_DON_HANG
            VALUES ('${idNewItem}','${id}',${quantity},N'${option}',N'${method}',N'${address}')  
            `)
            req.flash('Success', 'Order successfully');
            res.redirect('/');
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
    edit: async (req, res) => {
        try {
            const pool = await DB_USER;
            const { id } = req.params;
            const userId = req.cookies.Id;
            console.log(req.body);
            const { address } = req.body;

            const itemData = await pool.request().query(`
            UPDATE CHI_TIET_DON_HANG
            SET DiaChiGiaoHang = N'${address}'
            WHERE ID_DonHang = '${id}'
            `)

            req.flash('Success', 'Update successfully');
            res.redirect('/');
        } catch (err) {
            console.log(err);
            // res.render('user', { type: 'error', message: 'Something wrong!!! Please try again.' });
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
    destroy: async (req, res) => {
        try {
            const pool = await DB_ADMIN;
            const { id } = req.params;
            const userId = req.cookies.Id;

            const data = await pool.request().query(`
            EXEC sp_HuyDonHang_KhachHang '${userId}','${id}'
            `)

            req.flash('Success', 'Destroy item successfully');
            res.redirect('/');
        } catch (err) {
            console.log(err);
            // res.render('user', { type: 'error', message: 'Something wrong!!! Please try again.' });
            req.flash('Error', `${err}`);
            res.redirect('/');
        }
    },
};

module.exports = CartController;
