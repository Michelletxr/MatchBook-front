import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:match_book_front/models/Book.dart';
import 'dart:async';
import 'dart:convert';

class DetailBook extends StatefulWidget {
  final Book _book;
  const DetailBook(this._book, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailBook> {
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
                      widget._book.imageLinks['smallThumbnail'],
                      fit: BoxFit.contain,
                      height: 300,
                      width: 500,
                    )
                  : const Icon(Icons.menu_book_outlined),
            ))),
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
                              )),
                        )),
                        /* SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(_getAuthor(widget._book.author),
                              softWrap: false,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                              )),
                        ))*/
                      ],
                    )),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        SaveBook(widget._book);
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
                height: 300,
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

Future SaveBook(Book book) async {
  print(book.name);
  var ip = '192.168.100.22';
  var urlRequest = 'http://${ip}:8000/api/book/books/';
  final response = await http.post(
    Uri.parse(urlRequest),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'X-CSRFToken':
          'GwwBa7cBRrPzJ2B3Dhg1JCXd1hEYvscDRI36icu5KH70XO95sUdbjyWx5OUYElBA',
    },
    body: jsonEncode(<String, String>{
      'name': book.name,
      'user': "c2d98b61-0d1d-41ab-8295-487685f02695",
      'author': _getAuthor(book.author),
      'lauch_date': "2022-12-02T20:39:39.511Z",
      'sinopse': _getDescription(book.sinopse)
    }),
  );
}
