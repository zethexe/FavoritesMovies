import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/castdao.dart';
import 'dart:developer';

class ApiCast {
  Client http = Client();

  Future<List<Cast>> getCast(URLC) async {
    final response = await http.get(URLC);
    if (response.statusCode == 200) {
      var cast = jsonDecode(response.body)['cast'] as List;
      List<Cast> listCast = cast.map((actor) => Cast.fromJson(actor)).toList();
      return listCast;
    } else {
      return null;
    }
  }
}
