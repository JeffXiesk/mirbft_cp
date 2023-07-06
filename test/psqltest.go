package main

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/lib/pq"
)

type Transaction struct {
	Id            int
	BlockHeight   int
	BlockHash     string
	BlockTime     time.Time
	CreatedAt     int
	Confirmations int
	Fee           int
	Hash          string
	InputsCount   int
	InputsValue   int64
	IsCoinbase    bool
	IsDoubleSpend bool
	IsSwTx        bool
	LockTime      int
	OutputsCount  int
	OutputsValue  int64
	Sigops        int
	Size          int
	Version       int
	Vsize         int
	Weight        int
	WitnessHash   string
	Inputs        string
	Outputs       string
}

func main() {
	// PostgreSQL 数据库连接字符串
	connStr := "user=btcdata dbname=transaction password=123456 host=10.16.78.180 sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// 执行 SELECT 语句
	rows, err := db.Query("SELECT * FROM transactions where id = 10")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	// 读取和打印查询结果
	// cnt := 0
	// start := time.Now()
	// for rows.Next() {
	// 	var tx Transaction
	// 	if err := rows.Scan(&tx.Id, &tx.BlockHeight, &tx.BlockHash, &tx.BlockTime, &tx.CreatedAt, &tx.Confirmations, &tx.Fee, &tx.Hash, &tx.InputsCount, &tx.InputsValue, &tx.IsCoinbase, &tx.IsDoubleSpend, &tx.IsSwTx, &tx.LockTime, &tx.OutputsCount, &tx.OutputsValue, &tx.Sigops, &tx.Size, &tx.Version, &tx.Vsize, &tx.Weight, &tx.WitnessHash, &tx.Inputs, &tx.Outputs); err != nil {
	// 		log.Fatal(err)
	// 	}
	// 	fmt.Printf("%+v\n", tx)
	// 	cnt += 1
	// 	if cnt >= 500000 {
	// 		fmt.Print(time.Now().Sub(start))
	// 		break
	// 	}
	// }

	start := time.Now()
	var tx Transaction
	err = db.QueryRow("SELECT * FROM transactions WHERE id=$1", 10).Scan(&tx.Id, &tx.BlockHeight, &tx.BlockHash, &tx.BlockTime, &tx.CreatedAt, &tx.Confirmations, &tx.Fee, &tx.Hash, &tx.InputsCount, &tx.InputsValue, &tx.IsCoinbase, &tx.IsDoubleSpend, &tx.IsSwTx, &tx.LockTime, &tx.OutputsCount, &tx.OutputsValue, &tx.Sigops, &tx.Size, &tx.Version, &tx.Vsize, &tx.Weight, &tx.WitnessHash, &tx.Inputs, &tx.Outputs)
	if err != nil {
		if err == sql.ErrNoRows {
			fmt.Println("No rows were returned!")
		} else {
			log.Fatal(err)
		}
	}
	fmt.Print(time.Now().Sub(start))

	fmt.Printf("\n%+v\n", tx)

	// 检查是否有错误发生
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}
}
