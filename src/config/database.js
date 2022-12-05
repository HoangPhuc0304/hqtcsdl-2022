const sql = require('mssql/msnodesqlv8');
const dotenv = require("dotenv");
dotenv.config();

const config = {
  admin: {
    server: process.env.DATABASE_DEV_SERVER,
    user: process.env.DATABASE_DEV_USERNAME_ADMIN,
    password: process.env.DATABASE_DEV_PASSWORD_ADMIN,
    database: process.env.DATABASE_DEV_NAME,
    driver: 'msnodesqlv8',
  },
  employee: {
    server: process.env.DATABASE_DEV_SERVER,
    user: process.env.DATABASE_DEV_USERNAME_EMPLOYEE,
    password: process.env.DATABASE_DEV_PASSWORD_EMPLOYEE,
    database: process.env.DATABASE_DEV_NAME,
    driver: 'msnodesqlv8',
  },
  partner: {
    server: process.env.DATABASE_DEV_SERVER,
    user: process.env.DATABASE_DEV_USERNAME_PARTNER,
    password: process.env.DATABASE_DEV_PASSWORD_PARTNER,
    database: process.env.DATABASE_DEV_NAME,
    driver: 'msnodesqlv8',
  },
  driver: {
    server: process.env.DATABASE_DEV_SERVER,
    user: process.env.DATABASE_DEV_USERNAME_DRIVER,
    password: process.env.DATABASE_DEV_PASSWORD_DRIVER,
    database: process.env.DATABASE_DEV_NAME,
    driver: 'msnodesqlv8',
  },
  user: {
    server: process.env.DATABASE_DEV_SERVER,
    user: process.env.DATABASE_DEV_USERNAME_USER,
    password: process.env.DATABASE_DEV_PASSWORD_USER,
    database: process.env.DATABASE_DEV_NAME,
    driver: 'msnodesqlv8',
  }
};

const DB_ADMIN = new sql.ConnectionPool(config.admin).connect().then(pool => {
  return pool;
})
const DB_EMPLOYEE = new sql.ConnectionPool(config.employee).connect().then(pool => {
  return pool;
})
const DB_PARTNER = new sql.ConnectionPool(config.partner).connect().then(pool => {
  return pool;
})
const DB_DRIVER = new sql.ConnectionPool(config.driver).connect().then(pool => {
  return pool;
})
const DB_USER = new sql.ConnectionPool(config.user).connect().then(pool => {
  return pool;
})
module.exports = {
  DB_ADMIN,
  DB_EMPLOYEE,
  DB_PARTNER,
  DB_DRIVER,
  DB_USER,
};
