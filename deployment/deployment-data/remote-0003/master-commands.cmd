write-file /root/master-ready READY

#========================================
# 0000
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0000/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0000-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0000.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0000-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0000.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0000/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0000/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0000/slave-__id__/peer.trc experiment-output/0000/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0000/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0000/slave-__id__/client experiment-output/0000/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0000/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0000/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0000/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0000/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0000-slave-__id__.tar.gz experiment-output/0000/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0000-slave-__id__.tar.gz experiment-output/0000/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0000/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0000-logs.log stubborn-scp.sh 10 experiment-output-0000-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0000/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0000-logs.log stubborn-scp.sh 10 experiment-output-0000-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0000/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0000


#========================================
# 0001
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0001/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0001-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0001.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0001-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0001.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0001/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0001/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0001/slave-__id__/peer.trc experiment-output/0001/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0001/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0001/slave-__id__/client experiment-output/0001/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0001/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0001/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0001/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0001/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0001-slave-__id__.tar.gz experiment-output/0001/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0001-slave-__id__.tar.gz experiment-output/0001/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0001/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0001-logs.log stubborn-scp.sh 10 experiment-output-0001-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0001/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0001-logs.log stubborn-scp.sh 10 experiment-output-0001-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0001/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0001


#========================================
# 0002
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0002/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0002-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0002.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0002-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0002.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0002/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0002/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0002/slave-__id__/peer.trc experiment-output/0002/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0002/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0002/slave-__id__/client experiment-output/0002/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0002/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0002/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0002/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0002/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0002-slave-__id__.tar.gz experiment-output/0002/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0002-slave-__id__.tar.gz experiment-output/0002/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0002/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0002-logs.log stubborn-scp.sh 10 experiment-output-0002-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0002/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0002-logs.log stubborn-scp.sh 10 experiment-output-0002-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0002/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0002


#========================================
# 0003
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0003/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0003-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0003.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0003-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0003.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0003/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0003/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0003/slave-__id__/peer.trc experiment-output/0003/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0003/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0003/slave-__id__/client experiment-output/0003/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0003/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0003/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0003/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0003/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0003-slave-__id__.tar.gz experiment-output/0003/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0003-slave-__id__.tar.gz experiment-output/0003/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0003/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0003-logs.log stubborn-scp.sh 10 experiment-output-0003-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0003/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0003-logs.log stubborn-scp.sh 10 experiment-output-0003-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0003/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0003


#========================================
# 0004
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0004/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0004-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0004.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0004-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0004.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0004/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0004/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0004/slave-__id__/peer.trc experiment-output/0004/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0004/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0004/slave-__id__/client experiment-output/0004/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0004/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0004/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0004/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0004/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0004-slave-__id__.tar.gz experiment-output/0004/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0004-slave-__id__.tar.gz experiment-output/0004/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0004/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0004-logs.log stubborn-scp.sh 10 experiment-output-0004-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0004/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0004-logs.log stubborn-scp.sh 10 experiment-output-0004-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0004/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0004


#========================================
# 0005
#========================================


# Wait for slaves.
wait for slaves peers 4
wait for slaves 1client 1

# Create log directory.
exec-start __all__ /dev/null mkdir -p experiment-output/0005/slave-__id__
exec-wait __all__ 2000

# Push config files.
exec-start peers scp-output-0005-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0005.yml config/config.yml
exec-wait peers 60000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not fetch config; exec-wait peers 2000
exec-start 1client scp-output-0005-config.log stubborn-scp.sh 10 34.205.140.3:experiment-config/config-0005.yml config/config.yml
exec-wait 1client 60000 exec-start 1client experiment-output/0005/slave-__id__/FAILED echo Could not fetch config; exec-wait 1client 2000
sync peers
sync 1client

# Start peers.
discover-reset 4
exec-start peers experiment-output/0005/slave-__id__/peer.log orderingpeer config/config.yml 34.205.140.3:9999 __public_ip__ __private_ip__ experiment-output/0005/slave-__id__/peer.trc experiment-output/0005/slave-__id__/prof
discover-wait

# Run clients and wait for them to stop.
exec-start 1client experiment-output/0005/slave-__id__/clients.log orderingclient config/config.yml 34.205.140.3:9999 experiment-output/0005/slave-__id__/client experiment-output/0005/slave-__id__/prof-client
exec-wait 1client 480000 exec-start 1client experiment-output/0005/slave-__id__/FAILED echo Client failed or timed out; exec-wait 1client 2000
sync 1client

# Stop peers.
exec-signal peers SIGINT
wait for 5s

# Save config file.
exec-start peers /dev/null cp config/config.yml experiment-output/0005/slave-__id__
exec-wait peers 2000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not log config file; exec-wait peers 2000
exec-start 1client /dev/null cp config/config.yml experiment-output/0005/slave-__id__
exec-wait 1client 2000 exec-start 1client experiment-output/0005/slave-__id__/FAILED echo Could not log config file; exec-wait 1client 2000

# Submit logs to master node
exec-start peers /dev/null tar czf experiment-output-0005-slave-__id__.tar.gz experiment-output/0005/slave-__id__
exec-wait peers 30000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not compress logs; exec-wait peers 2000
exec-start 1client /dev/null tar czf experiment-output-0005-slave-__id__.tar.gz experiment-output/0005/slave-__id__
exec-wait 1client 30000 exec-start 1client experiment-output/0005/slave-__id__/FAILED echo Could not compress logs; exec-wait 1client 2000
exec-start peers scp-output-0005-logs.log stubborn-scp.sh 10 experiment-output-0005-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait peers 60000 exec-start peers experiment-output/0005/slave-__id__/FAILED echo Could not submit logs; exec-wait peers 2000
exec-start 1client scp-output-0005-logs.log stubborn-scp.sh 10 experiment-output-0005-slave-__id__.tar.gz 34.205.140.3:current-deployment-data/raw-results/
exec-wait 1client 60000 exec-start 1client experiment-output/0005/slave-__id__/FAILED echo Could not submit logs; exec-wait 1client 2000
sync peers
sync 1client

# Update master status.
write-file /root/status 0005


#========================================
# Wrap up                                
#========================================

# Wait for all slaves, even if they were not involved in experiments.
# Wait for slaves.
wait for slaves 1client 1
wait for slaves peers 4

# Stop all slaves.
stop __all__
wait for 3s

write-file /root/status DONE
