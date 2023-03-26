write-file $ready_file READY

#========================================
# 0000
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0000/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0000-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0000.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0000-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0000.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0000/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0000-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0000.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0000/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0000/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0000/slave-__id__/peer.trc experiment-output/0000/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0000/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0000/slave-__id__/client experiment-output/0000/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0000/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0000/slave-__id__/client experiment-output/0000/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0000/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0000/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0000/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0000/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0000/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0000/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0000/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0000-slave-__id__.tar.gz experiment-output/0000/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0000-slave-__id__.tar.gz experiment-output/0000/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0000/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0000-slave-__id__.tar.gz experiment-output/0000/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0000/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0000-logs.log stubborn-scp.sh 10 experiment-output-0000-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0000-logs.log stubborn-scp.sh 10 experiment-output-0000-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0000/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0000-logs.log stubborn-scp.sh 10 experiment-output-0000-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0000/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0000


#========================================
# 0001
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0001/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0001-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0001.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0001-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0001.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0001/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0001-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0001.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0001/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0001/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0001/slave-__id__/peer.trc experiment-output/0001/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0001/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0001/slave-__id__/client experiment-output/0001/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0001/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0001/slave-__id__/client experiment-output/0001/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0001/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0001/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0001/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0001/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0001/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0001/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0001/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0001-slave-__id__.tar.gz experiment-output/0001/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0001-slave-__id__.tar.gz experiment-output/0001/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0001/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0001-slave-__id__.tar.gz experiment-output/0001/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0001/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0001-logs.log stubborn-scp.sh 10 experiment-output-0001-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0001-logs.log stubborn-scp.sh 10 experiment-output-0001-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0001/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0001-logs.log stubborn-scp.sh 10 experiment-output-0001-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0001/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0001


#========================================
# 0002
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0002/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0002-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0002.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0002-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0002.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0002/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0002-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0002.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0002/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0002/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0002/slave-__id__/peer.trc experiment-output/0002/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0002/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0002/slave-__id__/client experiment-output/0002/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0002/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0002/slave-__id__/client experiment-output/0002/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0002/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0002/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0002/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0002/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0002/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0002/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0002/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0002-slave-__id__.tar.gz experiment-output/0002/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0002-slave-__id__.tar.gz experiment-output/0002/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0002/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0002-slave-__id__.tar.gz experiment-output/0002/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0002/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0002-logs.log stubborn-scp.sh 10 experiment-output-0002-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0002-logs.log stubborn-scp.sh 10 experiment-output-0002-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0002/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0002-logs.log stubborn-scp.sh 10 experiment-output-0002-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0002/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0002


#========================================
# 0003
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0003/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0003-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0003.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0003-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0003.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0003/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0003-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0003.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0003/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0003/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0003/slave-__id__/peer.trc experiment-output/0003/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0003/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0003/slave-__id__/client experiment-output/0003/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0003/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0003/slave-__id__/client experiment-output/0003/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0003/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0003/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0003/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0003/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0003/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0003/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0003/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0003-slave-__id__.tar.gz experiment-output/0003/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0003-slave-__id__.tar.gz experiment-output/0003/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0003/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0003-slave-__id__.tar.gz experiment-output/0003/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0003/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0003-logs.log stubborn-scp.sh 10 experiment-output-0003-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0003-logs.log stubborn-scp.sh 10 experiment-output-0003-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0003/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0003-logs.log stubborn-scp.sh 10 experiment-output-0003-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0003/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0003


#========================================
# 0004
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0004/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0004-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0004.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0004-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0004.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0004/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0004-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0004.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0004/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0004/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0004/slave-__id__/peer.trc experiment-output/0004/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0004/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0004/slave-__id__/client experiment-output/0004/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0004/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0004/slave-__id__/client experiment-output/0004/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0004/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0004/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0004/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0004/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0004/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0004/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0004/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0004-slave-__id__.tar.gz experiment-output/0004/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0004-slave-__id__.tar.gz experiment-output/0004/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0004/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0004-slave-__id__.tar.gz experiment-output/0004/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0004/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0004-logs.log stubborn-scp.sh 10 experiment-output-0004-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0004-logs.log stubborn-scp.sh 10 experiment-output-0004-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0004/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0004-logs.log stubborn-scp.sh 10 experiment-output-0004-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0004/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0004


#========================================
# 0005
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0005/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0005-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0005.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0005-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0005.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0005/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0005-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0005.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0005/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0005/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0005/slave-__id__/peer.trc experiment-output/0005/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0005/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0005/slave-__id__/client experiment-output/0005/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0005/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0005/slave-__id__/client experiment-output/0005/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0005/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0005/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0005/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0005/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0005/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0005/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0005/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0005-slave-__id__.tar.gz experiment-output/0005/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0005-slave-__id__.tar.gz experiment-output/0005/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0005/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0005-slave-__id__.tar.gz experiment-output/0005/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0005/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0005-logs.log stubborn-scp.sh 10 experiment-output-0005-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0005-logs.log stubborn-scp.sh 10 experiment-output-0005-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0005/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0005-logs.log stubborn-scp.sh 10 experiment-output-0005-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0005/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0005


#========================================
# 0006
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0006/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0006-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0006.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0006/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0006-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0006.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0006/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0006-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0006.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0006/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0006/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0006/slave-__id__/peer.trc experiment-output/0006/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0006/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0006/slave-__id__/client experiment-output/0006/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0006/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0006/slave-__id__/client experiment-output/0006/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0006/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0006/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0006/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0006/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0006/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0006/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0006/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0006/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0006-slave-__id__.tar.gz experiment-output/0006/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0006/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0006-slave-__id__.tar.gz experiment-output/0006/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0006/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0006-slave-__id__.tar.gz experiment-output/0006/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0006/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0006-logs.log stubborn-scp.sh 10 experiment-output-0006-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0006/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0006-logs.log stubborn-scp.sh 10 experiment-output-0006-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0006/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0006-logs.log stubborn-scp.sh 10 experiment-output-0006-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0006/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0006


