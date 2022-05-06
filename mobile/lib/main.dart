// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/login.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/notes_de_frais.dart';
import 'package:mobile/feesheets_list.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = new FlutterSecureStorage();

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: new Login()),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const Login(),
        '/connected': (context) => Principale(php_session_id: 'none')
      },
    ),
  );
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        module(
            page: Principale(php_session_id: 'none'),
            text: 'Mes notes de frais en cours',
            asset: 'assets/images/pen.json'),
        module(
            page: Principale(php_session_id: 'none'),
            text: 'Notes de frais archivées',
            asset: 'assets/images/dossier.json'),
      ],
    ));
  }
}
