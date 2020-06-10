docker swarm init 
#Swarm initialized: current node (828tz4698g7lkzilr4ez3k7uv) is now a manager.
#
#To add a worker to this swarm, run the following command:
#
#   docker swarm join --token SWMTKN-1-36kfp3iz7vpjzsjz5ths6lr83at5xsw20lo3m4v9u3hjjwxj9x-2cqikoukf8bikipx5yg46xise 172.22.220.185:2377
#
#    To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

ping 828tz4698g7lkzilr4ez3k7uv
#PING 828tz4698g7lkzilr4ez3k7uv (23.202.231.169) 56(84) bytes of data.
#64 bytes from a23-202-231-169.deploy.static.akamaitechnologies.com (23.202.231.169): icmp_seq=1 ttl=51 time=32.8 ms
#64 bytes from a23-202-231-169.deploy.static.akamaitechnologies.com (23.202.231.169): icmp_seq=2 ttl=51 time=31.4 ms
ssh aws-ec2-manager 
docker swarm join --token SWMTKN-1-36kfp3iz7vpjzsjz5ths6lr83at5xsw20lo3m4v9u3hjjwxj9x-2cqikoukf8bikipx5yg46xise 172.22.220.185:2377