#========================================
# 0007
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0007/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0007-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0007.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0007/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0007-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0007.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0007/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0007-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0007.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0007/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0007/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0007/slave-__id__/peer.trc experiment-output/0007/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0007/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0007/slave-__id__/client experiment-output/0007/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0007/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0007/slave-__id__/client experiment-output/0007/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0007/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0007/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0007/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0007/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0007/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0007/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0007/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0007/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0007-slave-__id__.tar.gz experiment-output/0007/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0007/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0007-slave-__id__.tar.gz experiment-output/0007/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0007/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0007-slave-__id__.tar.gz experiment-output/0007/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0007/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0007-logs.log stubborn-scp.sh 10 experiment-output-0007-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0007/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0007-logs.log stubborn-scp.sh 10 experiment-output-0007-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0007/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0007-logs.log stubborn-scp.sh 10 experiment-output-0007-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0007/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0007


#========================================
# 0008
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0008/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0008-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0008.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0008/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0008-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0008.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0008/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0008-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0008.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0008/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0008/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0008/slave-__id__/peer.trc experiment-output/0008/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0008/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0008/slave-__id__/client experiment-output/0008/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0008/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0008/slave-__id__/client experiment-output/0008/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0008/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0008/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0008/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0008/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0008/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0008/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0008/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0008/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0008-slave-__id__.tar.gz experiment-output/0008/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0008/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0008-slave-__id__.tar.gz experiment-output/0008/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0008/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0008-slave-__id__.tar.gz experiment-output/0008/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0008/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0008-logs.log stubborn-scp.sh 10 experiment-output-0008-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0008/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0008-logs.log stubborn-scp.sh 10 experiment-output-0008-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0008/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0008-logs.log stubborn-scp.sh 10 experiment-output-0008-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0008/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0008


#========================================
# 0009
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0009/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0009-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0009.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0009/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0009-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0009.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0009/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0009-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0009.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0009/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0009/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0009/slave-__id__/peer.trc experiment-output/0009/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0009/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0009/slave-__id__/client experiment-output/0009/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0009/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0009/slave-__id__/client experiment-output/0009/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0009/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0009/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0009/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0009/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0009/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0009/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0009/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0009/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0009-slave-__id__.tar.gz experiment-output/0009/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0009/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0009-slave-__id__.tar.gz experiment-output/0009/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0009/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0009-slave-__id__.tar.gz experiment-output/0009/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0009/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0009-logs.log stubborn-scp.sh 10 experiment-output-0009-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0009/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0009-logs.log stubborn-scp.sh 10 experiment-output-0009-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0009/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0009-logs.log stubborn-scp.sh 10 experiment-output-0009-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0009/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0009


#========================================
# 0010
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0010/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0010-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0010.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0010/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0010-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0010.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0010/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0010-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0010.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0010/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0010/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0010/slave-__id__/peer.trc experiment-output/0010/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0010/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0010/slave-__id__/client experiment-output/0010/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0010/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0010/slave-__id__/client experiment-output/0010/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0010/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0010/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0010/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0010/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0010/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0010/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0010/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0010/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0010-slave-__id__.tar.gz experiment-output/0010/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0010/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0010-slave-__id__.tar.gz experiment-output/0010/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0010/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0010-slave-__id__.tar.gz experiment-output/0010/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0010/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0010-logs.log stubborn-scp.sh 10 experiment-output-0010-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0010/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0010-logs.log stubborn-scp.sh 10 experiment-output-0010-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0010/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0010-logs.log stubborn-scp.sh 10 experiment-output-0010-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0010/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0010


#========================================
# 0011
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0011/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0011-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0011.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0011/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0011-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0011.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0011/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0011-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0011.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0011/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0011/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0011/slave-__id__/peer.trc experiment-output/0011/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0011/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0011/slave-__id__/client experiment-output/0011/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0011/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0011/slave-__id__/client experiment-output/0011/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0011/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0011/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0011/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0011/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0011/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0011/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0011/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0011/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0011-slave-__id__.tar.gz experiment-output/0011/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0011/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0011-slave-__id__.tar.gz experiment-output/0011/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0011/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0011-slave-__id__.tar.gz experiment-output/0011/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0011/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0011-logs.log stubborn-scp.sh 10 experiment-output-0011-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0011/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0011-logs.log stubborn-scp.sh 10 experiment-output-0011-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0011/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0011-logs.log stubborn-scp.sh 10 experiment-output-0011-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0011/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0011


#========================================
# 0012
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0012/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0012-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0012.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0012/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0012-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0012.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0012/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0012-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0012.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0012/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0012/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0012/slave-__id__/peer.trc experiment-output/0012/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0012/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0012/slave-__id__/client experiment-output/0012/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0012/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0012/slave-__id__/client experiment-output/0012/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0012/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0012/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0012/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0012/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0012/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0012/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0012/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0012/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0012-slave-__id__.tar.gz experiment-output/0012/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0012/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0012-slave-__id__.tar.gz experiment-output/0012/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0012/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0012-slave-__id__.tar.gz experiment-output/0012/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0012/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0012-logs.log stubborn-scp.sh 10 experiment-output-0012-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0012/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0012-logs.log stubborn-scp.sh 10 experiment-output-0012-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0012/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0012-logs.log stubborn-scp.sh 10 experiment-output-0012-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0012/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0012


