const jwt = require('jsonwebtoken');
const dotenv = require("dotenv");
dotenv.config();

const Authentication = (req, res, next) => {
    const token = req.cookies?.authentication;

    if (token) {
        jwt.verify(token, process.env.JWT_SECRET, (err, data) => {
            if (err) {
                return res.redirect('/auth/login');
            } else {
                req.user = data;
                next();
            }
        });
    } else {
        return res.redirect('/auth/login');
    }
}

module.exports = Authentication;