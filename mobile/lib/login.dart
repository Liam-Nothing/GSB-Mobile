import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/constants.dart';
// import 'package:mobile/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/feesheets_list.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 00,
          //   toolbarHeight: 70,
          //   title: const Center(
          //       child: Text(
          //     'Login Page',
          //     style: TextStyle(fontSize: 30),
          //   )),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: MyApp(),
        ),
      ),
    );
  }
}

void createData(String username, String password, BuildContext context) async {
  final response = await http.post(
    Uri.parse('https://api.gsb.best/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'api': 'all_open_session',
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // debugPrint(jsonDecode(response.body)["message"]);
    if (jsonDecode(response.body)["message"] == 'Good password') {
      String php_session_id = jsonDecode(response.body)["php_session_id"];
      //Automatical redirect
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Principale(
                      php_session_id: php_session_id,
                    )));
      });
    } else {
      Fluttertoast.showToast(
        msg: jsonDecode(response.body)["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        webPosition: "center",
        backgroundColor: Colors.red,
        webBgColor: "#f00",
        textColor: Colors.white,
      );
    }
  } else {
    Fluttertoast.showToast(
      msg: "Failed to create Data array.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      webPosition: "center",
      backgroundColor: Colors.red,
      webBgColor: "#f00",
      textColor: Colors.white,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset("images/logo.png", width: 160),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: buildColumn(),
        ),
      ],
    );
  }

  Form buildColumn() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
              controller: _controllerUser,
              decoration: field('Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a username please.';
                }
                return null;
              }),
          SizedBox(height: 10),
          TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: field('Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a password please.';
                }
                return null;
              }),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    createData(_controllerUser.text, _controllerPassword.text,
                        context);
                  });
                }
              },
              child: const Text('Sign in'),
            ),
          ),
        ],
      ),
    );
  }
}
