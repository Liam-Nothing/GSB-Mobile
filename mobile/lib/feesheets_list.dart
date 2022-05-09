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
import 'package:json_table/json_table.dart';

class Principale extends StatelessWidget {
  final String php_session_id;

  // receive data from the FirstScreen as a parameter
  Principale({Key? key, required this.php_session_id}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //php_session_id print
    debugPrint('Key is : ' + php_session_id);

    final String jsonSample = '[{"id":1},{"id":2}]';

    var json = jsonDecode(jsonSample);
    // var json = (GetFeesheets(php_session_id));
    // debugPrint(jsonSample);

    var TEST_VAR_PHDFG = fetch(php_session_id);

    print(TEST_VAR_PHDFG);
    print("====>");
    print(TEST_VAR_PHDFG);

    return Scaffold(
      drawer: SizedBox(
        width: 500,
        child: Drawer(
          child: DrawerContent(
            php_session_id: php_session_id,
          ),
        ),
      ),
      appBar: AppBar(
          toolbarHeight: 70,
          actions: [
            IconButton(
              onPressed: () {
                Logout(php_session_id, context);
              },
              icon: const Icon(Icons.logout_rounded),
            )
          ],
          title: const Text('Feesheets')),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(6)),
          ),
          JsonTable(json),
        ],

        // child: ElevatedButton(
        //   onPressed: () {
        //     GetFeesheets(php_session_id, context);
        //   },
        //   child: const Text('Table !'),
        // ),
      ),
    );
  }
}

Future<String> fetch(String php_session_id) async {
  final response = await http.post(
    Uri.parse('https://api.gsb.best/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'api': 'multi_view_all_feesheets',
      'php_session_id': php_session_id
    }),
  );

  String TEST_VAR_DSFGD = response.body;
  print(TEST_VAR_DSFGD);
  return TEST_VAR_DSFGD;
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
      msg: "Failed request...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      webPosition: "center",
      backgroundColor: Colors.red,
      webBgColor: "#f00",
      textColor: Colors.white,
    );
  } else {
    Navigator.pop(context);
    debugPrint(response.body);
  }
}

Future<String> GetFeesheets(String php_session_id) async {
  final response = await http.post(
    Uri.parse('https://api.gsb.best/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'api': 'multi_view_all_feesheets',
      'php_session_id': php_session_id
    }),
  );

  if (response.statusCode != 200) {
    Fluttertoast.showToast(
      msg: "Failed request...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      webPosition: "center",
      backgroundColor: Colors.red,
      webBgColor: "#f00",
      textColor: Colors.white,
    );
  } else {
    return await response.body;
  }

  return await "error";
}

class DrawerContent extends StatelessWidget {
  final String php_session_id;

  // receive data from the FirstScreen as a parameter
  DrawerContent({Key? key, required this.php_session_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/logo0.png'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('New Feesheets'),
            onTap: () =>
                {Logout(php_session_id, context), Navigator.pop(context)},
          ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }
}
