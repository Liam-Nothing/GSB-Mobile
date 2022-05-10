// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:mobile/feesheets_list.dart';
import 'package:mobile/add_feesheet.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = new FlutterSecureStorage();

void main() async {
  runApp(
    MaterialApp(
      home: SafeArea(child: new Login()),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const Login(),
        '/connected': (context) => Principale(php_session_id: 'none'),
        '/feesheet': (context) => Feesheets(php_session_id: 'none')
      },
    ),
  );
}
