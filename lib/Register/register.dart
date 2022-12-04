import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

import 'package:match_book_front/Login/login.dart';
import "package:match_book_front/Home/Home.dart";
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';

import 'package:match_book_front/Global/globals.dart' as globals;
import 'package:jwt_decoder/jwt_decoder.dart';

const request = "https://match-book.up.railway.app/api/authentication/";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  XFile? profileImage;
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
    profileImage = XFile('');
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    height: 120.0,
                    width: 120.0,
                    child: profileImage == null
                        ? const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                            size: 120,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.file(
                              File(profileImage!.path),
                              width: 150.0,
                              height: 150.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 77,
                    right: 115,
                    child: Align(
                      child: FloatingActionButton.small(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          try {
                            XFile? file = await picker.pickImage(
                                source: ImageSource.gallery);

                            if (file != null) {
                              setState(() => profileImage = file);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        backgroundColor: Colors.blueAccent,
                        elevation: 2,
                        child: profileImage == null
                            ? const Icon(Icons.add_circle)
                            : const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
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
                            passwordController.text, profileImage, context);
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

Future registerUser(String fullname, String username, String password, XFile? profileImage, BuildContext context) async {
  ph.PermissionStatus permission = await ph.Permission.location.request();
  if (permission.isDenied) {
    print("Sem permissão");
    return;
  }

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    print("Serviço de localização desabilitado");
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  String first_name = fullname.split(" ")[0];
  String last_name = '';

  if (fullname.split(" ").length > 1) {
    last_name = fullname.split(" ")[1];
  }

  final response = await http.post(
    Uri.parse('${request}users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name': first_name,
      'last_name': last_name != '' ? last_name : '',
      'email': username,
      'password': password,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
    }),
  );

  if (response.statusCode >= 400) {
    print('status code: ${response.statusCode}');
    print(response.body);
    return;
  }

  if (profileImage == null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    return;
  }

  final response_login = await http.post(
    Uri.parse('${request}login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': username,
      'password': password,
    }),
  );

  if (response_login.statusCode >= 400) {
    print('status code: ${response_login.statusCode}');
    print(response_login.body);
    return;
  }

  String accessToken = jsonDecode(response_login.body)['access'];
  globals.accessToken = accessToken;
  globals.id = jsonDecode(response_login.body)['user_id'];
  Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};

  var image_request =
      http.MultipartRequest('PUT', Uri.parse('${request}image/'));
  image_request.files.add(http.MultipartFile.fromBytes(
      'image', File(profileImage!.path).readAsBytesSync(),
      filename: profileImage!.path));
  image_request.headers.addAll(headers);

  var res = await image_request.send();

  if (res.statusCode >= 400) {
    print('status code: ${res.statusCode}');
    print(res.reasonPhrase);
    print(await res.stream.bytesToString());
    return;
  }

  final getUserResponse = await http.get(Uri.parse('${request}users/${globals.id}/'));

  globals.imgUrl = jsonDecode(getUserResponse.body)['profile_image']['url'];
  globals.fullname = jsonDecode(getUserResponse.body)['first_name'] + " " + jsonDecode(getUserResponse.body)['last_name'];

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
  );
}
