// clients/go/main.go
// go get github.com/go-sql-driver/mysql
package main
import (
  "database/sql"
  "fmt"
  "os"
)
func main(){
  // parseTime=true maps DATETIME/TIMESTAMP to time.Time.
  dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true&charset=utf8mb4,utf8",
    getenv("DB_USER","app"), getenv("DB_PASSWORD","app_password"),
    getenv("DB_HOST","localhost"), getenv("DB_PORT","3306"), getenv("DB_NAME","app_db"))
  db, err := sql.Open("mysql", dsn)
  if err != nil { panic(err) }
  defer db.Close()
  var now string
  if err := db.QueryRow("SELECT NOW()").Scan(&now); err != nil { panic(err) }
  fmt.Println(now)
}
func getenv(k, d string) string { v := os.Getenv(k); if v=="" { return d }; return v }
