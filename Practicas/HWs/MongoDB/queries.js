/*
    Héctor Mauricio González Coello
    A01328258
*/

//El nombre de todos los profesores ordenados ascendentemente. 

db.Profesores.find({},{nombre:1}).sort( { nombre: 1 } )

//La calificación promedio obtenida por todos los estudiantes en todos los exámenes. 

db.Examen_Alumno.aggregate([
    {"$group" : {_id:"$examen", calificacion: {$avg:{$sum: "$calificacion"}}}}])

//El nombre del estudiante que ha obtenido la calificación más alta en las prácticas. 

db.getCollection("Alumnos_Practica").aggregate([
    {$lookup:{
        from: "Alumnos",
        localField : "alumno",
        foreignField : "id",
        as : "best_student"
    }},
    {$unwind:'$best_student'},
    {$sort: {"calificacion": -1}},
    {$limit: 1},
    {$project:{
        _id: 0,
        name:'$best_student.nombre',
        lastname:'$best_student.apellido',
        grade: '$calificacion'
    }}
])

//El nombre del estudiante que ha obtenido la calificación más alta en los exámenes. 

db.getCollection("Examen_Alumno").aggregate([
    {$lookup:{
        from: "Alumnos",
        localField : "alumno",
        foreignField : "id",
        as : "best_student"
    }},
    {$unwind:'$best_student'},
    {$sort: {"calificacion": -1}},
    {$limit: 1},
    {$project:{
        _id: 0,
        name:'$best_student.nombre',
        lastname:'$best_student.apellido',
        grade: '$calificacion'
    }}
])

//El nombre de todos los estudiantes y el número de prácticas y exámenes que ha presentado cada uno de ellos. 
db.getCollection("Alumnos").aggregate([
    {$lookup:{
        from: "Examen_Alumno",
        localField : "id",
        foreignField : "alumno",
        as : "exams"
    }},
    {$lookup:{
        from: "Alumnos_Practica",
        localField : "id",
        foreignField : "alumno",
        as : "practices"
    }},
    {$project : 
        {
            _id: 0,
           name: "$nombre",
           lastname: "$apellido",
           exams: { 
                $size: { "$ifNull": [ "$exams", [] ] }
            },
            practices: { 
                $size: { "$ifNull": [ "$practices", [] ] }
            }
        }
    }
])

//El nombre de los profesores que no han diseñado ninguna práctica. 

db.Profesores.find({ practicas: { $size: 0} }, {nombre: 1, apellido: 1})

//El nombre de los profesores que han diseñado al menos una práctica, así como el número de prácticas que ha diseñado cada uno, ordenados descendentemente por el número de prácticas. 

db.getCollection("Profesores").aggregate([
    {$match: { practicas: { $gt: 1} }},
    {$project:
    {
        _id: 0,
        name:"$nombre",
        lastname:"$apellido",
        num_of_practices: {$size: "$practicas"}
    }}
])
//El título de cada práctica y el número total de alumnos que la han realizado, así como la calificación promedio obtenida por los estudiantes que la realizaron. 

db.getCollection("Examenes").aggregate([
    {$lookup:{
        from: "Examen_Alumno",
        localField : "id",
        foreignField : "examen",
        as : "exams"
    }},
    {$project : 
        {
            _id: 0,
           exam: "$id",
           average_score: { 
                $avg: { "$ifNull": [ "$exams.calificacion", [] ] }
            }
        }
    }
])

//El nombre de todos los estudiantes que han reprobado algún examen. 

db.getCollection("Examen_Alumno").aggregate([
    {$match: { calificacion: { $lt: 70} }},
    {$lookup:{
        from: "Alumnos",
        localField : "alumno",
        foreignField : "id",
        as : "students"
    }},
    {$unwind:'$students'},
    {$group : 
        {
            _id: {name: "$students.nombre", lastname: "$students.apellido"}
        }
    }
])

//El nombre de los estudiantes que han reprobado todos los exámenes. 

db.getCollection("Alumnos").aggregate([
    {$lookup:{
        from: "Examen_Alumno",
        localField : "id",
        foreignField : "alumno",
        as : "students"
    }},
    {$match: {"students.calificacion": {$not: {$gt: 70}}}},
    {$project : 
        {
            _id: 0,
           failed_name: "$nombre",
           failed_lastname: "$apellido",
           failed_score: "$students.calificacion"
        }
    }
])