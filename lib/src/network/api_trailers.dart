import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/trailerdao.dart';

class ApiTrailer {
  int id = 0;
  final String URL_TRAILER1 = "https://api.themoviedb.org/3/movie/";
  final String URL_TRAILER2 =
      "/trailers?api_key=18f513131c9ae8a7178ae6e877808b72";
  Client http = Client();

  Future<List<Youtube>> getAllTrailers(URLTRAILER) async {
    final response = await http.get(URLTRAILER);
    if (response.statusCode == 200) {
      var trailer = jsonDecode(response.body)['youtube'] as List;

      List<Youtube> listTrailers =
          trailer.map((video) => Youtube.fromJson(video)).toList();

      return listTrailers;
    } else {
      return null;
    }
  }
}
