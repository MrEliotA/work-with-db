// clients/node/index.js
// npm i mysql2 dotenv
require('dotenv').config();
const mysql = require('mysql2/promise');

(async () => {
  // Always use parameterized queries to prevent SQL injection.
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER || 'app',
    password: process.env.DB_PASSWORD || 'app_password',
    database: process.env.DB_NAME || 'app_db',
    namedPlaceholders: true,
  });
  const [rows] = await conn.execute('SELECT NOW() AS now');
  console.log(rows);
  await conn.end();
})();