#========================================
# 0013
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0013/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0013-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0013.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0013/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0013-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0013.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0013/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0013-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0013.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0013/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0013/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0013/slave-__id__/peer.trc experiment-output/0013/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0013/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0013/slave-__id__/client experiment-output/0013/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0013/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0013/slave-__id__/client experiment-output/0013/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0013/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0013/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0013/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0013/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0013/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0013/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0013/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0013/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0013-slave-__id__.tar.gz experiment-output/0013/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0013/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0013-slave-__id__.tar.gz experiment-output/0013/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0013/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0013-slave-__id__.tar.gz experiment-output/0013/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0013/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0013-logs.log stubborn-scp.sh 10 experiment-output-0013-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0013/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0013-logs.log stubborn-scp.sh 10 experiment-output-0013-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0013/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0013-logs.log stubborn-scp.sh 10 experiment-output-0013-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0013/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0013


#========================================
# 0014
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0014/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0014-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0014.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0014/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0014-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0014.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0014/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0014-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0014.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0014/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0014/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0014/slave-__id__/peer.trc experiment-output/0014/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0014/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0014/slave-__id__/client experiment-output/0014/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0014/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0014/slave-__id__/client experiment-output/0014/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0014/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0014/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0014/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0014/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0014/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0014/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0014/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0014/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0014-slave-__id__.tar.gz experiment-output/0014/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0014/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0014-slave-__id__.tar.gz experiment-output/0014/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0014/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0014-slave-__id__.tar.gz experiment-output/0014/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0014/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0014-logs.log stubborn-scp.sh 10 experiment-output-0014-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0014/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0014-logs.log stubborn-scp.sh 10 experiment-output-0014-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0014/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0014-logs.log stubborn-scp.sh 10 experiment-output-0014-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0014/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0014


#========================================
# 0015
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0015/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0015-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0015.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0015/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0015-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0015.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0015/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0015-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0015.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0015/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0015/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0015/slave-__id__/peer.trc experiment-output/0015/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0015/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0015/slave-__id__/client experiment-output/0015/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0015/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0015/slave-__id__/client experiment-output/0015/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0015/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0015/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0015/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0015/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0015/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0015/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0015/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0015/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0015-slave-__id__.tar.gz experiment-output/0015/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0015/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0015-slave-__id__.tar.gz experiment-output/0015/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0015/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0015-slave-__id__.tar.gz experiment-output/0015/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0015/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0015-logs.log stubborn-scp.sh 10 experiment-output-0015-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0015/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0015-logs.log stubborn-scp.sh 10 experiment-output-0015-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0015/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0015-logs.log stubborn-scp.sh 10 experiment-output-0015-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0015/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0015


#========================================
# 0016
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0016/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0016-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0016.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0016/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0016-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0016.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0016/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0016-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0016.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0016/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0016/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0016/slave-__id__/peer.trc experiment-output/0016/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0016/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0016/slave-__id__/client experiment-output/0016/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0016/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0016/slave-__id__/client experiment-output/0016/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0016/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0016/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0016/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0016/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0016/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0016/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0016/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0016/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0016-slave-__id__.tar.gz experiment-output/0016/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0016/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0016-slave-__id__.tar.gz experiment-output/0016/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0016/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0016-slave-__id__.tar.gz experiment-output/0016/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0016/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0016-logs.log stubborn-scp.sh 10 experiment-output-0016-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0016/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0016-logs.log stubborn-scp.sh 10 experiment-output-0016-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0016/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0016-logs.log stubborn-scp.sh 10 experiment-output-0016-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0016/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0016


#========================================
# 0017
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0017/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0017-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0017.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0017/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0017-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0017.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0017/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0017-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0017.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0017/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0017/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0017/slave-__id__/peer.trc experiment-output/0017/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0017/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0017/slave-__id__/client experiment-output/0017/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0017/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0017/slave-__id__/client experiment-output/0017/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0017/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0017/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0017/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0017/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0017/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0017/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0017/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0017/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0017-slave-__id__.tar.gz experiment-output/0017/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0017/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0017-slave-__id__.tar.gz experiment-output/0017/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0017/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0017-slave-__id__.tar.gz experiment-output/0017/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0017/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0017-logs.log stubborn-scp.sh 10 experiment-output-0017-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0017/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0017-logs.log stubborn-scp.sh 10 experiment-output-0017-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0017/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0017-logs.log stubborn-scp.sh 10 experiment-output-0017-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0017/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0017


#========================================
# 0018
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0018/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0018-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0018.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0018/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0018-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0018.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0018/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0018-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0018.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0018/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0018/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0018/slave-__id__/peer.trc experiment-output/0018/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0018/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0018/slave-__id__/client experiment-output/0018/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0018/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0018/slave-__id__/client experiment-output/0018/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0018/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0018/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0018/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0018/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0018/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0018/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0018/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0018/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0018-slave-__id__.tar.gz experiment-output/0018/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0018/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0018-slave-__id__.tar.gz experiment-output/0018/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0018/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0018-slave-__id__.tar.gz experiment-output/0018/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0018/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0018-logs.log stubborn-scp.sh 10 experiment-output-0018-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0018/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0018-logs.log stubborn-scp.sh 10 experiment-output-0018-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0018/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0018-logs.log stubborn-scp.sh 10 experiment-output-0018-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0018/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0018


#========================================
# 0019
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0019/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0019-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0019.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0019/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0019-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0019.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0019/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0019-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0019.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0019/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0019/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0019/slave-__id__/peer.trc experiment-output/0019/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0019/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0019/slave-__id__/client experiment-output/0019/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0019/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0019/slave-__id__/client experiment-output/0019/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0019/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0019/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0019/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0019/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0019/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0019/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0019/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0019/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0019-slave-__id__.tar.gz experiment-output/0019/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0019/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0019-slave-__id__.tar.gz experiment-output/0019/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0019/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0019-slave-__id__.tar.gz experiment-output/0019/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0019/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0019-logs.log stubborn-scp.sh 10 experiment-output-0019-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0019/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0019-logs.log stubborn-scp.sh 10 experiment-output-0019-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0019/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0019-logs.log stubborn-scp.sh 10 experiment-output-0019-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0019/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0019


