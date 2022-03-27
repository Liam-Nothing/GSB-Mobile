import 'package:flutter/services.dart';
import 'constants.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';

class Feesheets extends StatefulWidget {
  @override
  State<Feesheets> createState() => _FeesheetsState();
}

class _FeesheetsState extends State<Feesheets> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Container(
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
              icon: Icon(Icons.home),
            )
          ],
          title: Center(
              child: Text(
            'Nouvelle note de frais',
            style: kTitreLabelP,
          )),
        ),
        body: Center(child: FeesheetsForm()),
      ),
    );
  }
}

class FeesheetsForm extends StatefulWidget {
  const FeesheetsForm({Key? key}) : super(key: key);

  @override
  _FeesheetsFormState createState() => _FeesheetsFormState();
}

class _FeesheetsFormState extends State<FeesheetsForm> {
  final _feesheetsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: field('Fee'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer les frais";
                  } else
                    return null;
                },
              ),
              SizedBox(height: 30),
              DateTimeFormField(
                  decoration: field("Date d'émission"),
                  dateFormat: DateFormat('dd/MM/yyyy'),
                  mode: DateTimeFieldPickerMode.date,
                  firstDate: DateTime(DateTime.now().year - 10),
                  lastDate: DateTime(DateTime.now().year + 2),
                  validator: (DateTime? value) {
                    if (value == null) {
                      value = DateTime.now();
                    } else
                      return null;
                  }),
              SizedBox(height: 30),
              TextFormField(
                decoration: field("Description"),
                maxLines: 2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer la description";
                  } else
                    return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: field("Standard fee"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez choisir les frais standard";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_feesheetsFormKey.currentState!.validate()) {
                      // Process data.
                      print('tout va bien');
                    }
                  },
                  child: Text('Submit')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    if (_feesheetsFormKey.currentState!.validate()) {
                      // Process data.
                      print('tout va bien');
                    }
                  },
                  child: Text('brouillon'))
            ],
          ),
        ),
        key: _feesheetsFormKey,
      ),
    );
  }
}