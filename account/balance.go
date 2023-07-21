// Copyright 2022 IBM Corp. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package account

import (
	"database/sql"
	"sync"

	"github.com/golang/protobuf/proto"
	_ "github.com/lib/pq"

	cmap "github.com/orcaman/concurrent-map"
	// pb "github.com/hyperledger-labs/mirbft/protobufs"
	"github.com/hyperledger-labs/mirbft/config"
	pb "github.com/hyperledger-labs/mirbft/protobufs"
	logger "github.com/rs/zerolog/log"
)

var (
	// All entries indexed by sequence number
	// balance = sync.Map{}
	balance = cmap.ConcurrentMap[string, float64]{}

	// Guards logSubscribers, logSubscribersOutOfOrder, entrySubscribers and firstEmptySN
	lock = sync.Mutex{}

	A = 1
)

func init() {
	balance = cmap.New[float64]()

	logger.Debug().Int("a", A).Msg("In balance init() !")
}

func LoadData() {
	connStr := "user=" + config.Config.User + " dbname=" + config.Config.DbName + " password=" + config.Config.Password + " host=" + config.Config.Host + " sslmode=disable"
	logger.Debug().Str("connStr", connStr).Msg("dialing postgresql !")
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		logger.Fatal().Str("error", err.Error()).Msg("Connect to database fail !")
	}
	rows, err := db.Query("select * from balance_new")
	if err != nil {
		panic(err)
	}

	cnt := 0
	for rows.Next() {
		var accountHash string
		var balance float64
		err = rows.Scan(&accountHash, &balance)
		if err != nil {
			panic(err)
		}
		UpdateBalance(accountHash, balance)
		cnt++
	}

	logger.Debug().Int("AccountCnt", cnt).Msg("Loaded balance !")

}

// CommitEntry a decided value to the log.
// This is the final decision that will never be reverted.
// If this is the first empty slot of the log, push the Entry (and potentially other previously committed entries with
// higher sequence numbers) to the subscribers.
func UpdateBalance(accountHash string, amount float64) {
	// logger.Debug().Str("accountHash", accountHash).Float64("Amount", amount).Msg("Updating balance")
	balance.Set(accountHash, amount)

	// if _, loaded := balance.LoadOrStore(accountHash, amount); loaded {
	// 	logger.Debug().Str("accountHash", accountHash).Msg("Updating balance")
	// }
	// // tracing.MainTrace.Event(tracing.COMMIT, int64(entry.Sn), 0)
	// lock.Lock()

	// lock.Unlock()
}

// Retrieve Entry with sequence number sn.
func GetBalance(accountHash string) float64 {
	e, ok := balance.Get(accountHash)
	if ok {
		return e
	} else {
		return -1.0
	}
}

func transfer(sender string, receiver string, amount float64) {
	senderBalance, ok := balance.Get(sender)
	if ok {
		UpdateBalance(sender, senderBalance-amount)
	}
	receiveralance, ok2 := balance.Get(receiver)
	if ok2 {
		UpdateBalance(receiver, receiveralance+amount)
	}
}

func CommitEntry(requests []*pb.ClientRequest) {
	logger.Debug().Int("requestsLen", len(requests)).Msg("account CommitEntry")
	for _, request := range requests {
		tx := &pb.Transaction{}
		proto.Unmarshal(request.Payload, tx)
		transfer(tx.SenderHash, tx.ReceiverHash, tx.Amount+tx.Fee)
	}
	logger.Debug().Float64("Amount", GetBalance("0xa845b9758cfe9de0d0099b9c2f58517d03c4df31")).Msg("Account: 0xa845b9758cfe9de0d0099b9c2f58517d03c4df31")
}
