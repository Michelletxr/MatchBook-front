import 'package:flutter/material.dart';
import 'package:match_book_front/Login/login.dart';
import 'package:match_book_front/Register/register.dart';
import 'package:match_book_front/Profile/profile.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    title: "Match book",
    // home: Login(),
    home: Profile(
      child: null,
    ),
  ));
}
