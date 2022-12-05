const express = require('express');
const handlebars = require('express-handlebars');
const route = require('./src/routes/routes');
const path = require("path");
const flash = require('connect-flash');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const helpers = require('./src/helpers');
const app = express()
const PORT = 3000

app.use(express.json());
app.use(express.urlencoded());
app.use(cookieParser());
app.use(session({
    secret: 'secret',
    resave: false,
    saveUninitialized: false,
}));
app.use(flash());
app.use("/static", express.static(path.join(__dirname, "src/public")));

app.engine('hbs', handlebars.engine({
    extname: '.hbs',
    defaultLayout: 'main.hbs',
    helpers,
}));
app.set('views', './src/views');
app.set('view engine', '.hbs');

app.use((err, req, res, next) => {
    res.status(500).send(err.message);
});

route(app);
app.listen(PORT, () => {
    console.log('Server is running on port ' + PORT);
});