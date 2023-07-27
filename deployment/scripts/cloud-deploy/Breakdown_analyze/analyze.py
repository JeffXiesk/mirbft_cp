import sqlite3
import numpy as np
import os
import sys

experiment_num=[]
for dirPath, dirNames, fileNames in os.walk(sys.argv[1]+'/experiment-output'):    
    # print(dirPath)
    print(dirNames)
    experiment_num=dirNames
    # print(fileNames)
    break


for num in experiment_num:
    print('-------------'+str(num)+'-------------')
    path=sys.argv[1]+'/experiment-output/'+num
    print(path)

    conn = sqlite3.connect(path+'/eventDB.sqlite')

    cursor = conn.cursor()

    cursor.execute('SELECT count(distinct nodeId) FROM protocol;')
    row = cursor.fetchone()
    quorum=int(row[0]/3)
    print(quorum)
    # quorum=5


    cursor.execute('SELECT * FROM request;')

    rows = cursor.fetchall() 


    req_info_raw={}

    req_send={}
    req_propose={}
    req_finished={}
    req_receive={}
    req_commit={}
    req_delivered={}
    resp_send={}
    resp_receive={}

    req_receive_raw={}
    req_commit_raw={}
    req_delivered_raw={}
    resp_send_raw={}
    resp_receive_raw={}

    for row in rows:
        if row[1]=='REQ_SEND':
            if row[2] not in req_send:
                req_send[row[2]] = {}
            if row[3] not in req_send[row[2]]:
                req_send[row[2]][row[3]] = row[0]

        if row[1]=='REQ_RECEIVE':
            if row[2] not in req_receive_raw:
                req_receive_raw[row[2]] = {}
            if row[3] not in req_receive_raw[row[2]]:
                req_receive_raw[row[2]][row[3]] = [row[0]]
            else:
                req_receive_raw[row[2]][row[3]].append(row[0])        

        if row[1]=='REQ_PROPOSE':
            if row[2] not in req_propose:
                req_propose[row[2]] = {}        
            if row[3] not in req_propose[row[2]]:
                req_propose[row[2]][row[3]] = row[0]

        if row[1]=='REQ_COMMIT':
            if row[2] not in req_commit_raw:
                req_commit_raw[row[2]] = {}        
            if row[3] not in req_commit_raw[row[2]]:
                req_commit_raw[row[2]][row[3]] = [row[0]]
            else:
                req_commit_raw[row[2]][row[3]].append(row[0])  

        if row[1]=='REQ_DELIVERED':
            if row[2] not in req_delivered_raw:
                req_delivered_raw[row[2]] = {}        
            if row[3] not in req_delivered_raw[row[2]]:
                req_delivered_raw[row[2]][row[3]] = [row[0]]
            else:
                req_delivered_raw[row[2]][row[3]].append(row[0])  

        if row[1]=='RESP_SEND':
            if row[2] not in resp_send_raw:
                resp_send_raw[row[2]] = {}
            if row[3] not in resp_send_raw[row[2]]:
                resp_send_raw[row[2]][row[3]] = [row[0]]
            else:
                resp_send_raw[row[2]][row[3]].append(row[0])  

        if row[1]=='RESP_RECEIVE':
            if row[2] not in resp_receive_raw:
                resp_receive_raw[row[2]] = {}
            if row[3] not in resp_receive_raw[row[2]]:
                resp_receive_raw[row[2]][row[3]] = [row[0]]
            else:
                resp_receive_raw[row[2]][row[3]].append(row[0])  

        if row[1]=='REQ_FINISHED':
            if row[2] not in req_finished:
                req_finished[row[2]] = {}
            if row[3] not in req_finished[row[2]]:
                req_finished[row[2]][row[3]] = row[0]


    for key1 in req_receive_raw:
        if key1 not in req_receive:
            req_receive[key1] = {}
        for key2 in req_receive_raw[key1]:
            req_receive[key1][key2] = np.median(np.array(req_receive_raw[key1][key2]))
            # req_receive[key1][key2] = np.mean(np.array(req_receive_raw[key1][key2]))

    for key1 in req_delivered_raw:
        if key1 not in req_delivered:
            req_delivered[key1] = {}
        for key2 in req_delivered_raw[key1]:
            req_delivered[key1][key2] = np.median(np.array(req_delivered_raw[key1][key2]))
            # req_delivered[key1][key2] = np.mean(np.array(req_delivered_raw[key1][key2]))

    for key1 in req_commit_raw:
        if key1 not in req_commit:
            req_commit[key1] = {}
        for key2 in req_commit_raw[key1]:
            req_commit[key1][key2] = np.median(np.array(req_commit_raw[key1][key2]))
            # req_commit[key1][key2] = np.mean(np.array(req_commit_raw[key1][key2]))

    for key1 in resp_send_raw:
        if key1 not in resp_send:
            resp_send[key1] = {}
        for key2 in resp_send_raw[key1]:
            resp_send[key1][key2] = np.median(np.array(resp_send_raw[key1][key2]))
            # resp_send[key1][key2] = np.mean(np.array(resp_send_raw[key1][key2]))

    for key1 in resp_receive_raw:
        if key1 not in resp_receive:
            resp_receive[key1] = {}
        for key2 in resp_receive_raw[key1]:
            if len(resp_receive_raw[key1][key2]) <= quorum:
                resp_receive[key1][key2] = resp_receive_raw[key1][key2][len(resp_receive_raw[key1][key2])-1]
            else:
                resp_receive[key1][key2] = resp_receive_raw[key1][key2][quorum]
            # resp_receive[key1][key2] = np.mean(np.array(resp_receive_raw[key1][key2]))

    # print('req_send is ',req_send)
    # print('req_propose is ',req_propose)
    # print('req_finished is ',req_finished)
    # print(req_receive)
    # print(req_commit)
    # print(resp_send)
    # print(resp_receive)


    cnt=0
    for key1 in req_send:
        if key1 in req_send and key1 in req_propose and key1 in req_finished and key1 in req_receive and key1 in req_commit and key1 in resp_send and key1 in resp_receive:
            for key2 in req_send[key1]:
                if key2 in req_send[key1] and key2 in req_propose[key1] and key2 in req_finished[key1] and key2 in req_receive[key1] and key2 in req_commit[key1] and key2 in resp_send[key1] and key2 in resp_receive[key1]:

                    req_info_raw[cnt]={'REQ_SEND':0, 
                                       'REQ_RECEIVE':req_receive[key1][key2]-req_send[key1][key2], 
                                       'REQ_PROPOSE':req_propose[key1][key2]-req_receive[key1][key2], 
                                       'REQ_COMMIT':req_commit[key1][key2]-req_propose[key1][key2], 
                                       'REQ_DELIVERED':req_delivered[key1][key2]-req_commit[key1][key2], 
                                       'RESP_SEND':resp_send[key1][key2]-req_commit[key1][key2], 
                                       'RESP_RECEIVE':resp_receive[key1][key2]-resp_send[key1][key2], 
                                       'REQ_FINISHED':req_finished[key1][key2]-resp_receive[key1][key2]}
                    cnt+=1

    print('cnt is', cnt)

    req_send_list=[]
    req_receive_list=[]
    req_propose_list=[]
    req_commit_list=[]
    req_delivered_list=[]
    resp_send_list=[]
    resp_receive_list=[]
    req_finished_list=[]

    for i in req_info_raw:
        # print(req_info_raw[i])
        req_send_list.append(req_info_raw[i]['REQ_SEND'])
        req_propose_list.append(req_info_raw[i]['REQ_PROPOSE'])
        req_receive_list.append(req_info_raw[i]['REQ_RECEIVE'])
        req_commit_list.append(req_info_raw[i]['REQ_COMMIT'])
        req_delivered_list.append(req_info_raw[i]['REQ_DELIVERED'])
        resp_send_list.append(req_info_raw[i]['RESP_SEND'])
        resp_receive_list.append(req_info_raw[i]['RESP_RECEIVE'])
        req_finished_list.append(req_info_raw[i]['REQ_FINISHED'])

    req_info={'REQ_SEND':np.array(req_send_list).mean(), 
              'REQ_RECEIVE':np.array(req_receive_list).mean(), 
              'REQ_PROPOSE':np.array(req_propose_list).mean(), 
              'REQ_COMMIT':np.array(req_commit_list).mean(), 
              'REQ_DELIVERED':np.array(req_delivered_list).mean(), 
              'RESP_SEND':np.array(resp_send_list).mean(), 
              'RESP_RECEIVE':np.array(resp_receive_list).mean(), 
              'REQ_FINISHED':np.array(req_finished_list).mean()}

    print(req_info)
    # cursor.execute('SELECT * FROM protocol;')

    # rows = cursor.fetchall() 



    cursor.close()
    conn.close()
