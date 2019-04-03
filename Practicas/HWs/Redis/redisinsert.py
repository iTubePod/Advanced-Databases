from rediscluster import StrictRedisCluster
startup_nodes = [{"host": "172.21.0.2", "port": "6379"}]

r = StrictRedisCluster(startup_nodes=startup_nodes, decode_responses=True)

for x in range(1, 1000000):
  r.set('titleMovie' + str(x) ,'Harry Potter ' + str(x))
