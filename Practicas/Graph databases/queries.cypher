=====Hector Mauricio Gonzalez Coello=====
================A01328258================

# El nombre de todos los estudiantes ordenados ascendentemente por los apellidos.
MATCH (student)
RETURN student.name
ORDER BY student.name

# El nombre y edad de todos los estudiantes mayor de 20 años.
MATCH (student)
WHERE student.age > 20
RETURN student.name, student.age

# El nombre y edad de todos los estudiantes que han tenido al menos una pareja.
MATCH (student)-[IN_RELATIONSHIP_WITH]->() 
WHERE COUNT(IN_RELATIONSHIP_WITH) >= 1
return student.name, student.age

#Dado el nombre de un estudiante, obtener quiénes han sido sus parejas y qué tiempo duró cada relación.
MATCH (:Student {name: 'Candace S. Spencer'})-[IN_RELATIONSHIP_WITH]-(mate)
RETURN mate.name, IN_RELATIONSHIP_WITH.since, IN_RELATIONSHIP_WITH.until

# Quién es el estudiante que ha tenido más relaciones de amistad.
MATCH (studentA)-[:FRIEND_OF]->(studentB)
RETURN studentA.name
ORDER BY SIZE(COLLECT(studentA)) DESC LIMIT 1

#Quiénes son los estudiantes que no han tenido relaciones de pareja
MATCH student WHERE NOT (student)-[:IN_RELATIONSHIP_WITH]->()

#Quiénes son los estudiantes que han tenido mas de 3 relaciones de pareja.
MATCH (student)-[:IN_RELATIONSHIP_WITH]->(studentB) 
WITH student, count(*) as relationships
where relationships > 3
return student.name

#Dado un estudiante, determinar el número de estudiantes que él conoce.
MATCH (:Student {name: 'Candace S. Spencer'})-[AQUINTANCE_OF]-(friend)
RETURN COUNT(AQUINTANCE_OF)

#Dado un estudiante, determinar quiénes lo conocen a él.
MATCH (:Student {name: 'Candace S. Spencer'})-[AQUINTANCE_OF]-(mate)
RETURN mate.name


