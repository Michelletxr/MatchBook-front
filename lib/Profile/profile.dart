import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:match_book_front/constants.dart';

import 'package:match_book_front/RegisterBook/registerBook.dart';
import 'package:match_book_front/models/Book.dart';
import 'package:match_book_front/DetailBook/detail_read.dart';

import 'package:match_book_front/Global/globals.dart' as globals;

import '../Home/Home.dart';

const request = "https://match-book.up.railway.app/api/authentication/";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String name = "";
  late String? imageURL = null;

  @override
  void initState() {
    super.initState();
    getUser(globals.id).then((value) {
      final Response test = value;
      final te = json.decode(test.body);
      final image = te["profile_image"];
      getBooks();
      setState(() {
        name = te["first_name"] + " " + te["last_name"];
        imageURL = image == null ? null : image['url'];
      });
    });
  }

  List<Book> booksList = [];
  final ScrollController _scrollController = ScrollController();

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
                      : Image.network(
                          imageURL!,
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // ignore: prefer_const_constructors
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        decoration: TextDecoration.none),
                  ),
                ),
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
                      '100 Livros',
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
                  child: Center(
                    child: Text(
                      "Meus Livros",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          decoration: TextDecoration.none),
                    ),
                  )),

              Flexible(
                  child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: booksList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailBook(booksList[index])))
                          },
                      child: Card(
                        child: booksList[index].imageLinks != null
                            ? Image.network(
                                booksList[index].imageLinks,
                                fit: BoxFit.contain,
                                height: 300,
                                width: 300,
                              )
                            : Image.asset(
                                "imagens/not_found_book.webp",
                                fit: BoxFit.contain,
                                height: 300,
                                width: 300,
                              ),
                      ));
                },
              )),
              IconButton(
                  padding: EdgeInsets.only(top: 10),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterBook()));
                  },
                  icon: Icon(Icons.add),
                  color: Colors.grey)
            ],
          )),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                icon: Icon(Icons.home),
                color: Colors.grey),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.search), color: Colors.grey),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                icon: Icon(Icons.account_box_rounded),
                color: Colors.grey),
          ],
        ));
  }

  Future getBooks() async {
    var urlRequest = '${bookURL}user-books/${globals.id}';
    final response = await http.get(
      Uri.parse(urlRequest),
    );
    if (response.statusCode == 200) {
      List<Book> books = [];
      LinkedHashMap<String, dynamic> list = json.decode(response.body);
      list['results']
          .forEach((element) => {books.add(Book.fromJsonApi(element))});
      setState(() {
        booksList = books;
      });
    }
  }
}

String _getImageLinks(image) {
  String msg = '';
  if (image != null) {
    msg = image['smallThumbnail'];
  }
  return msg;
}

Future getUser(String id) async {
  final response = await http.get(
    Uri.parse('${baseURL}users/$id'),
  );

  return response;
}
