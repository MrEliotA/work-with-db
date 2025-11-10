# clients/python/conn.py
# pip install pymysql
import os
import pymysql

# Use environment variables for credentials; never hardcode secrets.
conn = pymysql.connect(
    host=os.getenv("DB_HOST", "localhost"),
    port=int(os.getenv("DB_PORT", "3306")),
    user=os.getenv("DB_USER", "app"),
    password=os.getenv("DB_PASSWORD", "app_password"),
    database=os.getenv("DB_NAME", "app_db"),
    charset="utf8mb4",
    autocommit=False,
)
with conn.cursor() as cur:
    cur.execute("SELECT NOW();")
    print(cur.fetchone())
conn.commit()
conn.close()
