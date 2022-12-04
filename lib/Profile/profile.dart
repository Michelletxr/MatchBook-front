import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_book_front/RegisterBook/registerBook.dart';
import 'package:match_book_front/models/Book.dart';
import 'package:match_book_front/DetailBook/detail.dart';

import '../Home/Home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState({
    this.color = Colors.white,
    this.child,
  });

  List<Book> booksList = [];
  final Color color;
  final Widget? child;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    print("vou carregar");
    getBooks();
  }

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
                children: <Widget>[
                  _createListView(),
                ],
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

  Widget _createListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: booksList == null ? 0 : booksList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: booksList[index].imageLinks != '1'
                  ? Image.network(booksList[index].imageLinks)
                  : Icon(Icons.menu_book_outlined));
        });
  }

  Future getBooks() async {
    var ip = '192.168.100.22';
    var urlRequest =
        'http://${ip}:8000/api/book/user-books/${'c2d98b61-0d1d-41ab-8295-487685f02695'}';
    final response = await http.get(
      Uri.parse(urlRequest),
    );
    if (response.statusCode == 200) {
      List<Book> books = [];
      LinkedHashMap<String, dynamic> list = json.decode(response.body);
      list['results']
          .forEach((element) => {books.add(Book.fromJsonApi(element))});
      books.forEach((element) {
        print(element.name);
      });
      setState(() {
        booksList = books;
      });
    }
  }
}
