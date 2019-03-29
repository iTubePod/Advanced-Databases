# Importar el grafo completo (demora mucho tiempo)

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/nodes.csv" AS row
CREATE (:Node {nodeID: row.nodeId});

CREATE INDEX ON :Node(nodeID);

USING PERIODIC COMMIT 
LOAD CSV WITH HEADERS FROM "file:/edges.csv" AS row
MATCH (start:Node {nodeID: row.StartId})
MATCH (end:Node {nodeID: row.EndId})
MERGE (start)-[:RELATION]->(end);


# Queries

# Contar el número de nodos

MATCH (n:Node)
RETURN count(n.nodeID)


# Obtener las conexiones entre dos nodos con un máximo de 3 saltos

MATCH (n:Node { nodeID: "1"})-[r:RELATION*1..3]-(m) RETURN n,r,m LIMIT 3
MATCH (n:Node { nodeID: "1"})-[r:RELATION*1..3]-(m) RETURN n,r,m LIMIT 5

# Obtener la ruta más corta entre dos nodos limitando el número de saltos

MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '900' }), p = shortestPath((n)-[*..15]-(m))
RETURN p

# Comparar las diferencias del plan de ejecución entre dos consultas: sin índice y con índice

EXPLAIN MATCH (n:Node { NodeId: "1" }),(m:Node { NodeId: '900' }), p = shortestPath((n)-[*..15]-(m))
RETURN p

EXPLAIN MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '900' }), p = shortestPath((n)-[*..15]-(m))
RETURN p

# Obtener la ruta más corta entre dos nodos sin limitar el número de saltos

MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '99900' }), p = shortestPath((n)-[*]-(m))
RETURN p

# Obtener todas las rutas de menor longitud entre dos nodos

MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '99900' }), p = allShortestPaths((n)-[*]-(m))
RETURN p

# Obtener la distancia de  las rutas de menor longitud entre dos nodos

MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '990' }), p = allShortestPaths((n)-[*..15]-(m))
RETURN length(p)

# Obtener el número de rutas de menor longitud entre dos nodos

MATCH (n:Node { nodeID: "1" }),(m:Node { nodeID: '990' }), p = allShortestPaths((n)-[*..15]-(m))
RETURN length(p), count(*)