#========================================
# 0020
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0020/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0020-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0020.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0020/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0020-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0020.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0020/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0020-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0020.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0020/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0020/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0020/slave-__id__/peer.trc experiment-output/0020/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0020/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0020/slave-__id__/client experiment-output/0020/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0020/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0020/slave-__id__/client experiment-output/0020/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0020/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0020/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0020/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0020/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0020/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0020/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0020/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0020/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0020-slave-__id__.tar.gz experiment-output/0020/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0020/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0020-slave-__id__.tar.gz experiment-output/0020/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0020/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0020-slave-__id__.tar.gz experiment-output/0020/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0020/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0020-logs.log stubborn-scp.sh 10 experiment-output-0020-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0020/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0020-logs.log stubborn-scp.sh 10 experiment-output-0020-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0020/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0020-logs.log stubborn-scp.sh 10 experiment-output-0020-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0020/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0020


#========================================
# 0021
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0021/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0021-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0021.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0021/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0021-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0021.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0021/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0021-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0021.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0021/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0021/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0021/slave-__id__/peer.trc experiment-output/0021/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0021/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0021/slave-__id__/client experiment-output/0021/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0021/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0021/slave-__id__/client experiment-output/0021/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0021/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0021/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0021/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0021/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0021/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0021/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0021/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0021/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0021-slave-__id__.tar.gz experiment-output/0021/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0021/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0021-slave-__id__.tar.gz experiment-output/0021/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0021/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0021-slave-__id__.tar.gz experiment-output/0021/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0021/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0021-logs.log stubborn-scp.sh 10 experiment-output-0021-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0021/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0021-logs.log stubborn-scp.sh 10 experiment-output-0021-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0021/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0021-logs.log stubborn-scp.sh 10 experiment-output-0021-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0021/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0021


#========================================
# 0022
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0022/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0022-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0022.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0022/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0022-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0022.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0022/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0022-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0022.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0022/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0022/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0022/slave-__id__/peer.trc experiment-output/0022/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0022/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0022/slave-__id__/client experiment-output/0022/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0022/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0022/slave-__id__/client experiment-output/0022/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0022/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0022/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0022/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0022/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0022/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0022/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0022/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0022/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0022-slave-__id__.tar.gz experiment-output/0022/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0022/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0022-slave-__id__.tar.gz experiment-output/0022/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0022/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0022-slave-__id__.tar.gz experiment-output/0022/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0022/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0022-logs.log stubborn-scp.sh 10 experiment-output-0022-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0022/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0022-logs.log stubborn-scp.sh 10 experiment-output-0022-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0022/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0022-logs.log stubborn-scp.sh 10 experiment-output-0022-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0022/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0022


#========================================
# 0023
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0023/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0023-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0023.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0023/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0023-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0023.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0023/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0023-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0023.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0023/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0023/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0023/slave-__id__/peer.trc experiment-output/0023/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0023/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0023/slave-__id__/client experiment-output/0023/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0023/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0023/slave-__id__/client experiment-output/0023/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0023/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0023/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0023/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0023/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0023/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0023/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0023/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0023/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0023-slave-__id__.tar.gz experiment-output/0023/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0023/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0023-slave-__id__.tar.gz experiment-output/0023/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0023/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0023-slave-__id__.tar.gz experiment-output/0023/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0023/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0023-logs.log stubborn-scp.sh 10 experiment-output-0023-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0023/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0023-logs.log stubborn-scp.sh 10 experiment-output-0023-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0023/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0023-logs.log stubborn-scp.sh 10 experiment-output-0023-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0023/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0023


#========================================
# 0024
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0024/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0024-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0024.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0024/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0024-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0024.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0024/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0024-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0024.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0024/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0024/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0024/slave-__id__/peer.trc experiment-output/0024/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0024/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0024/slave-__id__/client experiment-output/0024/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0024/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0024/slave-__id__/client experiment-output/0024/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0024/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0024/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0024/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0024/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0024/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0024/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0024/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0024/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0024-slave-__id__.tar.gz experiment-output/0024/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0024/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0024-slave-__id__.tar.gz experiment-output/0024/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0024/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0024-slave-__id__.tar.gz experiment-output/0024/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0024/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0024-logs.log stubborn-scp.sh 10 experiment-output-0024-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0024/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0024-logs.log stubborn-scp.sh 10 experiment-output-0024-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0024/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0024-logs.log stubborn-scp.sh 10 experiment-output-0024-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0024/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0024


#========================================
# 0025
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0025/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0025-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0025.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0025/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0025-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0025.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0025/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0025-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0025.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0025/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0025/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0025/slave-__id__/peer.trc experiment-output/0025/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0025/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0025/slave-__id__/client experiment-output/0025/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0025/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0025/slave-__id__/client experiment-output/0025/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0025/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0025/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0025/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0025/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0025/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0025/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0025/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0025/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0025-slave-__id__.tar.gz experiment-output/0025/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0025/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0025-slave-__id__.tar.gz experiment-output/0025/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0025/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0025-slave-__id__.tar.gz experiment-output/0025/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0025/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0025-logs.log stubborn-scp.sh 10 experiment-output-0025-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0025/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0025-logs.log stubborn-scp.sh 10 experiment-output-0025-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0025/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0025-logs.log stubborn-scp.sh 10 experiment-output-0025-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0025/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0025


#========================================
# 0026
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0026/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0026-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0026.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0026/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0026-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0026.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0026/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0026-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0026.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0026/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0026/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0026/slave-__id__/peer.trc experiment-output/0026/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0026/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0026/slave-__id__/client experiment-output/0026/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0026/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0026/slave-__id__/client experiment-output/0026/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0026/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0026/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0026/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0026/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0026/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0026/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0026/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0026/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0026-slave-__id__.tar.gz experiment-output/0026/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0026/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0026-slave-__id__.tar.gz experiment-output/0026/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0026/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0026-slave-__id__.tar.gz experiment-output/0026/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0026/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0026-logs.log stubborn-scp.sh 10 experiment-output-0026-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0026/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0026-logs.log stubborn-scp.sh 10 experiment-output-0026-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0026/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0026-logs.log stubborn-scp.sh 10 experiment-output-0026-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0026/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0026


