import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:match_book_front/constants.dart';
import 'package:match_book_front/models/Book.dart';
import 'dart:async';
import 'dart:convert';
import 'package:match_book_front/Global/globals.dart' as globals;

import '../Profile/profile.dart';

class DetailBook extends StatefulWidget {
  final Book _book;
  const DetailBook(this._book, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailBook> {
  bool save = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topLeft,
          child: const BackButton(color: Colors.blue),
        ),
        Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 1, 1),
            child: Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: widget._book.imageLinks != null
                        ? Image.network(
                            _getImageLinks(widget._book.imageLinks),
                            fit: BoxFit.contain,
                            height: 200,
                            width: 300,
                          )
                        : Image.asset(
                            "imagens/not_found_book.webp",
                            fit: BoxFit.contain,
                            height: 200,
                            width: 300,
                          )))),
        Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10),
            width: double.infinity,
            height: 100,
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          width: 200,
                          height: 20,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(widget._book.name,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        )),
                      ],
                    )),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await SaveBook(widget._book);
                        if (save) {
                          showSuccessMessage(context);
                        }
                      },
                      icon: const Icon(Icons.add_box_outlined),
                      label: const Text("Adicionar"),
                    )),
              ],
            )),
        const Divider(
          height: 5,
          thickness: 2,
          indent: 30,
          endIndent: 30,
          color: Colors.blueAccent,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Container(
                height: 200,
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(_getDescription(widget._book.sinopse),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 15)),
                  ),
                )))
      ]),
    );
  }

  Future SaveBook(Book book) async {
    print(book);
    var urlRequest = 'https://match-book.up.railway.app/api/book/books/';
    // print(globals.id);
    final response = await http.post(
      Uri.parse(urlRequest),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'name': book.name,
        'user': globals.id,
        'author': _getAuthor(book.author),
        'lauch_date': "2022-12-02T20:39:39.511Z",
        'sinopse': _getDescription(book.sinopse),
        'imageLinks': _getImageLinks(book.imageLinks)
      }),
    );
    if (response.statusCode == 201) {
      save = true;
    }
  }
}

void showSuccessMessage(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text("Livro adicionado com sucesso"),
    ),
  );
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Profile()),
  );
}

String _getDescription(descri) {
  String msg = "Não há descrição";
  if (descri != null) {
    msg = descri;
  }
  return msg;
}

String _getAuthor(author) {
  String msg = '';
  if (author != null) {
    msg = author[0];
  }
  return msg;
}

String _getImageLinks(image) {
  String msg = '';
  if (image != null) {
    msg = image['smallThumbnail'];
  }
  return msg;
}
