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
MATCH (s1:Student)-[b:IN_RELATIONSHIP_WITH]->(s2:Student) 
WITH s1, COUNT(b) as c
WHERE c >= 1
return s1.name, s1.age, c

#Dado el nombre de un estudiante, obtener quiénes han sido sus parejas y qué tiempo duró cada relación.
MATCH (s1:Student {name: 'Uriel Baxter'})-[b:IN_RELATIONSHIP_WITH]-(mate:Student)
with s1, mate, b
RETURN s1.name, mate.name, b.duration

# Quién es el estudiante que ha tenido más relaciones de amistad.
MATCH (studentA:Student)-[:FRIEND_OF]->(studentB:Student)
with studentA, SIZE(COLLECT(studentA)) as cnt
RETURN studentA.name
ORDER BY cnt DESC LIMIT 1

#Quiénes son los estudiantes que no han tenido relaciones de pareja
MATCH (studentA)-[r:IN_RELATIONSHIP_WITH]->()
    WHERE r IS NULL 
    RETURN studentA.name

#Quiénes son los estudiantes que han tenido mas de 3 relaciones de pareja.
MATCH (student)-[:IN_RELATIONSHIP_WITH]->(studentB) 
WITH student, count(*) as relationships
where relationships > 3
return student.name, relationships

#Dado un estudiante, determinar el número de estudiantes que él conoce.
MATCH (:Student {name: 'Winter R. Grimes'})-[AQUINTANCE_OF]-(friend)
RETURN COUNT(AQUINTANCE_OF)

#Dado un estudiante, determinar quiénes lo conocen a él.
MATCH (:Student {name: 'Winter R. Grimes'})-[AQUINTANCE_OF]-(mate)
RETURN mate.name