#========================================
# 0027
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0027/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0027-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0027.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0027/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0027-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0027.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0027/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0027-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0027.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0027/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0027/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0027/slave-__id__/peer.trc experiment-output/0027/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0027/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0027/slave-__id__/client experiment-output/0027/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0027/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0027/slave-__id__/client experiment-output/0027/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0027/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0027/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0027/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0027/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0027/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0027/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0027/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0027/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0027-slave-__id__.tar.gz experiment-output/0027/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0027/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0027-slave-__id__.tar.gz experiment-output/0027/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0027/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0027-slave-__id__.tar.gz experiment-output/0027/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0027/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0027-logs.log stubborn-scp.sh 10 experiment-output-0027-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0027/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0027-logs.log stubborn-scp.sh 10 experiment-output-0027-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0027/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0027-logs.log stubborn-scp.sh 10 experiment-output-0027-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0027/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0027


#========================================
# 0028
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0028/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0028-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0028.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0028/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0028-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0028.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0028/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0028-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0028.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0028/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0028/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0028/slave-__id__/peer.trc experiment-output/0028/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0028/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0028/slave-__id__/client experiment-output/0028/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0028/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0028/slave-__id__/client experiment-output/0028/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0028/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0028/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0028/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0028/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0028/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0028/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0028/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0028/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0028-slave-__id__.tar.gz experiment-output/0028/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0028/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0028-slave-__id__.tar.gz experiment-output/0028/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0028/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0028-slave-__id__.tar.gz experiment-output/0028/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0028/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0028-logs.log stubborn-scp.sh 10 experiment-output-0028-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0028/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0028-logs.log stubborn-scp.sh 10 experiment-output-0028-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0028/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0028-logs.log stubborn-scp.sh 10 experiment-output-0028-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0028/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0028


#========================================
# 0029
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0029/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0029-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0029.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0029/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0029-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0029.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0029/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0029-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0029.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0029/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0029/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0029/slave-__id__/peer.trc experiment-output/0029/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0029/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0029/slave-__id__/client experiment-output/0029/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0029/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0029/slave-__id__/client experiment-output/0029/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0029/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0029/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0029/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0029/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0029/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0029/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0029/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0029/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0029-slave-__id__.tar.gz experiment-output/0029/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0029/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0029-slave-__id__.tar.gz experiment-output/0029/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0029/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0029-slave-__id__.tar.gz experiment-output/0029/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0029/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0029-logs.log stubborn-scp.sh 10 experiment-output-0029-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0029/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0029-logs.log stubborn-scp.sh 10 experiment-output-0029-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0029/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0029-logs.log stubborn-scp.sh 10 experiment-output-0029-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0029/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0029


#========================================
# 0030
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0030/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0030-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0030.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0030/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0030-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0030.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0030/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0030-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0030.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0030/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0030/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0030/slave-__id__/peer.trc experiment-output/0030/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0030/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0030/slave-__id__/client experiment-output/0030/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0030/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0030/slave-__id__/client experiment-output/0030/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0030/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0030/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0030/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0030/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0030/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0030/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0030/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0030/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0030-slave-__id__.tar.gz experiment-output/0030/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0030/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0030-slave-__id__.tar.gz experiment-output/0030/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0030/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0030-slave-__id__.tar.gz experiment-output/0030/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0030/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0030-logs.log stubborn-scp.sh 10 experiment-output-0030-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0030/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0030-logs.log stubborn-scp.sh 10 experiment-output-0030-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0030/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0030-logs.log stubborn-scp.sh 10 experiment-output-0030-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0030/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0030


#========================================
# 0031
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0031/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0031-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0031.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0031/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0031-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0031.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0031/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0031-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0031.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0031/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0031/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0031/slave-__id__/peer.trc experiment-output/0031/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0031/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0031/slave-__id__/client experiment-output/0031/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0031/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0031/slave-__id__/client experiment-output/0031/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0031/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0031/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0031/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0031/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0031/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0031/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0031/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0031/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0031-slave-__id__.tar.gz experiment-output/0031/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0031/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0031-slave-__id__.tar.gz experiment-output/0031/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0031/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0031-slave-__id__.tar.gz experiment-output/0031/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0031/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0031-logs.log stubborn-scp.sh 10 experiment-output-0031-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0031/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0031-logs.log stubborn-scp.sh 10 experiment-output-0031-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0031/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0031-logs.log stubborn-scp.sh 10 experiment-output-0031-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0031/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0031


#========================================
# 0032
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0032/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0032-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0032.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0032/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0032-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0032.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0032/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0032-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0032.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0032/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0032/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0032/slave-__id__/peer.trc experiment-output/0032/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0032/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0032/slave-__id__/client experiment-output/0032/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0032/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0032/slave-__id__/client experiment-output/0032/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0032/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0032/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0032/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0032/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0032/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0032/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0032/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0032/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0032-slave-__id__.tar.gz experiment-output/0032/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0032/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0032-slave-__id__.tar.gz experiment-output/0032/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0032/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0032-slave-__id__.tar.gz experiment-output/0032/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0032/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0032-logs.log stubborn-scp.sh 10 experiment-output-0032-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0032/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0032-logs.log stubborn-scp.sh 10 experiment-output-0032-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0032/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0032-logs.log stubborn-scp.sh 10 experiment-output-0032-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0032/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0032


