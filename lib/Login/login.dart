import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:match_book_front/Home/Home.dart';
import 'dart:async';
import 'dart:convert';

import 'package:match_book_front/Login/login.dart';
import 'package:match_book_front/Register/register.dart';

const request = "https://match-book.up.railway.app/api/authentication/";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _resetCampos() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ], //<Widget>[]
      ), // app bar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.circle, size: 120, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    icon: Icon(Icons.person)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: emailController,
              ),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    icon: Icon(Icons.lock)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: passwordController,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 50.0,
                          width: 90,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // _calcular();
                                loginUser(emailController.text,
                                    passwordController.text, context);
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    EdgeInsets.fromLTRB(50.0, 3.0, 10.0, 3.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()
                                        //Aqui irei colocar a página de register
                                        ));
                              },
                              child: Text("Registra-se")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()
                                        //Aqui irei colocar a página de register
                                        ));
                              },
                              child: Text("Esqueceu a senha?"))
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Future loginUser(String username, String password, BuildContext context) async {
  final response = await http.post(
    Uri.parse('${request}login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  } else {
    print(response.statusCode);
    print('data: NUM DEU BOM');
  }
}
