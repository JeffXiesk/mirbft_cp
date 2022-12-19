import sys

client_num=int(sys.argv[1])
peer_num=int(sys.argv[2])
num=int((len(sys.argv)-3)/2)

with open('scripts/cloud-deploy/cloud-instance-info','w') as f:
    f.write('master '+sys.argv[3]+' '+sys.argv[num+3]+' master us-west-2a\n')
    for i in range(client_num):
        f.write('client '+sys.argv[i+3]+' '+sys.argv[num+3+i]+' 1client us-west-2a\n')
    for i in range(peer_num):
        f.write('p'+str(i+1)+' '+sys.argv[i+client_num+3]+' '+sys.argv[client_num+num+3+i]+' peers us-west-2a\n')
        
    print('Write \'cloud-instance-info\' successfully !')