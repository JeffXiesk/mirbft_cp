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
