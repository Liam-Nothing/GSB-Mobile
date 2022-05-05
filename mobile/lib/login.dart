import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Center(
              child: Text(
            'Login Page',
            style: TextStyle(fontSize: 30),
          )),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: MyApp(),
        ),
      ),
    );
  }
}

Future<Data> createData(
    String username, String password, BuildContext context) async {
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
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return Data.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create Data array.');
  }
}

class Data {
  final int id;
  final String message;

  const Data({required this.id, required this.message});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      message: json['message'],
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
  Future<Data>? _futureData;

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
          child: (_futureData == null) ? buildColumn() : buildFutureBuilder(),
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
              decoration: field('Utilisateur'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom d\'utilisateur';
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
                  return 'Veuillez entrer un mot de passe correct';
                }
                return null;
              }),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _futureData = createData(_controllerUser.text,
                        _controllerPassword.text, context);
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

  FutureBuilder<Data> buildFutureBuilder() {
    return FutureBuilder<Data>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.message == 'Good password') {
            //Automatical redirect
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Principale()));
            });
          } else {
            return Column(
              children: [
                Text('Bad User or Password'),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Go back'),
                  ),
                ),
              ],
            );
          }

          return Text(snapshot.data!.message);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
/* class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
	return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
	// Build a Form widget using the _formKey created above.
	return Form(
	  key: _formKey,
	  child: Center(
		child: Column(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [
			const Padding(
			  padding: EdgeInsets.all(20.0),
			  child: Text(
				'Se connecter',
				style: kTitreLogin,
			  ),
			),
			TextFormField(
			  decoration: const InputDecoration(
				  border: OutlineInputBorder(),
				  labelText: 'Username',
				  isDense: true,
				  constraints: BoxConstraints(maxWidth: 500)),
			  validator: (value) {
				if (value == null || value.isEmpty) {
				  return 'Please enter your Username';
				}
				return null;
			  },
			),
			const SizedBox(
			  height: 25,
			),
			TextFormField(
			  obscureText: true,
			  decoration: const InputDecoration(
				  border: OutlineInputBorder(),
				  labelText: 'Password',
				  constraints: BoxConstraints(maxWidth: 500)),
			  // The validator receives the text that the user has entered.

			  validator: (value) {
				if (value == null || value.isEmpty) {
				  return 'Please enter a password';
				}
				return null;
			  },
			),
			Padding(
			  padding: const EdgeInsets.symmetric(vertical: 16.0),
			  child: ElevatedButton(
				onPressed: () {
				  // Validate returns true if the form is valid, or false otherwise.
				  if (_formKey.currentState!.validate()) {
					// If the form is valid, display a snackbar. In the real world,
					// you'd often call a server or save the information in a database

					Navigator.push(context,
						MaterialPageRoute(builder: (context) => Principale()));
				  }
				},
				child: const Text('Submit'),
			  ),
			),
		  ],
		),
	  ),
	);
  }
} */