#========================================
# 0033
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0033/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0033-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0033.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0033/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0033-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0033.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0033/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0033-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0033.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0033/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0033/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0033/slave-__id__/peer.trc experiment-output/0033/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0033/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0033/slave-__id__/client experiment-output/0033/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0033/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0033/slave-__id__/client experiment-output/0033/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0033/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0033/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0033/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0033/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0033/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0033/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0033/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0033/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0033-slave-__id__.tar.gz experiment-output/0033/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0033/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0033-slave-__id__.tar.gz experiment-output/0033/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0033/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0033-slave-__id__.tar.gz experiment-output/0033/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0033/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0033-logs.log stubborn-scp.sh 10 experiment-output-0033-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0033/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0033-logs.log stubborn-scp.sh 10 experiment-output-0033-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0033/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0033-logs.log stubborn-scp.sh 10 experiment-output-0033-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0033/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0033


#========================================
# 0034
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0034/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0034-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0034.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0034/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0034-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0034.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0034/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0034-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0034.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0034/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0034/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0034/slave-__id__/peer.trc experiment-output/0034/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0034/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0034/slave-__id__/client experiment-output/0034/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0034/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0034/slave-__id__/client experiment-output/0034/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0034/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0034/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0034/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0034/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0034/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0034/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0034/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0034/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0034-slave-__id__.tar.gz experiment-output/0034/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0034/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0034-slave-__id__.tar.gz experiment-output/0034/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0034/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0034-slave-__id__.tar.gz experiment-output/0034/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0034/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0034-logs.log stubborn-scp.sh 10 experiment-output-0034-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0034/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0034-logs.log stubborn-scp.sh 10 experiment-output-0034-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0034/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0034-logs.log stubborn-scp.sh 10 experiment-output-0034-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0034/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0034


#========================================
# 0035
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0035/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0035-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0035.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0035/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0035-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0035.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0035/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0035-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0035.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0035/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0035/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0035/slave-__id__/peer.trc experiment-output/0035/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0035/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0035/slave-__id__/client experiment-output/0035/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0035/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0035/slave-__id__/client experiment-output/0035/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0035/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0035/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0035/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0035/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0035/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0035/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0035/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0035/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0035-slave-__id__.tar.gz experiment-output/0035/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0035/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0035-slave-__id__.tar.gz experiment-output/0035/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0035/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0035-slave-__id__.tar.gz experiment-output/0035/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0035/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0035-logs.log stubborn-scp.sh 10 experiment-output-0035-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0035/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0035-logs.log stubborn-scp.sh 10 experiment-output-0035-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0035/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0035-logs.log stubborn-scp.sh 10 experiment-output-0035-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0035/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0035


#========================================
# 0036
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0036/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0036-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0036.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0036/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0036-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0036.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0036/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0036-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0036.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0036/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0036/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0036/slave-__id__/peer.trc experiment-output/0036/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0036/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0036/slave-__id__/client experiment-output/0036/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0036/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0036/slave-__id__/client experiment-output/0036/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0036/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0036/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0036/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0036/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0036/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0036/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0036/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0036/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0036-slave-__id__.tar.gz experiment-output/0036/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0036/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0036-slave-__id__.tar.gz experiment-output/0036/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0036/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0036-slave-__id__.tar.gz experiment-output/0036/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0036/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0036-logs.log stubborn-scp.sh 10 experiment-output-0036-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0036/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0036-logs.log stubborn-scp.sh 10 experiment-output-0036-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0036/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0036-logs.log stubborn-scp.sh 10 experiment-output-0036-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0036/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0036


#========================================
# 0037
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0037/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0037-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0037.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0037/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0037-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0037.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0037/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0037-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0037.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0037/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0037/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0037/slave-__id__/peer.trc experiment-output/0037/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0037/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0037/slave-__id__/client experiment-output/0037/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0037/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0037/slave-__id__/client experiment-output/0037/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0037/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0037/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0037/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0037/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0037/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0037/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0037/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0037/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0037-slave-__id__.tar.gz experiment-output/0037/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0037/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0037-slave-__id__.tar.gz experiment-output/0037/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0037/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0037-slave-__id__.tar.gz experiment-output/0037/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0037/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0037-logs.log stubborn-scp.sh 10 experiment-output-0037-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0037/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0037-logs.log stubborn-scp.sh 10 experiment-output-0037-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0037/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0037-logs.log stubborn-scp.sh 10 experiment-output-0037-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0037/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0037


#========================================
# 0038
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0038/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0038-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0038.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0038/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0038-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0038.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0038/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0038-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0038.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0038/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0038/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0038/slave-__id__/peer.trc experiment-output/0038/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0038/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0038/slave-__id__/client experiment-output/0038/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0038/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0038/slave-__id__/client experiment-output/0038/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0038/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0038/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0038/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0038/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0038/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0038/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0038/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0038/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0038-slave-__id__.tar.gz experiment-output/0038/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0038/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0038-slave-__id__.tar.gz experiment-output/0038/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0038/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0038-slave-__id__.tar.gz experiment-output/0038/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0038/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0038-logs.log stubborn-scp.sh 10 experiment-output-0038-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0038/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0038-logs.log stubborn-scp.sh 10 experiment-output-0038-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0038/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0038-logs.log stubborn-scp.sh 10 experiment-output-0038-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0038/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0038


#========================================
# 0039
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0039/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0039-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0039.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0039/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0039-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0039.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0039/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0039-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0039.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0039/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0039/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0039/slave-__id__/peer.trc experiment-output/0039/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0039/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0039/slave-__id__/client experiment-output/0039/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0039/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0039/slave-__id__/client experiment-output/0039/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0039/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0039/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0039/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0039/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0039/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0039/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0039/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0039/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0039-slave-__id__.tar.gz experiment-output/0039/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0039/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0039-slave-__id__.tar.gz experiment-output/0039/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0039/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0039-slave-__id__.tar.gz experiment-output/0039/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0039/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0039-logs.log stubborn-scp.sh 10 experiment-output-0039-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0039/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0039-logs.log stubborn-scp.sh 10 experiment-output-0039-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0039/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0039-logs.log stubborn-scp.sh 10 experiment-output-0039-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0039/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0039


