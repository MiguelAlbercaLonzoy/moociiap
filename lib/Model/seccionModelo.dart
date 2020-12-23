// To parse this JSON data, do
//
//     final curso = cursoFromJson(jsonString);

import 'dart:convert';

List<Curso> cursoFromJson(String str) => List<Curso>.from(json.decode(str).map((x) => Curso.fromJson(x)));

String cursoToJson(List<Curso> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Curso {
  Curso({
    this.idseccionCurso,
    this.nombreSecc,
    this.estado,
    this.idcursos,
  });

  int idseccionCurso;
  String nombreSecc;
  int estado;
  Idcursos idcursos;

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
    idseccionCurso: json["idseccion_curso"],
    nombreSecc: json["nombre_secc"],
    estado: json["estado"],
    idcursos: Idcursos.fromJson(json["idcursos"]),
  );

  Map<String, dynamic> toJson() => {
    "idseccion_curso": idseccionCurso,
    "nombre_secc": nombreSecc,
    "estado": estado,
    "idcursos": idcursos.toJson(),
  };
}

class Idcursos {
  Idcursos({
    this.idcursos,
    this.nomCursos,
    this.calificacion,
    this.fechaIni,
    this.descripcion,
    this.imagen,
    this.cantEstudi,
    this.estado,
    this.fechaFin,
    this.idcategorias,
    this.idpersona,
  });

  int idcursos;
  String nomCursos;
  String calificacion;
  DateTime fechaIni;
  String descripcion;
  String imagen;
  String cantEstudi;
  int estado;
  DateTime fechaFin;
  Idcategorias idcategorias;
  Idpersona idpersona;

  factory Idcursos.fromJson(Map<String, dynamic> json) => Idcursos(
    idcursos: json["idcursos"],
    nomCursos: json["nom_cursos"],
    calificacion: json["calificacion"],
    fechaIni: DateTime.parse(json["fecha_ini"]),
    descripcion: json["descripcion"],
    imagen: json["imagen"],
    cantEstudi: json["cant_estudi"],
    estado: json["estado"],
    fechaFin: DateTime.parse(json["fecha_fin"]),
    idcategorias: Idcategorias.fromJson(json["idcategorias"]),
    idpersona: Idpersona.fromJson(json["idpersona"]),
  );

  Map<String, dynamic> toJson() => {
    "idcursos": idcursos,
    "nom_cursos": nomCursos,
    "calificacion": calificacion,
    "fecha_ini": "${fechaIni.year.toString().padLeft(4, '0')}-${fechaIni.month.toString().padLeft(2, '0')}-${fechaIni.day.toString().padLeft(2, '0')}",
    "descripcion": descripcion,
    "imagen": imagen,
    "cant_estudi": cantEstudi,
    "estado": estado,
    "fecha_fin": "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
    "idcategorias": idcategorias.toJson(),
    "idpersona": idpersona.toJson(),
  };
}

class Idcategorias {
  Idcategorias({
    this.idcategorias,
    this.nombreCat,
    this.estado,
    this.field,
  });

  int idcategorias;
  String nombreCat;
  int estado;
  String field;

  factory Idcategorias.fromJson(Map<String, dynamic> json) => Idcategorias(
    idcategorias: json["idcategorias"],
    nombreCat: json["nombre_cat"],
    estado: json["estado"],
    field: json["field"],
  );

  Map<String, dynamic> toJson() => {
    "idcategorias": idcategorias,
    "nombre_cat": nombreCat,
    "estado": estado,
    "field": field,
  };
}

class Idpersona {
  Idpersona({
    this.idpersona,
    this.nombPer,
    this.foto,
    this.correo,
    this.celular,
    this.estado,
  });

  int idpersona;
  String nombPer;
  String foto;
  String correo;
  int celular;
  String estado;

  factory Idpersona.fromJson(Map<String, dynamic> json) => Idpersona(
    idpersona: json["idpersona"],
    nombPer: json["nomb_per"],
    foto: json["foto"],
    correo: json["correo"],
    celular: json["celular"],
    estado: json["estado"],
  );

  Map<String, dynamic> toJson() => {
    "idpersona": idpersona,
    "nomb_per": nombPer,
    "foto": foto,
    "correo": correo,
    "celular": celular,
    "estado": estado,
  };
}