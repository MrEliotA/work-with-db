# Process Monitoring (MySQL)

> All code comments are in **English**, outputs are examples.

## Show sessions (concise)
```sql
SHOW PROCESSLIST; -- or SHOW FULL PROCESSLIST;
```
**Sample output**
```
+-----+-------+-----------+------+---------+------+----------+------------------+
| Id  | User  | Host      | db   | Command | Time | State    | Info             |
+-----+-------+-----------+------+---------+------+----------+------------------+
|  57 | app   | 10.0.0.10 | app  | Query   |   12 | executing| SELECT ...       |
+-----+-------+-----------+------+---------+------+----------+------------------+
```

## CLI: count only "Query" state PIDs
```bash
mysql -uroot -e "SHOW PROCESSLIST;" | grep -w Query | awk '{print $1}' | sort | uniq -c
```
**Sample output**
```
  3 57
  2 42
```

## Top users by active sessions (SQL)
```sql
SELECT USER, COUNT(*) AS sess
FROM information_schema.PROCESSLIST
WHERE COMMAND NOT IN ('Sleep')
GROUP BY USER
ORDER BY sess DESC
LIMIT 10;
```
**Sample output**
```
+---------+------+
| USER    | sess |
+---------+------+
| app     |   12 |
| report  |    3 |
+---------+------+
```

## Longest running queries (SQL)
```sql
SELECT ID, USER, HOST, TIME AS sec_running, LEFT(INFO,200) AS sql_snippet
FROM information_schema.PROCESSLIST
WHERE COMMAND NOT IN ('Sleep')
ORDER BY TIME DESC
LIMIT 10;
```
**Sample output**
```
+-----+------+-----------+-------------+--------------------------+
| ID  | USER | HOST      | sec_running | sql_snippet              |
+-----+------+-----------+-------------+--------------------------+
| 123 | app  | 10.0.0.10 |         112 | SELECT * FROM orders ... |
+-----+------+-----------+-------------+--------------------------+
```

## Group by state (SQL)
```sql
SELECT IFNULL(STATE,'N/A') AS state, COUNT(*) AS cnt
FROM performance_schema.threads t
JOIN information_schema.PROCESSLIST p ON p.ID = t.PROCESSLIST_ID
GROUP BY state
ORDER BY cnt DESC;
```

## Sessions per host/IP (CLI)
```bash
mysql -N -e "SELECT HOST FROM information_schema.PROCESSLIST;" | sed 's/:.*//' | sort | uniq -c | sort -nr | head
```
**Sample output**
```
   15 10.0.0.10
    5 10.0.0.11
```

## Find queries waiting for locks (SQL)
```sql
SELECT th.PROCESSLIST_ID AS id, th.PROCESSLIST_USER AS user,
       dl.LOCK_MODE, dl.OBJECT_SCHEMA, dl.OBJECT_NAME
FROM performance_schema.data_locks dl
JOIN performance_schema.threads th ON th.THREAD_ID = dl.THREAD_ID
ORDER BY th.PROCESSLIST_ID DESC
LIMIT 20;
```

## Heavy statements by average time (digest) (SQL)
```sql
SELECT DIGEST_TEXT, COUNT_STAR AS execs,
       ROUND(AVG_TIMER_WAIT/1000000000000,3) AS avg_sec
FROM performance_schema.events_statements_summary_by_digest
ORDER BY avg_sec DESC
LIMIT 10;
```

## Server load snapshot (SQL)
```sql
SELECT 'Threads_running' AS metric, VARIABLE_VALUE FROM performance_schema.global_status WHERE VARIABLE_NAME='THREADS_RUNNING'
UNION ALL
SELECT 'Connections', VARIABLE_VALUE FROM performance_schema.global_status WHERE VARIABLE_NAME='THREADS_CONNECTED'
UNION ALL
SELECT 'QPS', VARIABLE_VALUE FROM performance_schema.global_status WHERE VARIABLE_NAME='QUERIES';
```
