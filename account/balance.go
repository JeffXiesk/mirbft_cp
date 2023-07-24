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
	"bufio"
	"io"
	"os"
	"strconv"
	"strings"
	"sync"

	"github.com/golang/protobuf/proto"
	_ "github.com/lib/pq"

	cmap "github.com/orcaman/concurrent-map"
	// pb "github.com/hyperledger-labs/mirbft/protobufs"

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
	cnt := 0

	file, err := os.Open("/home/niu/balance.csv")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	br := bufio.NewReader(file)
	for {
		cnt++
		a, _, c := br.ReadLine()
		if c == io.EOF {
			break
		}
		res := strings.Split(string(a), ",")
		balance, err := strconv.ParseFloat(res[1], 64)
		if err != nil {
			logger.Fatal().Msg(err.Error())
		}
		UpdateBalance(res[0], balance)
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

func RequestIsValid(request *pb.ClientRequest) bool {
	tx := &pb.Transaction{}
	proto.Unmarshal(request.Payload, tx)
	senderBalance, ok := balance.Get(tx.SenderHash)
	if ok {
		if senderBalance >= tx.Amount+tx.Fee {
			return true
		}
		return false
	} else {
		return true
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
	logger.Debug().Float64("Amount", GetBalance("7293")).Msg("Account: 7293")
}
