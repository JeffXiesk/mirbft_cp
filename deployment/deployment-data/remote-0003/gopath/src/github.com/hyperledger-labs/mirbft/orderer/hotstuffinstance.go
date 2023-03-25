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

package orderer

import (
	"github.com/hyperledger-labs/mirbft/manager"
	// "github.com/hyperledger-labs/mirbft/messenger"
	// pb "github.com/hyperledger-labs/mirbft/protobufs"
	logger "github.com/rs/zerolog/log"
)

type hotStuffInstance struct {
	view			int	
	hi_real   		*hotStuffInstance_real
	serializer      *ordererChannel
	hiList 			[]*hotStuffInstance_real
}

func (hi *hotStuffInstance) init(seg manager.Segment, orderer *HotStuffOrderer) {
	// hi.serializer = newOrdererChannel(channelSize)
	temp := &hotStuffInstance_real{}
	temp.init(seg, orderer)
	hi.hi_real = temp
	hi.serializer = hi.hi_real.serializer
	hi.hi_real.hi_proxy = hi
	hi.view = hi.hi_real.segment.SegID()
}

func (hi *hotStuffInstance) setHiList(hiList []*hotStuffInstance) {
	logger.Debug().Msgf("HiList is : %v", hiList)
	for i:=len(hi.hiList);i<len(hiList);i++ {
		hi.hiList = append(hi.hiList, hiList[i].hi_real)
	}
}

func (hi *hotStuffInstance) start() {
	hi.hi_real.start()
}

// Every time after propose, rotate leader
func (hi *hotStuffInstance) proposeSN(sn int32) {
	hi.hi_real.proposeSN_real(sn)
	hi.view+=1
	hi.hi_real = hi.hiList[hi.view%len(hi.hiList)]
}

func (hi *hotStuffInstance) stopProposing() {
	hi.hi_real.stopProposing()
}

func (hi *hotStuffInstance) subscribeToBacklog() {
	hi.hi_real.subscribeToBacklog()
}

func (hi *hotStuffInstance) processSerializedMessages() {
	go hi.hi_real.processSerializedMessages()

}
