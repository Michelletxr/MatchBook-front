import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:match_book_front/constants.dart';

const request = "https://match-book.up.railway.app/api/authentication/";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // late String text;

  late String name = "";
  late String? imageURL = null;

  @override
  void initState() {
    super.initState();
    getUser("ccb1d7c6-24f9-4801-876d-c613035adca6").then((value) {
      final Response test = value;
      final te = json.decode(test.body);

      setState(() {
        name = te["first_name"] + " " + te["last_name"];
        imageURL = te["profile_image"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              // ignore: prefer_const_constructors
              CircleAvatar(
                radius: 70.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: imageURL == null
                      ? Image.asset(
                          "imagens/foto-perfil.jpg",
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(imageURL!),
                ),
              ),
              // ignore: prefer_const_constructors
              Container(
                child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        decoration: TextDecoration.none),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 20.0),
              ),
              Divider(
                color: Colors.black54,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text(
                      "100 Livros",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      "25 Amigos",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black54,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 110.0, vertical: 20.0),
                child: Text(
                  "Meus Livros",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      decoration: TextDecoration.none),
                ),
              ),

              Flexible(
                  // ignore: unnecessary_new
                  child: new GridView.count(
                //childAspectRatio: 3 / 2,
                crossAxisCount: 4,
                crossAxisSpacing: sqrt1_2,
                padding: EdgeInsets.all(4.0),
                children: const <Widget>[
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  ),
                  Image(
                    image: AssetImage('imagens/capa.jpg'),
                  )
                ],
              )),
            ],
          )),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {}, icon: Icon(Icons.home), color: Colors.grey),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.search), color: Colors.grey),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_box_rounded),
                color: Colors.grey)
          ],
        ));
  }
}

Future getUser(String id) async {
  final response = await http.get(
    Uri.parse('${baseURL}users/${id}'),
  );

  return response;
}
