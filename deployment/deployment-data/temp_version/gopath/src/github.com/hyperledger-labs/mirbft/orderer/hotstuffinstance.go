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
	pb "github.com/hyperledger-labs/mirbft/protobufs"
	logger "github.com/rs/zerolog/log"
	"fmt"
)

type hotStuffInstance struct {
	hi_real   		*hotStuffInstance_real
	serializer      *ordererChannel
	hiList 			[]*hotStuffInstance
}

func (hi *hotStuffInstance) setHiList(hiList []*hotStuffInstance) {
	logger.Debug().Msgf("HiList is : %v", hiList)
	hi.hiList = hiList
}

func (hi *hotStuffInstance) init(seg manager.Segment, orderer *HotStuffOrderer) {
	// hi.serializer = newOrdererChannel(channelSize)
	temp := &hotStuffInstance_real{}
	temp.init(seg, orderer)
	hi.hi_real = temp
	hi.serializer = hi.hi_real.serializer
}

func (hi *hotStuffInstance) start() {
	hi.hi_real.start()
}

func (hi *hotStuffInstance) stopProposing() {
	hi.hi_real.stopProposing()
}

func (hi *hotStuffInstance) subscribeToBacklog() {
	hi.hi_real.subscribeToBacklog()
}

// func (hi *hotStuffInstance) processSerializedMessages() {
// 	go hi.hi_real.processSerializedMessages()

// }

func (hi *hotStuffInstance) processSerializedMessages() {
	logger.Debug().
		Int("segment", hi.hi_real.segment.SegID()).
		Msg("Starting serialized message processing.")
	for msg := range hi.hi_real.serializer.channel {
		if msg == nil {
			return
		}
		logger.Debug().Msg("==============")
		switch m := msg.Msg.(type) {
		case *pb.ProtocolMessage_HotstuffNewview:
			logger.Debug().Int32("sn", msg.Sn).Int32("senderId", msg.SenderId).Msg("Received NEW VIEW")
			newview := m.HotstuffNewview
			err := hi.hi_real.handleNewView(newview, msg.Sn, msg.SenderId)
			if err != nil {
				logger.Error().
					Err(err).
					Int("segment", hi.hi_real.segment.SegID()).
					Msg("HotStuffOrderer cannot handle new view message.")
			}
		case *pb.ProtocolMessage_Timeout:
			// If the timeout sequence number is -1 (this is the case for new view timeouts), there is no pbftBatch.
			// Otherwise, there is always a pbftBatch for every sequence number of the current view.
			if m.Timeout.View < hi.hi_real.view || (m.Timeout.Sn != -1 && hi.hi_real.nodes[hi.hi_real.sn2height[m.Timeout.Sn]].announced) {
				// If the views in this debug message are the same, that means the request has been committed in the meantime.
				logger.Debug().
					Int32("sn", m.Timeout.Sn).
					Int("segment", hi.hi_real.segment.SegID()).
					Int32("timeoutView", m.Timeout.View).
					Int32("currentView", hi.hi_real.view).
					Msg("Ignoring outdated timeout.")
			} else {
				logger.Warn().
					Int("segment", hi.hi_real.segment.SegID()).
					Int32("sn", msg.Sn).
					Int32("view", m.Timeout.View).
					Msg("Timeout")
				hi.hi_real.sendNewView()
			}
		case *pb.ProtocolMessage_Proposal:
			logger.Debug().Int32("sn", msg.Sn).Int32("senderId", msg.SenderId).Msg("Received PROPOSAL")
			proposal := m.Proposal
			err := hi.hi_real.handleProposal(proposal, msg)
			if err != nil {
				logger.Error().
					Err(err).
					Int("segment", hi.hi_real.segment.SegID()).
					Msg("HotStuff orderer cannot handle proposal message.")
			}
		case *pb.ProtocolMessage_Vote:
			logger.Debug().Int32("sn", msg.Sn).Int32("senderId", msg.SenderId).Msg("Received VOTE")
			vote := m.Vote
			// err := hi.handleVote(vote, msg.Sn, msg.SenderId)
			err := hi.hi_real.handleVote(vote, msg.Sn, msg.SenderId, msg.Hightimestamp)
			if err != nil {
				logger.Error().
					Err(err).
					Int("segment", hi.hi_real.segment.SegID()).
					Msg("HotStuff orderer cannot handle vote message.")
			}
		case *pb.ProtocolMessage_MissingEntry:
			hi.hi_real.handleMissingEntry(m.MissingEntry)

		default:
			logger.Error().
				Str("msg", fmt.Sprint(m)).
				Int("segment", hi.hi_real.segment.SegID()).
				Int32("sn", msg.Sn).
				Int32("senderID", msg.SenderId).
				Msg("HotSruff orderer cannot handle message. Unknown message type.")
		}
	}
}
