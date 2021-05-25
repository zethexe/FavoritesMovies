import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/userdao.dart';
import 'package:practica2/src/utils/configuration.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: FutureBuilder(
          future: _database.getUser("17030696@itcelaya.edu.mx"),
          builder: (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
            return Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Configuration.colorHeader),
                    accountName: Text(snapshot.data == null
                        ? "PRUEBA"
                        : snapshot.data.nomusr),
                    accountEmail: Text('17030696@itcelaya.edu.mx'),
                    currentAccountPicture: snapshot.data != null
                        ? ClipOval(
                            child: Image.file(File(snapshot.data.photousr),
                                fit: BoxFit.cover),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png'),
                          ),
                    onDetailsPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.trending_up,
                      color: Configuration.colorIcons,
                    ),
                    title: Text('Trending'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/popular");
                    },
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Configuration.colorIcons,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Configuration.colorIcons,
                    ),
                    title: Text('Search'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Configuration.colorIcons,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Configuration.colorIcons,
                    ),
                    title: Text('Your Favorites'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/liked");
                    },
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Configuration.colorIcons,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.contact_page,
                      color: Configuration.colorIcons,
                    ),
                    title: Text('Contact Us'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/contact");
                    },
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Configuration.colorIcons,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
