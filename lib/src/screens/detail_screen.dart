import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/castdao.dart';
import 'package:practica2/src/models/likeddao.dart';
import 'package:practica2/src/models/trailerdao.dart';
import 'package:practica2/src/network/api_cast.dart';
import 'package:practica2/src/network/api_trailers.dart';
import 'package:practica2/src/views/card_cast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:ui' as ui;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiTrailer apiTrailer;
  ApiCast apiCast;
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    apiTrailer = ApiTrailer();
    apiCast = ApiCast();
  }

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    var urlt = "https://api.themoviedb.org/3/movie/" +
        movie['id'].toString() +
        "/trailers?api_key=18f513131c9ae8a7178ae6e877808b72";
    var urlc = "https://api.themoviedb.org/3/movie/" +
        movie['id'].toString() +
        "/credits?api_key=18f513131c9ae8a7178ae6e877808b72";

    DatabaseHelper _database = DatabaseHelper();

    return Stack(
      children: [
        FutureBuilder(
          future: apiTrailer.getAllTrailers(urlt),
          builder:
              (BuildContext context, AsyncSnapshot<List<Youtube>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Has error in this request :c"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(children: [
                  Opacity(
                    opacity: .20,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/${movie['posterpath']}'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: snapshot.data[0].source,
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                ),
                                liveUIColor: Colors.amber,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      movie['title'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontFamily: 'Arvo'),
                                    )),
                                    Text(
                                      '${movie['vote_average']}/10',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontFamily: 'Arvo'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FutureBuilder(
                                        future: _database.isLiked(movie['id'],
                                            "17030696@itcelaya.edu.mx"),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<int> snapshot) {
                                          if (snapshot.data == 0) {
                                            return FloatingActionButton(
                                                backgroundColor: Colors.red,
                                                child: Icon(MdiIcons.heart
                                                    //MdiIcons.heartBroken,
                                                    ),
                                                onPressed: () {
                                                  Liked obj = Liked();
                                                  obj.idMovie = movie['id'];
                                                  obj.mailusr =
                                                      "17030696@itcelaya.edu.mx";
                                                  _database.insert('tbl_liked',
                                                      obj.toJson());
                                                  setState(() {});
                                                });
                                          } else {
                                            return FloatingActionButton(
                                                backgroundColor: Colors.red,
                                                child: Icon(
                                                  //MdiIcons.heart
                                                  MdiIcons.heartBroken,
                                                ),
                                                onPressed: () {
                                                  _database.deleteLiked(
                                                      'tbl_liked',
                                                      "17030696@itcelaya.edu.mx",
                                                      movie['id']);
                                                  setState(() {});
                                                });
                                          }
                                        }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'Arvo'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        movie['overview'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontFamily: 'Arvo'),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Cast',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'Arvo'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 200.0,
                                        child: FutureBuilder(
                                          future: apiCast.getCast(urlc),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<Cast>>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    "Has error in this request :c"),
                                              );
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              return _listCast(snapshot.data);
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _listCast(List<Cast> actors) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 5);
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Cast cast = actors[index];
        if (actors[index].knownForDepartment == "Acting") {
          return CardCast(
            cast: cast,
          );
        } else {
          return SizedBox();
        }
      },
      itemCount: actors.length,
    );
  }
}
