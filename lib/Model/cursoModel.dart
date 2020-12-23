// To parse this JSON data, do
//
//     final curso = cursoFromJson(jsonString);

import 'dart:convert';

List<Curso> cursoFromJson(String str) => List<Curso>.from(json.decode(str).map((x) => Curso.fromJson(x)));

String cursoToJson(List<Curso> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Curso {
  Curso({
    this.nomCursos,
    this.descripcion,
    this.imagen,
    this.idpersona,
    this.idCategorias
  });

  String nomCursos;
  String descripcion;
  String imagen;
  Idpersona idpersona;
  IdCategorias idCategorias;

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
    nomCursos: json["nom_cursos"],
    descripcion: json["descripcion"],
    imagen: json["imagen"],
    idpersona: Idpersona.fromJson(json["idpersona"]),
    idCategorias: IdCategorias.fromJson(json["idcategorias"]),
  );

  Map<String, dynamic> toJson() => {
    "nom_cursos": nomCursos,
    "descripcion": descripcion,
    "imagen": imagen,
    "idpersona": idpersona.toJson(),
  };
}

class Idpersona {
  Idpersona({
    this.nombPer,
  });

  String nombPer;

  factory Idpersona.fromJson(Map<String, dynamic> json) => Idpersona(
    nombPer: json["nomb_per"],
  );

  Map<String, dynamic> toJson() => {
    "nomb_per": nombPer,
  };
}
class IdCategorias {
  IdCategorias({
    this.cat,
  });

  String cat;

  factory IdCategorias.fromJson(Map<String, dynamic> json) => IdCategorias(
    cat: json["nombre_cat"],
  );

  Map<String, dynamic> toJson() => {
    "nombre_cat": cat,
  };
}