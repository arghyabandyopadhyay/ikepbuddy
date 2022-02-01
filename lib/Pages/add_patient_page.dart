import 'package:ikepbuddy/Formatters/ind_number_text_input_formatter.dart';
import 'package:ikepbuddy/Models/pair_model.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikepbuddy/Modules/universal_module.dart';

class AddPatientPage extends StatefulWidget {
  final Function(PairModel) callback;
  const AddPatientPage({Key? key, required this.callback}) : super(key: key);
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  PairModel clientData = PairModel();
  DateTime? now, today;
  var phoneNumberTextField = TextEditingController();
  var paymentNumberTextField = TextEditingController();
  var nameTextField = TextEditingController();
  var addressTextField = TextEditingController();
  var fathersNameTextField = TextEditingController();
  var educationTextField = TextEditingController();
  var occupationTextField = TextEditingController();
  var injuriesTextField = TextEditingController();
  var registrationIdTextField = TextEditingController();
  var heightTextField = TextEditingController();
  var weightTextField = TextEditingController();
  String? sexDropDown;
  String? casteDropDown;
  final IndNumberTextInputFormatter _phoneNumberFormatter =
      IndNumberTextInputFormatter();
  String? _validatePhoneNumber(String? value) {
    final phoneExp = RegExp(r'^\d\d\d\d\d\ \d\d\d\d\d$');
    if (value!.isNotEmpty && !phoneExp.hasMatch(value)) {
      return "Wrong Mobile No.!";
    } else if (value.isEmpty) {
      phoneNumberTextField.text = "";
    }
    return null;
  }

  final focus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Functions
  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      // Start validating on every change.
    } else {
      form.save();
      clientData.sex = sexDropDown;
      clientData.caste = casteDropDown;
      // try{
      // if(clientData.startDate==null)clientData.startDate=today;
      // int months=int.parse(paymentNumberTextField.text);
      // months=months.abs();
      // clientData.endDate = DateTime(clientData.startDate.year,clientData.startDate.month+months,clientData.startDate.day);
      // globalShowInSnackBar(scaffoldMessengerKey,clientData.toJson());
      widget.callback(clientData);
      Navigator.pop(context);
      // }
      // catch(E){
      //   globalShowInSnackBar(scaffoldMessengerKey,E);
      //   globalShowInSnackBar(scaffoldMessengerKey,"Please Enter No of Payments!!");
      // }
      FocusScope.of(context).unfocus();
    }
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) return "required fields can't be left empty";
    return null;
  }

  //Overrides
  @override
  void initState() {
    paymentNumberTextField.text = "1";
    now = DateTime.now();
    today = DateTime(now!.year, now!.month, now!.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 100);
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Register Client",
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/registrationId.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: registrationIdTextField,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              "Registration Id(Auto generated if left empty)",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.registrationId = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/payment.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: paymentNumberTextField,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.always,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "No of Payments(in months)",
                          contentPadding:
                              EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required fields can't be left empty";
                          } else if (value == "0") {
                            return "No of Payments cant be 0!!";
                          } else {
                            try {
                              int months = int.parse(value);
                              if (months < 0) {
                                return "No of Payments cant be Negative!!";
                              } else {
                                return null;
                              }
                            } catch (E) {
                              return "Non numeric input not allowed.";
                            }
                          }
                        },
                        onSaved: (value) {
                          try {
                            int months = int.parse(value!);
                            months = months.abs();
                            clientData.due = (months - 1) * -1;
                            clientData.startDate ??= today;
                            clientData.endDate = DateTime(
                                clientData.startDate!.year,
                                clientData.startDate!.month + months,
                                clientData.startDate!.day);
                          } catch (E) {
                            globalShowInSnackBar(scaffoldMessengerKey,
                                "Non numeric input not allowed.");
                          }
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/name.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: nameTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        validator: _validateName,
                        onSaved: (value) {
                          clientData.name = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/dad.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: fathersNameTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Father's Name",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.fathersName = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/dob.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(),
                            errorStyle: TextStyle(),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'DOB',
                            hintText: 'Date of Birth'),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        onDateSelected: (DateTime value) {
                          clientData.dob = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/doj.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(),
                            errorStyle: TextStyle(),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'DOJ',
                            hintText: 'Date of Joining'),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        onDateSelected: (DateTime value) {
                          clientData.joiningDate = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/mobile.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: phoneNumberTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Mobile",
                          contentPadding:
                              EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          clientData.mobileNo = value;
                        },
                        validator: _validatePhoneNumber,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          // Fit the validating format.
                          _phoneNumberFormatter,
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/address.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: addressTextField,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Address",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.address = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/sex.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: sexDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Sex:",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'Male',
                          'Female',
                          'Trans',
                          'Prefer not to say'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            sexDropDown = newValue;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/caste.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: casteDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Caste:",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>['General', 'OBC', 'SC/ST']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            casteDropDown = newValue;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/weight.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: weightTextField,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Weight(kg)",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            clientData.weight = double.parse(value);
                          }
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/height.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: heightTextField,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Height(cm)",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            clientData.height = double.parse(value);
                          }
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/injuries.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: injuriesTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Injuries / Medical Problems",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.injuries = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/education.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: educationTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Education",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.education = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/occupation.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: occupationTextField,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Occupation",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          clientData.occupation = value;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset(
                        'assets/date.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(),
                          errorStyle: TextStyle(),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Start Date',
                        ),
                        initialValue: today,
                        mode: DateTimeFieldPickerMode.date,
                        onDateSelected: (DateTime value) {
                          try {
                            int months = int.parse(paymentNumberTextField.text);
                            clientData.startDate = value;
                            clientData.startDate ??= today;
                            months = months.abs();
                            clientData.endDate = DateTime(
                                clientData.startDate!.year,
                                clientData.startDate!.month + months,
                                clientData.startDate!.day);
                          } catch (E) {
                            globalShowInSnackBar(scaffoldMessengerKey,
                                "Please Enter No of Payments!!");
                          }
                        },
                      ),
                    ),
                  ]),
                  sizedBoxSpace,
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "registerClientsAddPatientPageHeroTag",
          icon: const Icon(Icons.person_add),
          label: const Text(
            "Register",
          ),
          onPressed: _handleSubmitted,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
      key: scaffoldMessengerKey,
    );
  }
}
