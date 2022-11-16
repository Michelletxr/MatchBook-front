import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:match_book_front/Login/login.dart';
import "package:match_book_front/Home/Home.dart";

const request = "http://127.0.0.1:8000/api/authentication/";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController localizationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    localizationController = TextEditingController();
    passwordController = TextEditingController();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.circle, size: 120, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: "Nome completo",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    icon: Icon(Icons.person)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: nameController,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    icon: Icon(Icons.email)),
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
                  icon: Icon(Icons.lock),
                ),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: passwordController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50.0,
                  width: 20.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _calcular();
                        registerUser(nameController.text, emailController.text,
                            passwordController.text, context);
                      }
                    },
                    child: const Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future registerUser(String fullname, String username, String password,
    BuildContext context) async {
  final response = await http.post(
    Uri.parse('${request}register/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'fullname': fullname,
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print('data: DEU BOM');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  } else {
    print('data: NUM DEU BOM');
  }
}
