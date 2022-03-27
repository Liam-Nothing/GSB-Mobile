// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile/login.dart';
import 'package:lottie/lottie.dart';
import 'constants.dart';
import 'notes_de_frais.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: new Login()),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const Login(),
        '/connected': (context) => Principale()
      },
    ),
  );
}

class Principale extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Principale({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        title: const Text(
          'Notes de frais',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/67210-writing-blue-bg.json',
                  frameRate: FrameRate(30)),
              const Text(
                'Créer une note de frais',
                style: kTitreLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
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
            page: Principale(),
            text: 'Mes notes de frais en cours',
            asset: 'assets/images/pen.json'),
        module(
            page: Principale(),
            text: 'Notes de frais archivées',
            asset: 'assets/images/dossier.json'),
      ],
    ));
  }
}