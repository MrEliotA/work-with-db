# MySQL — راهنمای عملی (شاخه mysql)

این شاخه برای کار با **MySQL** است: نصب، راه‌اندازی سریع با Docker Compose، پیکربندی `my.cnf`،
نمایش و تحلیل پردازه‌ها (Process List)، پشتیبان‌گیری/بازگردانی، ایمپورت/اکسپورت CSV،
و اتصال کلاینت‌ها (CLI, Python, Node.js, Go, PHP).

> **نکته مهم:** تمام *کامنت‌های داخل کد* کاملاً **انگلیسی** و حرفه‌ای هستند.

## نصب

### Docker Compose (پیشنهادی)

```bash
docker compose up -d
```

### نصب بومی لینوکسی (Ubuntu/Debian)

```bash
sudo apt update && sudo apt install -y mysql-server
sudo systemctl enable --now mysql
sudo mysql_secure_installation
```

## فایل پیکربندی سرور (`config/my.cnf`)

- `utf8mb4` + collation مناسب
- فعال‌سازی `performance_schema`
- اسلوکوئری‌لاگ اختیاری

## مشاهده و تحلیل Processها

- SQL و **one-liner**‌های ترمینال برای تحلیل کاربران/هاست‌ها/کوئری‌های طولانی/لاک‌ها
- نمونه خروجی هر کدام کنار دستور

## پشتیبان‌گیری/بازگردانی

- `mysqldump` برای logical backup
- `mysqlpump` برای MySQL
- `mariabackup` برای MariaDB (در شاخه مربوطه خواهد آمد)

## ایمپورت/اکسپورت CSV

- `SELECT ... INTO OUTFILE`
- `LOAD DATA INFILE`

## اتصال کلاینت‌ها

- CLI, Python (`pymysql`), Node.js (`mysql2`), Go (`go-sql-driver/mysql`), PHP (PDO)

برای جزئیات، فایل‌های داخل پوشه‌ها را ببینید.
