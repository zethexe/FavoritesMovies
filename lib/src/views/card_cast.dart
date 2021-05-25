import 'package:flutter/material.dart';
import 'package:practica2/src/models/castdao.dart';

class CardCast extends StatelessWidget {
  const CardCast({Key key, @required this.cast}) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    final img = cast.profilePath == null
        ? CircleAvatar(
            backgroundImage: NetworkImage(
                "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg"),
            radius: 30.0,
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(
                "https://image.tmdb.org/t/p/w500" + cast.profilePath),
            radius: 30.0,
          );
    return (Column(
      children: [
        img,
        SizedBox(
          height: 2,
        ),
        Text(
          cast.name,
          style: TextStyle(
              color: Colors.white, fontSize: 10.0, fontFamily: 'Arvo'),
        )
      ],
    ));
  }
}
