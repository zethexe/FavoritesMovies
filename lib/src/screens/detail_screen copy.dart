import 'package:flutter/material.dart';
import 'package:practica2/src/models/trailerdao.dart';
import 'package:practica2/src/network/api_trailers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiTrailer apiTrailer;

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
  }

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    var urlt = "https://api.themoviedb.org/3/movie/" +
        movie['id'].toString() +
        "/trailers?api_key=18f513131c9ae8a7178ae6e877808b72";

    return Stack(
      children: [
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
                body: Column(
                  children: [
                    YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: snapshot.data[0].source,
                        flags: YoutubePlayerFlags(
                          autoPlay: true,
                          mute: false,
                        ),
                      ),
                      liveUIColor: Colors.amber,
                    ),
                    Text("Holaaaaaa"),
                  ],
                ),
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
}
