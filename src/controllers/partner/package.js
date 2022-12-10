const { DB_PARTNER } = require("../../config/database");

const PackageController = {
    async index(req, res) {
        try {
            const pool = await DB_PARTNER;
            const { id } = req.params;
            const packageData = await pool.request().query(`
            SELECT DH.*, CTDH.*
            FROM THUC_DON TD, MON M, CHI_TIET_DON_HANG CTDH, DON_HANG DH
            WHERE TD.ID_CuaHang = '${id}' AND TD.ID_Mon = M.ID_Mon 
            AND M.ID_Mon = CTDH.ID_Mon AND CTDH.ID_DonHang = DH.ID_DonHang`);

            var items = packageData.recordset;
            items = items.map(item => ({
                ...item,
                ID_DonHang: item.ID_DonHang[0].trim(),
                ID_KhachHang: item.ID_KhachHang.trim(),
                ID_TaiXe: item.ID_TaiXe.trim(),
            }))
            res.render('partner/package', { items, ID_CuaHang: id });
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

            const itemData = await pool.request().query(`
            SELECT * FROM THUC_DON TD, MON M, CHI_TIET_DON_HANG CTDH, DON_HANG DH
            WHERE DH.ID_DonHang = '${id}' AND CTDH.ID_DonHang = DH.ID_DonHang 
            AND CTDH.ID_Mon = M.ID_Mon AND M.ID_Mon = TD.ID_Mon
            `)
            const item = itemData.recordset[0];
            console.log(item);
            res.render('partner/package/edit', {
                item: {
                    ...item,
                    ID_DonHang: item.ID_DonHang[0].trim(),
                    ID_KhachHang: item.ID_KhachHang.trim(),
                    ID_TaiXe: item.ID_TaiXe.trim(),
                    ID_CuaHang: item.ID_CuaHang.trim(),
                    ID_Mon: item.ID_Mon[0].trim(),
                }
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
            const { status } = req.body;

            const itemData = await pool.request().query(`
            UPDATE DON_HANG
            SET TinhTrangDonHang = N'${status}'
            WHERE ID_DonHang = '${id}'
            `)

            req.flash('Success', 'Update a package successfully');
            res.redirect('/partner');
        } catch (err) {
            console.log(err);
            req.flash('Error', `${err}`);
            res.redirect('/partner');
        }
    },
};

module.exports = PackageController;
