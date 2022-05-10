import 'package:flutter/services.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Feesheets extends StatefulWidget {
  final String php_session_id;

  // receive data from the FirstScreen as a parameter
  Feesheets({Key? key, required this.php_session_id}) : super(key: key);

  @override
  State<Feesheets> createState() => _FeesheetsState();
}

class _FeesheetsState extends State<Feesheets> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text('New feesheets'),
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
