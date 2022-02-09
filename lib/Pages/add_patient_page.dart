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
  PairModel pairData = PairModel();
  DateTime? now, today;
  var phoneNumberTextField = TextEditingController();
  var donorPhoneNumberTextField = TextEditingController();
  var nameTextField = TextEditingController();
  var donorNameTextField = TextEditingController();
  var addressTextField = TextEditingController();
  var donorAddressTextField = TextEditingController();
  var registrationIdTextField = TextEditingController();
  var heightTextField = TextEditingController();
  var donorHeightTextField = TextEditingController();
  String? sexPatientDropDown;
  String? sexDonorDropDown;
  String? bloodGroupPatientDropDown;
  String? bloodGroupDonorDropDown;
  String? hlaPatient1DropDown;
  String? hlaPatient2DropDown;
  String? hlaPatient3DropDown;
  String? hlaPatient4DropDown;
  String? hlaPatient5DropDown;
  String? hlaPatient6DropDown;
  String? hlaDonor1DropDown;
  String? hlaDonor2DropDown;
  String? hlaDonor3DropDown;
  String? hlaDonor4DropDown;
  String? hlaDonor5DropDown;
  String? hlaDonor6DropDown;
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
      pairData.gender = sexPatientDropDown;
      pairData.dGender = sexDonorDropDown;
      pairData.sd = casteDropDown;
      pairData.h = [];
      pairData.h!.add(hlaPatient1DropDown!);
      pairData.h!.add(hlaPatient2DropDown!);
      pairData.h!.add(hlaPatient3DropDown!);
      pairData.h!.add(hlaPatient4DropDown!);
      pairData.h!.add(hlaPatient5DropDown!);
      pairData.h!.add(hlaPatient6DropDown!);
      pairData.dH = [];
      pairData.dH!.add(hlaDonor1DropDown!);
      pairData.dH!.add(hlaDonor2DropDown!);
      pairData.dH!.add(hlaDonor3DropDown!);
      pairData.dH!.add(hlaDonor4DropDown!);
      pairData.dH!.add(hlaDonor5DropDown!);
      pairData.h!.add(hlaDonor6DropDown!);
      // try{
      // if(pairData.startDate==null)pairData.startDate=today;
      // int months=int.parse(paymentNumberTextField.text);
      // months=months.abs();
      // pairData.endDate = DateTime(pairData.startDate.year,pairData.startDate.month+months,pairData.startDate.day);
      // globalShowInSnackBar(scaffoldMessengerKey,pairData.toJson());
      widget.callback(pairData);
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Patient Details:"),
                  ),
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
                          pairData.name = value;
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
                        value: bloodGroupPatientDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Blood Group:",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'A+',
                          'B+',
                          'AB+',
                          'O+',
                          'A-',
                          'B-',
                          'AB-',
                          'O-'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            bloodGroupPatientDropDown = newValue;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA1:'),
                        DropdownButton(
                          value: hlaPatient1DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient1DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA2:'),
                        DropdownButton(
                          value: hlaPatient2DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient2DropDown = newValue;
                            });
                          },
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA3:'),
                        DropdownButton(
                          value: hlaPatient3DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient3DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA4:'),
                        DropdownButton(
                          value: hlaPatient4DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient4DropDown = newValue;
                            });
                          },
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA5:'),
                        DropdownButton(
                          value: hlaPatient5DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient5DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA6:'),
                        DropdownButton(
                          value: hlaPatient6DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaPatient6DropDown = newValue;
                            });
                          },
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
                          Duration diff = value.difference(DateTime.now());
                          pairData.age = ((diff.inDays) / 365).round();
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
                          labelText: "Kidney Size(cm)",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            pairData.k = double.parse(value);
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
                          labelText: "Pincode",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          pairData.pin = value as int?;
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
                          pairData.mobileNo = value;
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
                        'assets/sex.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: sexPatientDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Gender:",
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
                            sexPatientDropDown = newValue;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Donors Details:"),
                  ),
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
                        controller: donorNameTextField,
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
                          pairData.dName = value;
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
                        value: bloodGroupDonorDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Blood Group:",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'A+',
                          'B+',
                          'AB+',
                          'O+',
                          'A-',
                          'B-',
                          'AB-',
                          'O-'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            bloodGroupDonorDropDown = newValue;
                          });
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA1:'),
                        DropdownButton(
                          value: hlaDonor1DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor1DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA2:'),
                        DropdownButton(
                          value: hlaDonor2DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor2DropDown = newValue;
                            });
                          },
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA3:'),
                        DropdownButton(
                          value: hlaDonor3DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor3DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA4:'),
                        DropdownButton(
                          value: hlaDonor4DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor4DropDown = newValue;
                            });
                          },
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/sex.png',
                            height: 30,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const Text('HLA5:'),
                        DropdownButton(
                          value: hlaDonor5DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor5DropDown = newValue;
                            });
                          },
                        ),
                        const Text('HLA6:'),
                        DropdownButton(
                          value: hlaDonor6DropDown,
                          icon: const Icon(Icons.arrow_downward),
                          items: <String>[
                            'A+',
                            'B+',
                            'AB+',
                            'O+',
                            'A-',
                            'B-',
                            'AB-',
                            'O-'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              hlaDonor6DropDown = newValue;
                            });
                          },
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
                          Duration diff = value.difference(DateTime.now());
                          pairData.dAge = ((diff.inDays) / 365).round();
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
                        controller: donorHeightTextField,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Kidney Size(cm)",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            pairData.dK = double.parse(value);
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
                        'assets/address.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: donorAddressTextField,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pincode",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          pairData.dPin = value as int?;
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
                        controller: donorPhoneNumberTextField,
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
                          pairData.dMobileNo = value;
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
                        'assets/sex.png',
                        height: 30,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: sexDonorDropDown,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: const InputDecoration(
                          labelText: "Gender:",
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
                            sexDonorDropDown = newValue;
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
                          labelText: "Societal Distribution:",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'Hindu General',
                          'Hindu OBC',
                          'Hindu SC/ST',
                          'Muslim General',
                          'Muslim OBC',
                          'Muslim SC/ST',
                          'Christian General',
                          'Christian OBC',
                          'Christian SC/ST',
                          'Sikh General',
                          'Sikh OBC',
                          'Sikh SC/ST',
                          'Jain General',
                          'Jain OBC',
                          'Jain SC/ST'
                        ].map((String value) {
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
