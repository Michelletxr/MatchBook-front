import 'package:match_book_front/Global/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:match_book_front/Profile/profile.dart';
import 'package:match_book_front/Global/globals.dart' as globals;
import 'dart:async';
import 'dart:convert';

import '../DetailBook/detail_read.dart';
import '../constants.dart';
import '../models/Book.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> booksList = [];

  initState() {
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 140.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 30.0,
                          child: ClipRRect(
                            child: globals.imgUrl == null
                                ? Image.asset(
                                    "imagens/foto-perfil.jpg",
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    globals.imgUrl!,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.circular(100.0),
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        globals.fullname,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Livros',
                  style: TextStyle(
                    color: Color(0xFFB0BEC5),
                  ),
                ),
                leading: Icon(Icons.book),
                enabled: false,
                tileColor: Color(0xFFECEFF1),
                onTap: () {},
              ),
              ListTile(
                title: Text('Meus Livros'),
                leading: Icon(Icons.menu_book),
                onTap: () {},
              ),
              ListTile(
                title: Text('Livros Desejados'),
                leading: Icon(Icons.bookmark),
                onTap: () {},
              ),
              ListTile(
                title: Text('Empréstimos'),
                leading: Icon(Icons.people_alt),
                onTap: () {},
              ),
              ListTile(
                title: Text('Conta',
                    style: TextStyle(
                      color: Color(0xFFB0BEC5),
                    )),
                tileColor: Color(0xFFECEFF1),
                leading: Icon(Icons.person),
                enabled: false,
                onTap: () {},
              ),
              ListTile(
                title: Text('Configurações'),
                leading: Icon(Icons.settings),
                onTap: () {},
              ),
              ListTile(
                title: Text('Segurança'),
                leading: Icon(Icons.security),
                onTap: () {},
              ),
              ListTile(
                title: Text('Ajuda'),
                leading: Icon(Icons.help),
                onTap: () {},
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Livros perto de você",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverAppBar(
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Transform.translate(
                    offset: const Offset(0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Filtrar por",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                  value: "Localização",
                                  items: <DropdownMenuItem<String>>[
                                    DropdownMenuItem(
                                        child: Text("Localização"),
                                        value: "Localização"),
                                    DropdownMenuItem(
                                        child: Text("Natal"), value: "Natal"),
                                    DropdownMenuItem(
                                        child: Text("Parnamirim"),
                                        value: "Parnamirim"),
                                    DropdownMenuItem(
                                        child: Text("Mossoró"),
                                        value: "Mossoró"),
                                  ],
                                  onChanged: (String? lugar) {
                                    print("lugar");
                                  }),
                              DropdownButton(
                                  value: "Gênero",
                                  items: <DropdownMenuItem<String>>[
                                    DropdownMenuItem(
                                        child: Text("Gênero"), value: "Gênero"),
                                    DropdownMenuItem(
                                        child: Text("Romance"),
                                        value: "Romance"),
                                    DropdownMenuItem(
                                        child: Text("Terror"), value: "Terror"),
                                    DropdownMenuItem(
                                        child: Text("Auto-Ajuda"),
                                        value: "Auto-Ajuda"),
                                    DropdownMenuItem(
                                        child: Text("Ficção-Científica"),
                                        value: "Ficcao-c"),
                                    DropdownMenuItem(
                                        child: Text("Drama"), value: "Drama"),
                                    DropdownMenuItem(
                                        child: Text("Fantasia"),
                                        value: "Fantasia"),
                                    DropdownMenuItem(
                                        child: Text("Literatura Brasileira"),
                                        value: "Literatura Brasileira"),
                                  ],
                                  onChanged: (String? lugar) {
                                    print("lugar");
                                  }),
                            ],
                          )
                        ]),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailBook(booksList[index])))
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: booksList[index].imageLinks != null
                          ? Image.network(
                              _getImageLinks(booksList[index].imageLinks))
                          : Image.asset("/imagens/not_found_book.webp"),
                    ),
                  );
                },
                childCount: booksList.length,
              ),
            )
          ],
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
    var urlRequest = '${bookURL}books-api/user/1';
    final response = await http.get(
      Uri.parse(urlRequest),
    );
    if (response.statusCode == 200) {
      List<Book> books = [];
      List<dynamic> list = json.decode(response.body);
      list.forEach((element) => {books.add(Book.fromJson(element))});
      setState(() {
        booksList = books;
      });
    }
  }

  String _getImageLinks(image) {
    String msg = '';
    if (image != null) {
      msg = image['smallThumbnail'];
    }
    return msg;
  }
}
