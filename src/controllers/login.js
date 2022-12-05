const jwt = require('jsonwebtoken');
const dotenv = require("dotenv");
const { DB_USER, DB_ADMIN } = require('../config/database');
dotenv.config();

const loginController = {
    index: async (req, res) => {
        res.render('login');
    },

    save: async (req, res) => {
        try {
            const { username, password, id, type } = req.body;
            // console.log(req.body);
            switch (type) {
                case 'admin': {
                    if (username != process.env.DATABASE_DEV_USERNAME_ADMIN) {
                        res.render('login', { type: 'error', message: 'Username doesn\'t exist' });
                    } else {
                        if (password != process.env.DATABASE_DEV_PASSWORD_ADMIN) {
                            res.render('login', { type: 'error', message: 'Password wrong, please try again' });
                        } else {
                            const token = jwt.sign({ username, password, id }, process.env.JWT_SECRET, { expiresIn: '1h' });
                            req.flash('Login', 'Login successfully');
                            res.cookie('Id', id);
                            res.cookie("authentication", token);
                            res.redirect('/admin');
                        }
                    }
                    break;
                }
                case 'employee': {
                    if (username != process.env.DATABASE_DEV_USERNAME_EMPLOYEE) {
                        res.render('login', { type: 'error', message: 'Username doesn\'t exist' });
                    } else {
                        if (password != process.env.DATABASE_DEV_PASSWORD_EMPLOYEE) {
                            res.render('login', { type: 'error', message: 'Password wrong, please try again' });
                        } else {
                            const token = jwt.sign({ username, password, id }, process.env.JWT_SECRET, { expiresIn: '1h' });
                            req.flash('Login', 'Login successfully');
                            res.cookie('Id', id);
                            res.cookie("authentication", token);
                            res.redirect('/admin');
                        }
                    }
                    break;
                }
                case 'driver': {
                    if (username != process.env.DATABASE_DEV_USERNAME_DRIVER) {
                        res.render('login', { type: 'error', message: 'Username doesn\'t exist' });
                    } else {
                        if (password != process.env.DATABASE_DEV_PASSWORD_DRIVER) {
                            res.render('login', { type: 'error', message: 'Password wrong, please try again' });
                        } else {
                            const pool = await DB_ADMIN;
                            const data = await pool.request().query(`SELECT * FROM TAI_XE WHERE ID_TaiXe = '${id}'`);
                            const driver = data.recordset[0];

                            const token = jwt.sign(driver, process.env.JWT_SECRET, { expiresIn: '1h' });
                            req.flash('Login', 'Login successfully');
                            res.cookie('Id', id);
                            res.cookie("authentication", token);
                            res.redirect('/driver');
                        }

                    }
                    break;
                }
                case 'partner': {
                    if (username != process.env.DATABASE_DEV_USERNAME_PARTNER) {
                        res.render('login', { type: 'error', message: 'Username doesn\'t exist' });
                    } else {
                        if (password != process.env.DATABASE_DEV_PASSWORD_PARTNER) {
                            res.render('login', { type: 'error', message: 'Password wrong, please try again' });
                        } else {
                            const pool = await DB_ADMIN;
                            const data = await pool.request().query(`SELECT * FROM DOI_TAC WHERE ID_DoiTac = '${id}'`);
                            const partner = data.recordset[0];

                            const token = jwt.sign(partner, process.env.JWT_SECRET, { expiresIn: '1h' });
                            req.flash('Login', 'Login successfully');
                            res.cookie('Id', id);
                            res.cookie("authentication", token);
                            res.redirect('/partner');
                        }
                    }
                    break;
                }
                default: {
                    if (username != process.env.DATABASE_DEV_USERNAME_USER) {
                        res.render('login', { type: 'error', message: 'Username doesn\'t exist' });
                    } else {
                        if (password != process.env.DATABASE_DEV_PASSWORD_USER) {
                            res.render('login', { type: 'error', message: 'Password wrong, please try again' });
                        } else {
                            const pool = await DB_ADMIN;
                            const data = await pool.request().query(`SELECT * FROM KHACH_HANG WHERE ID_KhachHang = '${id}'`);
                            const user = data.recordset[0];

                            const token = jwt.sign(user, process.env.JWT_SECRET, { expiresIn: '1h' });
                            req.flash('Login', 'Login successfully');
                            res.cookie('Id', id);
                            res.cookie("authentication", token);
                            res.redirect('/');
                        }
                    }
                }
            }
        } catch (err) {
            console.log(err);
            res.render('login', { type: 'error', message: 'Something wrong!!! Please try again.' });
        }

    },

    destroy: async (req, res) => {
        res.clearCookie('authentication');
        res.redirect('/auth/login');
    },
}

module.exports = loginController