#========================================
# 0040
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0040/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0040-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0040.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0040/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0040-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0040.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0040/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0040-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0040.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0040/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0040/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0040/slave-__id__/peer.trc experiment-output/0040/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0040/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0040/slave-__id__/client experiment-output/0040/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0040/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0040/slave-__id__/client experiment-output/0040/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0040/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0040/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0040/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0040/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0040/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0040/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0040/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0040/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0040-slave-__id__.tar.gz experiment-output/0040/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0040/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0040-slave-__id__.tar.gz experiment-output/0040/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0040/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0040-slave-__id__.tar.gz experiment-output/0040/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0040/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0040-logs.log stubborn-scp.sh 10 experiment-output-0040-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0040/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0040-logs.log stubborn-scp.sh 10 experiment-output-0040-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0040/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0040-logs.log stubborn-scp.sh 10 experiment-output-0040-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0040/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0040


#========================================
# 0041
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0041/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0041-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0041.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0041/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0041-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0041.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0041/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0041-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0041.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0041/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0041/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0041/slave-__id__/peer.trc experiment-output/0041/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0041/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0041/slave-__id__/client experiment-output/0041/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0041/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0041/slave-__id__/client experiment-output/0041/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0041/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0041/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0041/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0041/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0041/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0041/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0041/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0041/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0041-slave-__id__.tar.gz experiment-output/0041/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0041/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0041-slave-__id__.tar.gz experiment-output/0041/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0041/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0041-slave-__id__.tar.gz experiment-output/0041/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0041/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0041-logs.log stubborn-scp.sh 10 experiment-output-0041-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0041/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0041-logs.log stubborn-scp.sh 10 experiment-output-0041-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0041/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0041-logs.log stubborn-scp.sh 10 experiment-output-0041-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0041/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0041


#========================================
# 0042
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0042/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0042-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0042.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0042/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0042-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0042.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0042/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0042-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0042.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0042/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0042/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0042/slave-__id__/peer.trc experiment-output/0042/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0042/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0042/slave-__id__/client experiment-output/0042/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0042/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0042/slave-__id__/client experiment-output/0042/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0042/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0042/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0042/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0042/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0042/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0042/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0042/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0042/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0042-slave-__id__.tar.gz experiment-output/0042/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0042/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0042-slave-__id__.tar.gz experiment-output/0042/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0042/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0042-slave-__id__.tar.gz experiment-output/0042/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0042/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0042-logs.log stubborn-scp.sh 10 experiment-output-0042-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0042/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0042-logs.log stubborn-scp.sh 10 experiment-output-0042-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0042/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0042-logs.log stubborn-scp.sh 10 experiment-output-0042-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0042/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0042


#========================================
# 0043
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0043/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0043-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0043.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0043/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0043-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0043.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0043/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0043-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0043.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0043/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0043/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0043/slave-__id__/peer.trc experiment-output/0043/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0043/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0043/slave-__id__/client experiment-output/0043/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0043/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0043/slave-__id__/client experiment-output/0043/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0043/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0043/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0043/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0043/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0043/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0043/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0043/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0043/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0043-slave-__id__.tar.gz experiment-output/0043/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0043/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0043-slave-__id__.tar.gz experiment-output/0043/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0043/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0043-slave-__id__.tar.gz experiment-output/0043/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0043/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0043-logs.log stubborn-scp.sh 10 experiment-output-0043-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0043/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0043-logs.log stubborn-scp.sh 10 experiment-output-0043-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0043/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0043-logs.log stubborn-scp.sh 10 experiment-output-0043-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0043/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0043


#========================================
# 0044
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0044/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0044-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0044.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0044/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0044-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0044.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0044/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0044-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0044.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0044/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0044/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0044/slave-__id__/peer.trc experiment-output/0044/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0044/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0044/slave-__id__/client experiment-output/0044/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0044/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0044/slave-__id__/client experiment-output/0044/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0044/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0044/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0044/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0044/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0044/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0044/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0044/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0044/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0044-slave-__id__.tar.gz experiment-output/0044/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0044/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0044-slave-__id__.tar.gz experiment-output/0044/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0044/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0044-slave-__id__.tar.gz experiment-output/0044/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0044/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0044-logs.log stubborn-scp.sh 10 experiment-output-0044-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0044/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0044-logs.log stubborn-scp.sh 10 experiment-output-0044-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0044/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0044-logs.log stubborn-scp.sh 10 experiment-output-0044-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0044/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0044


#========================================
# 0045
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0045/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0045-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0045.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0045/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0045-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0045.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0045/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0045-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0045.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0045/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0045/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0045/slave-__id__/peer.trc experiment-output/0045/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0045/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0045/slave-__id__/client experiment-output/0045/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0045/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0045/slave-__id__/client experiment-output/0045/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0045/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0045/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0045/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0045/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0045/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0045/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0045/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0045/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0045-slave-__id__.tar.gz experiment-output/0045/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0045/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0045-slave-__id__.tar.gz experiment-output/0045/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0045/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0045-slave-__id__.tar.gz experiment-output/0045/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0045/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0045-logs.log stubborn-scp.sh 10 experiment-output-0045-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0045/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0045-logs.log stubborn-scp.sh 10 experiment-output-0045-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0045/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0045-logs.log stubborn-scp.sh 10 experiment-output-0045-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0045/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0045


#========================================
# 0046
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0046/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0046-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0046.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0046/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0046-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0046.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0046/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0046-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0046.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0046/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0046/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0046/slave-__id__/peer.trc experiment-output/0046/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0046/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0046/slave-__id__/client experiment-output/0046/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0046/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0046/slave-__id__/client experiment-output/0046/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0046/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0046/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0046/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0046/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0046/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0046/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0046/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0046/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0046-slave-__id__.tar.gz experiment-output/0046/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0046/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0046-slave-__id__.tar.gz experiment-output/0046/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0046/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0046-slave-__id__.tar.gz experiment-output/0046/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0046/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0046-logs.log stubborn-scp.sh 10 experiment-output-0046-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0046/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0046-logs.log stubborn-scp.sh 10 experiment-output-0046-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0046/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0046-logs.log stubborn-scp.sh 10 experiment-output-0046-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0046/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0046


