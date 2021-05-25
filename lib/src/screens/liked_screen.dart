import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/likeddao.dart';
import 'package:practica2/src/models/populardao.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/views/card_popular.dart';

class LikedScreen extends StatefulWidget {
  LikedScreen({Key key}) : super(key: key);

  @override
  _LikedScreenState createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  ApiPopular apiPopular;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();
    apiPopular = ApiPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Movies"),
      ),
      body: FutureBuilder(
        future: _database.getLiked("17030696@itcelaya.edu.mx"),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Has error in this request :c"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            inspect(snapshot.data);
            return FutureBuilder(
              future: apiPopular.getAllPopular(),
              builder: (BuildContext context, snapshot2) {
                if (snapshot2.hasError) {
                  return Center(
                    child: Text("Has error in this request :c"),
                  );
                } else if (snapshot2.connectionState == ConnectionState.done) {
                  inspect(snapshot2.data);
                  return _listPopularMovies(snapshot2.data, snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
          },
          child: Icon(Icons.replay),
          backgroundColor: Colors.red),
    );
  }

  Widget _listPopularMovies(List<PopularDAO> movies, List liked) {
    return ListView.builder(
      itemBuilder: (context, index) {
        PopularDAO popular = movies[index];
        for (var i = 0; i < liked.length; i++) {
          if (popular.id == liked[i].idMovie) {
            return CardPopular(
              popular: popular,
            );
          }
        }
        return SizedBox();
      },
      itemCount: movies.length,
    );
  }
}
