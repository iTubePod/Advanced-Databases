=====Hector Mauricio Gonzalez Coello=====
================A01328258================

CREATE (student1:Student { name:'Neve Douglas', age: 20}),
(student2:Student { name:'Sopoline E. Woodard, age: 21}),
(student3:Student { name:'Jarrod O. Moody', age: 22}),
(student4:Student { name:'Brock Melendez', age: 23}),
(student5:Student { name:'Burton Wall', age: 24}),
(student6:Student { name:'Shellie X. Mccoy', age: 19}),
(student7:Student { name:'Finn Q. Mendez', age: 18}),
(student8:Student { name:'Cassandra Good', age: 21}),
(student9:Student { name:'Candace S. Spencer', age: 20}),
(student10:Student { name:'Imogene D. Holt', age: 21}),
(student11:Student { name:'Riley Glover', age: 22}),
(student12:Student { name:'Leslie Dickson', age: 20}),
(student13:Student { name:'Sydney Mcguire', age: 21}),
(student14:Student { name:'Vivien Barron', age: 20}),
(student15:Student { name:'Caleb Garrison', age: 23}),
(student16:Student { name:'Eve S. Trevino', age: 24}),
(student17:Student { name:'Shaeleigh Sherman', age: 20}),
(student18:Student { name:'Amber Z. Huber', age: 20}),
(student19:Student { name:'Riley B. Frye', age: 18}),
(student20:Student { name:'Madison I. Underwood', age: 19})

CREATE
  (student1)-[:AQUINTANCE_OF { since : '2018-03-02', until : '9999-12-30}]->(student13),
  (student5)-[:AQUINTANCE_OF { since : '2018-08-01', until : '9999-12-30}]->(student8),
  (student9)-[:AQUINTANCE_OF { since : '2015-05-01', until : '9999-12-30}]->(student13),
  (student8)-[:AQUINTANCE_OF { since : '2019-02-01', until : '9999-12-30}]->(student14)

CREATE
  (student2)-[:FRIEND_OF {since:'2018-05-01', until:'9999-12-30}]->(student13),
  (student2)-[:FRIEND_OF {since:'2018-05-01', until:'9999-12-30}]->(student12),
  (student3)-[:FRIEND_OF {since:'2019-03-01', until:'9999-12-30}]->(student4),
  (student5)-[:FRIEND_OF {since:'2017-04-01', until:'9999-12-30}]->(student7),
  (student8)-[:FRIEND_OF {since:'2019-03-01', until:'9999-12-30}]->(student13),
  (student6)-[:FRIEND_OF {since:'2018-05-01', until:'9999-12-30}]->(student13),
  (student1)-[:FRIEND_OF {since:'2018-05-01', until:'9999-12-30}]->(student13),

CREATE
  (student9)-[:IN_RELATIONSHIP_WITH {since:'2018-05-01', until :'2018-06-30}]->(student12),
  (student9)-[:IN_RELATIONSHIP_WITH {since:'2018-05-01', until :'2018-12-30}]->(student13),
  (student9)-[:IN_RELATIONSHIP_WITH {since:'2018-05-01', until :'2018-12-30}]->(student14),
  (student10)-[:IN_RELATIONSHIP_WITH {since:'2017-02-01', until :'9999-12-30}]->(student11),
  (student12)-[:IN_RELATIONSHIP_WITH {since:'2016-01-01', until :'9999-12-30}]->(student7),
  (student15)-[:IN_RELATIONSHIP_WITH {since:'2015-12-01', until :'9999-12-30}]->(student1)

