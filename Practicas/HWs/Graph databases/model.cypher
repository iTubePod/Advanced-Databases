=====Hector Mauricio Gonzalez Coello=====
================A01328258================

docker run --publish=7474:7474 --publish=7687:7687 --volume=$HOME/Documents/neo4j/data:/data  --volume=$HOME/Documents/neo4j-import:/var/lib/neo4j/import --env=NEO4J_AUTH=none neo4j

LOAD CSV WITH HEADERS FROM 'file:///students.csv' AS row
WITH toInteger(row.student_id) AS _student_id, row.name AS _name, toInteger(row.age) AS _age
MERGE (o:Student {student_id: _student_id})
SET o.name = _name, o.age = _age
RETURN COUNT(o)

LOAD CSV WITH HEADERS FROM 'file:///friend_of.csv' AS row
WITH toInteger(row.student_a) AS _student_a, toInteger(row.student_b) AS _student_b, toInteger(row.duration) AS _duration
MATCH (s1:Student {student_id: _student_a})
MATCH (s2:Student {student_id: _student_b})
MERGE (s1) - [friend:FRIEND_OF {duration:_duration}] -> (s2)
RETURN COUNT(friend)

LOAD CSV WITH HEADERS FROM 'file:///aquintance_of.csv' AS row
WITH toInteger(row.student_a) AS _student_a, toInteger(row.student_b) AS _student_b, toInteger(row.duration) AS _duration
MATCH (s1:Student {student_id: _student_a})
MATCH (s2:Student {student_id: _student_b})
MERGE (s1) - [aquintance:AQUINTANCE_OF {duration:_duration}] -> (s2)
RETURN COUNT(aquintance)

LOAD CSV WITH HEADERS FROM 'file:///in_relationship_with.csv' AS row
WITH toInteger(row.student_a) AS _student_a, toInteger(row.student_b) AS _student_b, toInteger(row.duration) AS _duration
MATCH (s1:Student {student_id: _student_a})
MATCH (s2:Student {student_id: _student_b})
MERGE (s1) - [couple:IN_RELATIONSHIP_WITH {duration:_duration}] -> (s2)
RETURN COUNT(couple)