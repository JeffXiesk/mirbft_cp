import sys

client_num=int(sys.argv[1])
peer_num=int(sys.argv[2])
num=int((len(sys.argv)-3)/2)

with open('scripts/cloud-deploy/cloud-instance-info','w') as f:
    f.write('master '+sys.argv[3]+' '+sys.argv[num+3]+' master us-west-2a\n')

    client_str='1client'
    if client_num==16:
        client_str='16clients'
    if client_num==32:
        client_str='32clients'
    for i in range(client_num):
        f.write('client '+sys.argv[i+4]+' '+sys.argv[num+4+i]+' '+client_str+' us-west-2a\n')
    for i in range(peer_num):
        f.write('p'+str(i+1)+' '+sys.argv[i+client_num+4]+' '+sys.argv[client_num+num+4+i]+' peers us-west-2a\n')
        
    print('Write \'cloud-instance-info\' successfully !')