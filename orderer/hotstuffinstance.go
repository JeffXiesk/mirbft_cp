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
	"github.com/hyperledger-labs/mirbft/messenger"
	pb "github.com/hyperledger-labs/mirbft/protobufs"
	logger "github.com/rs/zerolog/log"
)

type hotStuffInstance struct {
	hi_real   		hotStuffInstance_real
	serializer      *ordererChannel  
}

func (hi *hotStuffInstance) init(seg manager.Segment, orderer *HotStuffOrderer) {
	hi.serializer = newOrdererChannel(channelSize)
	temp := &hotStuffInstance_real{}
	temp.init(seg, orderer)
	hi.hi_real = *temp
}

func (hi *hotStuffInstance) start() {
	hi.hi_real.start()

	list := make([]int32,0,0)
	list = append(list,0)
	list = append(list,1)
	list = append(list,2)
	list = append(list,3)
	for _, nodeID := range list {
		// Skip sending to self
		// if nodeID == membership.OwnID {
		// 	continue
		// }
		messenger.EnqueueMsg(&pb.ProtocolMessage{
			SenderId: 0,
			Sn:       0,
			Msg: 		nil,
			Type: "ProtocolMessage_Proposal",
			Hightimestamp: 0,
			FakeView:	   0,
		}, nodeID)
	}
}

func (hi *hotStuffInstance) stopProposing() {
	hi.hi_real.stopProposing()
}

func (hi *hotStuffInstance) subscribeToBacklog() {
	hi.hi_real.subscribeToBacklog()
}

// func (hi *hotStuffInstance) processSerializedMessages() {
// 	go hi.hi_real.processSerializedMessages()
// 	for msg := range hi.serializer.channel {
// 		logger.Debug().Int32("Hightimestamp", msg.Hightimestamp).Msg("Receive Msg !")
// 	}	
// 	for msg := range hi.hi_real.serializer.channel {
// 		logger.Debug().Int32("Hightimestamp", msg.Hightimestamp).Msg("Receive Msg !")
// 	}	
// }


func (hi *hotStuffInstance) processSerializedMessages() {
	for msg := range hi.serializer.channel {
		logger.Debug().Msg("============================")
		if msg == nil {
			return
		}
	}
}
