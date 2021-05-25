import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:practica2/src/models/likeddao.dart';
import 'package:practica2/src/models/userdao.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _nombreDB = "MOVIESDB2";
  static final _versionDB = 2;

  static Database _database;
  Future get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreDB);
    return await openDatabase(rutaDB, version: _versionDB, onCreate: _scriptBD);
  }

  _scriptBD(Database db, int version) async {
    db.execute(
        "CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY, nomusr VARCHAR(100), telusr char(10), mailusr varchar(35), photousr varchar(200))");
    db.execute(
        "CREATE TABLE tbl_liked(id INTEGER PRIMARY KEY, mailusr varchar(35), idMovie int)");
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    var connection = await database;
    return await connection.insert(
      table,
      values,
    );
  }

  Future<int> update(String table, Map<String, dynamic> values) async {
    var connection = await database;
    return await connection.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [
        values['id'],
      ],
    );
  }

  Future<int> delete(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'id=?', whereArgs: [id]);
  }

  Future<UserDAO> getUser(String email) async {
    var connection = await database;
    var results = await connection.query(
      'tbl_perfil',
      where: 'mailusr = ?',
      whereArgs: [email],
    );
    var lista = (results).map((u) => UserDAO.fromJSON(u)).toList();
    if (lista.length > 0)
      return lista[0];
    else
      return null;
  }

  Future<int> isLiked(int idMovie, String mailUsr) async {
    var dbClient = await database;
    var result = await dbClient.query('tbl_liked',
        where: "idMovie = ? and mailusr = ?", whereArgs: [idMovie, mailUsr]);
    var lista = result.map((item) => Liked.fromJson(item)).toList();

    return lista.length > 0 ? 1 : 0;
  }

  Future getLiked(String mailusr) async {
    var connection = await database;
    var result = await connection
        .query('tbl_liked', where: "mailusr = ?", whereArgs: [mailusr]);

    var lista = result.map((item) => Liked.fromJson(item)).toList();

    return lista.length > 0 ? lista : null;
  }

  Future<int> deleteLiked(String table, String mailusr, int idMovie) async {
    var conexion = await database;
    return await conexion.delete(table,
        where: 'idMovie=? and mailusr=?', whereArgs: [idMovie, mailusr]);
  }
}