#========================================
# 0047
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0047/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0047-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0047.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0047/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0047-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0047.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0047/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0047-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0047.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0047/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0047/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0047/slave-__id__/peer.trc experiment-output/0047/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0047/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0047/slave-__id__/client experiment-output/0047/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0047/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0047/slave-__id__/client experiment-output/0047/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0047/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0047/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0047/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0047/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0047/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0047/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0047/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0047/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0047-slave-__id__.tar.gz experiment-output/0047/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0047/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0047-slave-__id__.tar.gz experiment-output/0047/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0047/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0047-slave-__id__.tar.gz experiment-output/0047/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0047/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0047-logs.log stubborn-scp.sh 10 experiment-output-0047-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0047/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0047-logs.log stubborn-scp.sh 10 experiment-output-0047-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0047/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0047-logs.log stubborn-scp.sh 10 experiment-output-0047-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0047/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0047


#========================================
# 0048
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0048/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0048-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0048.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0048/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0048-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0048.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0048/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0048-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0048.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0048/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0048/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0048/slave-__id__/peer.trc experiment-output/0048/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0048/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0048/slave-__id__/client experiment-output/0048/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0048/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0048/slave-__id__/client experiment-output/0048/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0048/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0048/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0048/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0048/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0048/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0048/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0048/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0048/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0048-slave-__id__.tar.gz experiment-output/0048/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0048/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0048-slave-__id__.tar.gz experiment-output/0048/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0048/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0048-slave-__id__.tar.gz experiment-output/0048/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0048/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0048-logs.log stubborn-scp.sh 10 experiment-output-0048-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0048/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0048-logs.log stubborn-scp.sh 10 experiment-output-0048-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0048/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0048-logs.log stubborn-scp.sh 10 experiment-output-0048-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0048/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0048


#========================================
# 0049
#========================================


# Wait for slaves.
wait for slaves peers 16
wait for slaves 16clients 16
wait for slaves 16extraclients 16

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0049/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0049-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0049.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0049/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 16clients scp-output-0049-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0049.yml config/config.yml
exec-wait 16clients 60000 exec-start 16clients experiment-output/0049/slave-__id__/FAILED echo Could not fetch config; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0049-config.log stubborn-scp.sh 10 $own_public_ip:experiment-config/config-0049.yml config/config.yml
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0049/slave-__id__/FAILED echo Could not fetch config; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Start peers.
discover-reset 16
exec-start peers experiment-output/0049/slave-__id__/peer.log orderingpeer config/config.yml $own_public_ip:$master_port __public_ip__ __private_ip__ experiment-output/0049/slave-__id__/peer.trc experiment-output/0049/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 16clients experiment-output/0049/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0049/slave-__id__/client experiment-output/0049/slave-__id__/prof-client
exec-start 16extraclients experiment-output/0049/slave-__id__/clients.log orderingclient config/config.yml $own_public_ip:$master_port experiment-output/0049/slave-__id__/client experiment-output/0049/slave-__id__/prof-client
exec-wait 16clients 480000 exec-start 16clients experiment-output/0049/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16clients 2000
sync 16clients
exec-wait 16extraclients 240000 exec-start 16extraclients experiment-output/0049/slave-__id__/FAILED echo Client failed or timed out; exec-wait 16extraclients 2000
sync 16extraclients

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0049/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0049/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 16clients /dev/null cp config/config.yml experiment-output/0049/slave-__id__
exec-wait 16clients 2000 exec-start 16clients experiment-output/0049/slave-__id__/FAILED echo Could not log config file; exec-wait 16clients 2000
exec-start 16extraclients /dev/null cp config/config.yml experiment-output/0049/slave-__id__
exec-wait 16extraclients 2000 exec-start 16extraclients experiment-output/0049/slave-__id__/FAILED echo Could not log config file; exec-wait 16extraclients 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0049-slave-__id__.tar.gz experiment-output/0049/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0049/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 16clients /dev/null tar czf experiment-output-0049-slave-__id__.tar.gz experiment-output/0049/slave-__id__
exec-wait 16clients 30000 exec-start 16clients experiment-output/0049/slave-__id__/FAILED echo Could not compress logs; exec-wait 16clients 2000
exec-start 16extraclients /dev/null tar czf experiment-output-0049-slave-__id__.tar.gz experiment-output/0049/slave-__id__
exec-wait 16extraclients 30000 exec-start 16extraclients experiment-output/0049/slave-__id__/FAILED echo Could not compress logs; exec-wait 16extraclients 2000
exec-start peers scp-output-0049-logs.log stubborn-scp.sh 10 experiment-output-0049-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0049/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 16clients scp-output-0049-logs.log stubborn-scp.sh 10 experiment-output-0049-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16clients 60000 exec-start 16clients experiment-output/0049/slave-__id__/FAILED echo Could not submit logs; exec-wait 16clients 2000
exec-start 16extraclients scp-output-0049-logs.log stubborn-scp.sh 10 experiment-output-0049-slave-__id__.tar.gz $own_public_ip:current-deployment-data/raw-results/
exec-wait 16extraclients 60000 exec-start 16extraclients experiment-output/0049/slave-__id__/FAILED echo Could not submit logs; exec-wait 16extraclients 2000
sync peers
sync 16clients
sync 16extraclients

# Update master status.
write-file $status_file 0049


#========================================
# Wrap up                                
#========================================

# Wait for all slaves, even if they were not involved in experiments.
# Wait for slaves.
wait for slaves 16clients 16
wait for slaves 16extraclients 16
wait for slaves peers 16

# Stop all slaves.
stop __all__
wait for 3s
