import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/login.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/notes_de_frais.dart';
import 'package:mobile/feesheets_list.dart';
import 'package:mobile/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Principale extends StatelessWidget {
  final String php_session_id;

  // receive data from the FirstScreen as a parameter
  Principale({Key? key, required this.php_session_id}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //php_session_id print
    debugPrint('Key is : ' + php_session_id);

    return Scaffold(
      drawer: const SizedBox(
        width: 500,
        child: Drawer(
          child: DrawerContent(),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {
              Logout(php_session_id, context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        title: Text(
          'Feesheets',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Feesheets()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(6)),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Table !'),
          ),
        ),
      ),
    );
  }
}

void Logout(String php_session_id, BuildContext context) async {
  final response = await http.post(
    Uri.parse('https://api.gsb.best/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'api': 'all_logout_session',
      'php_session_id': php_session_id
    }),
  );

  if (response.statusCode != 200) {
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
  } else {
    debugPrint(response.body);
  }
}
