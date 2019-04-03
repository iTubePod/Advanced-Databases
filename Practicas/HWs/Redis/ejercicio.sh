=================================================
=========Hector Mauricio Gonzalez Coello=========
====================A01328258====================
=================================================


--Pull Redis from Docker Hub
docker pull redis

--Create redis network bridge
docker network create red_cluster

--Configuration file that goes inside usr/local/etc/redis/redis.conf
    port 6379
    cluster-enabled yes
    cluster-config-file nodes.conf
    cluster-node-timeout 5000
    appendonly yes

--Create containers with previously defined conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-1 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-2 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-3 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-4 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-5 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-6 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker run --network=red_cluster -itd --name=container3 ubuntu
docker cp redisinsert.py container3:/redisinsert.py


--Get container IPs
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-1
    --172.21.0.2
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-2
    --172.21.0.3
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-3
    --172.21.0.4
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-4
    --172.21.0.5
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-5
    --172.21.0.6
docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-6
    --172.21.0.7

--Create cluster from previously defined containers

docker run -i --rm --net red_cluster ruby sh -c '\
 gem install redis \
 && wget https://raw.githubusercontent.com/antirez/redis/4.0/src/redis-trib.rb \
 && ruby redis-trib.rb create --replicas 1 172.21.0.2:6379 172.21.0.3:6379 172.21.0.4:6379 172.21.0.5:6379 172.21.0.6:6379 172.21.0.7:6379'

--Check clusters
docker exec redis-1 redis-cli cluster nodes

--Connect to cli to insert values
docker exec -it redis-1 redis-cli -c
docker exec -it redis-3 redis-cli -c
docker exec -it redis-5 redis-cli -c

--Insert in clusters

SET title:1 "The Hobbit"
SET title:2 "The Terminator"
SET title:3 "I, Robot"

--Resharding
docker exec -it redis-1 redis-cli --cluster reshard 172.21.0.2:6379

--Faiover
docker exec -it redis-2 redis-cli -c
CLUSTER FAILOVER FORCE

--Add node to cluster
docker run -d -v /Users/mgcoello/Desktop/Ejercicio2/redis.conf:/usr/local/etc/redis/redis.conf --name redis-7 --net red_cluster redis redis-server /usr/local/etc/redis/redis.conf

docker inspect -f '{{ (index .NetworkSettings.Networks "red_cluster").IPAddress }}' redis-7

docker exec -it redis-1 redis-cli --cluster add-node 172.21.0.8:6379 172.21.0.2:6379 --cluster-slave

--Remove node from cluster
docker exec -it redis-1 redis-cli --cluster del-node 172.21.0.2:6379 edd81444eb9ae2d4e2efdcf1eb4caec462812313