import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'package:practica2/src/models/populardao.dart';

class ApiPopular {
  final String URL_POPULAR =
      "https://api.themoviedb.org/3/movie/popular?api_key=18f513131c9ae8a7178ae6e877808b72";
  Client http = Client();

  Future<List<PopularDAO>> getAllPopular() async {
    final response = await http.get(URL_POPULAR);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularDAO> listPopular =
          popular.map((movie) => PopularDAO.fromJSON(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }
}
