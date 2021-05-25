import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/userdao.dart';
import 'dart:io';

import 'package:practica2/src/screens/dashboard.dart';
import 'package:sqflite/sqflite.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();

  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtNumber = TextEditingController();

  DatabaseHelper _database;

  final picker = ImagePicker();

  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final imgFinal = imagePath == ""
        ? CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png"),
            radius: 90.0,
          )
        : CircleAvatar(
            backgroundImage: FileImage(File(imagePath)),
            radius: 90.0,
          );

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.blueGrey])),
                child: Container(
                  width: double.infinity,
                  height: 250.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        imgFinal,
                        SizedBox(
                          height: 5.0,
                        ),
                        FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          // Provide an onPressed callback.
                          onPressed: () async {
                            final file = await picker.getImage(
                                source: ImageSource.camera);
                            imagePath = file.path;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Username",
                      style: TextStyle(color: Colors.blue, fontSize: 28.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: txtName,
                      //initialValue: 'Zeth Alux',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Phone number",
                      style: TextStyle(color: Colors.blue, fontSize: 28.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: txtNumber,
                      // initialValue: '4645793708',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "User email",
                      style: TextStyle(color: Colors.blue, fontSize: 28.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: txtEmail,
                      //initialValue: '17030696@itcelaya.edu.mx',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        UserDAO objUSER = UserDAO(
                            nomusr: txtName.text,
                            mailusr: txtEmail.text,
                            telusr: txtNumber.text,
                            photousr: imagePath);

                        _database.insert('tbl_perfil', objUSER.toJSON());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Dashboard()),
                            ModalRoute.withName('/dashboard'));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.blue, Colors.blueGrey]),
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: 100.0,
                            maxHeight: 40.0,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
