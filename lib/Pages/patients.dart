import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikepbuddy/Models/pair_model.dart';

import 'add_patient_page.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  void newPairModel(PairModel pairModel) {
    // print(pairModel.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => AddPatientPage(callback: newPairModel)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
