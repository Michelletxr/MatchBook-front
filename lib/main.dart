import 'package:flutter/material.dart';
import 'package:match_book_front/Home/Home.dart';
import 'package:match_book_front/Login/login.dart';
import 'package:match_book_front/Profile/profile.dart';
import 'package:match_book_front/Register/register.dart';
import 'package:match_book_front/RegisterBook/registerBook.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    title: "Match book",
    home: Login(),
  ));
}
