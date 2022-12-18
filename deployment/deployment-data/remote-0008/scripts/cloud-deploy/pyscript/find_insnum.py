import re

if __name__='__main__':
    with open('scripts/experiment-configuration/generate-config.sh') as f:
        lines=f.readlines()
        num=0
        client_num=0
        peer_num=0
        for line in lines:
            find_client=re.search(r'clients\d+=\"')
            if find_client is not None:
                client_num=int(line[find_client.span()[1]])
                if line.startwith('client16'):
                    client_num*16
                if line.startwith('client16'):
                    client_num*32
                num+=client_num
            
            find_peer=re.search(r'systemSizes=\"')
            if find_peer is not None:
                peer_num_str=""
                idx=find_client.span()[1]
                tmp_str=line[idx]
                while tmp_str != "\"":
                    peer_num_str+=tmp_str
                    idx+=1
                    tmp_str=line[idx]
                peer_num=int(peer_num_str)
                num+=peer_num
                break
        print(client_num)
        print(peer_num)
        print(num)
            
                
                