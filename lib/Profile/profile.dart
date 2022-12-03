import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    this.color = Colors.white,
    this.child,
  });

  final Color color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: color,
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
                  child: Image.asset(
                    "imagens/foto-perfil.jpg",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              // ignore: prefer_const_constructors
              Container(
                child: Text(
                  "Rodrigo Antunes",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      decoration: TextDecoration.none),
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
