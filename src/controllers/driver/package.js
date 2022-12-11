const { DB_DRIVER } = require("../../config/database");

const PackageController = {
    async index(req, res) {
        try {
            const successMsg = req.flash('Success')[0];
            const errorMsg = req.flash('Error')[0];
            const pool = await DB_DRIVER;
            const driverId = req.cookies.Id;
            const packageData = await pool.request().query(`EXEC sp_XemDonHang_TaiXe '${driverId}'`);

            var items = packageData.recordset;
            items = items.map(item => ({
                ...item,
                ID_DonHang: item.ID_DonHang.trim(),
                ID_KhachHang: item.ID_KhachHang.trim(),
                ID_TaiXe: item.ID_TaiXe.trim(),
            }));

            if (successMsg) {
                res.render('driver', { items, driverId, type: 'success', message: successMsg });
            } else if (errorMsg) {
                res.render('driver', { items, driverId, type: 'error', message: errorMsg });
            } else {
                res.render('driver', { items, driverId });
            }
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/driver');
        }
    },
    async view(req, res, next) {
        try {
            const pool = await DB_DRIVER;
            const { id } = req.params;

            const itemData = await pool.request().query(`
            SELECT * 
            FROM DON_HANG DH, CHI_TIET_DON_HANG CTDH
            WHERE DH.ID_DonHang = '${id}' AND DH.ID_DonHang = CTDH.ID_DonHang
            `);
            const item = itemData.recordset[0];
            console.log(item);
            res.render('driver/edit', {
                item: {
                    ...item,
                    ID_DonHang: item.ID_DonHang[0].trim(),
                    ID_KhachHang: item.ID_KhachHang.trim(),
                    ID_TaiXe: item.ID_TaiXe.trim(),
                }
            });
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/driver');
        }
    },
    async edit(req, res, next) {
        try {
            const pool = await DB_DRIVER;
            const { id } = req.params;
            const { status } = req.body;

            const itemData = await pool.request().query(`
            EXEC usp_capNhatTinhTrangDonHang '${id}', N'${status}'
            `);

            req.flash('Success', 'Update a package successfully');
            res.redirect('/driver');
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/driver');
        }
    },
};

module.exports = PackageController;
