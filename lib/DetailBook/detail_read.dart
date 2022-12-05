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
                        )),
            )),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        )),
                        Expanded(
                            child: Container(
                          width: 200,
                          height: 20,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(_getAuthor(widget._book.author),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              )),
                        )),
                      ],
                    )),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(right: 25, top: 10),
                  child: Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                )
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
}

String _getImageLinks(image) {
  String msg = '';
  if (image != null) {
    print(image.runtimeType);
    if (image is String) {
      msg = image;
    } else {
      msg = image['smallThumbnail'];
    }
  }
  return msg;
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
