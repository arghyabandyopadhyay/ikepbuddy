import '../Formatters/ind_number_text_input_formatter.dart';
import '../Models/pair_model.dart';
import '../Models/modal_option_model.dart';
import '../Modules/api_module.dart';
import '../Modules/universal_module.dart';
import '../Modules/database.dart';
import '../Modules/validator.dart';
import '../Widgets/option_modal_bottom_sheet.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import '../global_class.dart';

class ClientInformationPage extends StatefulWidget {
  final PairModel pairData;
  const ClientInformationPage({Key? key, required this.pairData})
      : super(key: key);
  @override
  _ClientInformationPageState createState() => _ClientInformationPageState();
}

class _ClientInformationPageState extends State<ClientInformationPage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late DateTime now, today;
  var phoneNumberTextField = TextEditingController();
  var donorPhoneNumberTextField = TextEditingController();
  var nameTextField = TextEditingController();
  var donorNameTextField = TextEditingController();
  var addressTextField = TextEditingController();
  var donorAddressTextField = TextEditingController();
  var kidneyTextField = TextEditingController();
  var donorKidneyTextField = TextEditingController();
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

  final focus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Functions

  Future<void> _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form!.validate()) {
    } else {
      form.save();
      showDialog(
          context: context,
          builder: (BuildContext context1) {
            return AlertDialog(
              title: const Text("Confirm Save"),
              content: const Text("Are you sure to save changes?"),
              actions: [
                ActionChip(
                    label: const Text("Yes"),
                    onPressed: () {
                      Navigator.pop(context1);
                      widget.pairData.gender = sexPatientDropDown;
                      widget.pairData.dGender = sexDonorDropDown;
                      widget.pairData.sd = casteDropDown;
                      widget.pairData.b = bloodGroupPatientDropDown;
                      widget.pairData.dB = bloodGroupDonorDropDown;
                      widget.pairData.h = [];
                      widget.pairData.h!.add(hlaPatient1DropDown!);
                      widget.pairData.h!.add(hlaPatient2DropDown!);
                      widget.pairData.h!.add(hlaPatient3DropDown!);
                      widget.pairData.h!.add(hlaPatient4DropDown!);
                      widget.pairData.h!.add(hlaPatient5DropDown!);
                      widget.pairData.h!.add(hlaPatient6DropDown!);
                      widget.pairData.dH = [];
                      widget.pairData.dH!.add(hlaDonor1DropDown!);
                      widget.pairData.dH!.add(hlaDonor2DropDown!);
                      widget.pairData.dH!.add(hlaDonor3DropDown!);
                      widget.pairData.dH!.add(hlaDonor4DropDown!);
                      widget.pairData.dH!.add(hlaDonor5DropDown!);
                      widget.pairData.dH!.add(hlaDonor6DropDown!);
                      widget.pairData.hospitalUID = GlobalClass.user!.uid;
                      updateClient(widget.pairData, widget.pairData.id!);
                      changesSavedModule(context, scaffoldMessengerKey);
                    }),
                ActionChip(
                    label: const Text("No"),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context1).pop();
                      });
                    })
              ],
            );
          });
    }
  }

  @override
  void initState() {
    now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);
    phoneNumberTextField.text = widget.pairData.mobileNo ?? "";
    donorPhoneNumberTextField.text = widget.pairData.dMobileNo ?? "";
    nameTextField.text = widget.pairData.name ?? "";
    donorNameTextField.text = widget.pairData.name ?? "";
    addressTextField.text = (widget.pairData.pin ?? "").toString();
    donorAddressTextField.text = (widget.pairData.dPin ?? "").toString();
    kidneyTextField.text = (widget.pairData.k ?? "").toString();
    donorKidneyTextField.text = (widget.pairData.dK ?? "").toString();
    sexPatientDropDown = widget.pairData.gender;
    sexDonorDropDown = widget.pairData.dGender;
    bloodGroupPatientDropDown = widget.pairData.b;
    bloodGroupDonorDropDown = widget.pairData.dB;
    hlaPatient1DropDown = widget.pairData.h![0];
    hlaPatient2DropDown = widget.pairData.h![1];
    hlaPatient3DropDown = widget.pairData.h![2];
    hlaPatient4DropDown = widget.pairData.h![3];
    hlaPatient5DropDown = widget.pairData.h![4];
    hlaPatient6DropDown = widget.pairData.h![5];
    hlaDonor1DropDown = widget.pairData.dH![0];
    hlaDonor2DropDown = widget.pairData.dH![1];
    hlaDonor3DropDown = widget.pairData.dH![2];
    hlaDonor4DropDown = widget.pairData.dH![3];
    hlaDonor5DropDown = widget.pairData.dH![4];
    hlaDonor6DropDown = widget.pairData.dH![5];
    casteDropDown = widget.pairData.sd;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.pairData.name ?? "Pair Profile",
          ),
          actions: [
            PopupMenuButton<ModalOptionModel>(
              itemBuilder: (BuildContext popupContext) {
                return [
                  ModalOptionModel(
                      particulars: "Call",
                      icon: Icons.call,
                      onTap: () {
                        Navigator.pop(popupContext);
                        callModule(widget.pairData, scaffoldMessengerKey);
                      }),
                  ModalOptionModel(
                      particulars: "Sms Reminder",
                      icon: Icons.send,
                      onTap: () {
                        Navigator.pop(popupContext);
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => OptionModalBottomSheet(
                                  appBarIcon: Icons.send,
                                  appBarText: "How to send the reminder",
                                  list: [
                                    ModalOptionModel(
                                        particulars:
                                            "Send Sms using Default Sim",
                                        icon: Icons.sim_card_outlined,
                                        onTap: () {
                                          Navigator.of(_).pop();
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    title: const Text(
                                                        "Confirm Send"),
                                                    content: Text(
                                                        "Are you sure to send a reminder to ${widget.pairData.name}?"),
                                                    actions: [
                                                      ActionChip(
                                                          label:
                                                              const Text("Yes"),
                                                          onPressed: () {
                                                            smsModule(
                                                                widget.pairData,
                                                                scaffoldMessengerKey);
                                                            Navigator.of(_)
                                                                .pop();
                                                          }),
                                                      ActionChip(
                                                          label:
                                                              const Text("No"),
                                                          onPressed: () {
                                                            Navigator.of(_)
                                                                .pop();
                                                          })
                                                    ],
                                                  ));
                                        }),
                                    ModalOptionModel(
                                        particulars:
                                            "Send Sms using Sms Gateway",
                                        icon: FontAwesomeIcons.server,
                                        onTap: () {
                                          if (GlobalClass.userDetail!
                                                      .smsAccessToken !=
                                                  null &&
                                              GlobalClass.userDetail!.smsApiUrl !=
                                                  null &&
                                              GlobalClass.userDetail!.smsUserId !=
                                                  null &&
                                              GlobalClass.userDetail!.smsMobileNo !=
                                                  null &&
                                              GlobalClass.userDetail!
                                                      .smsAccessToken !=
                                                  "" &&
                                              GlobalClass.userDetail!.smsApiUrl !=
                                                  "" &&
                                              GlobalClass
                                                      .userDetail!.smsUserId !=
                                                  "" &&
                                              GlobalClass.userDetail!
                                                      .smsMobileNo !=
                                                  "") {
                                            Navigator.of(_).pop();
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: const Text(
                                                          "Confirm Send"),
                                                      content: Text(
                                                          "Are you sure to send a reminder to ${widget.pairData.name}?"),
                                                      actions: [
                                                        ActionChip(
                                                            label: const Text(
                                                                "Yes"),
                                                            onPressed: () {
                                                              try {
                                                                postForBulkMessage(
                                                                    [
                                                                      widget
                                                                          .pairData
                                                                    ],
                                                                    "${GlobalClass.userDetail!.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
                                                                        ", please clear your dues for further continuation of services."}\npowered by IKEP Buddy Business Solutions");
                                                                globalShowInSnackBar(
                                                                    scaffoldMessengerKey,
                                                                    "Message Sent!!");
                                                              } catch (E) {
                                                                globalShowInSnackBar(
                                                                    scaffoldMessengerKey,
                                                                    "Something Went Wrong!!");
                                                              }
                                                              Navigator.of(_)
                                                                  .pop();
                                                            }),
                                                        ActionChip(
                                                            label: const Text(
                                                                "No"),
                                                            onPressed: () {
                                                              Navigator.of(_)
                                                                  .pop();
                                                            })
                                                      ],
                                                    ));
                                          } else {
                                            globalShowInSnackBar(
                                                scaffoldMessengerKey,
                                                "Please configure Sms Gateway Data in Settings.");
                                            Navigator.of(_).pop();
                                          }
                                        }),
                                  ],
                                ));
                      }),
                  ModalOptionModel(
                      particulars: "WhatsApp",
                      icon: FontAwesomeIcons.whatsappSquare,
                      onTap: () async {
                        Navigator.pop(popupContext);
                        whatsAppModule(widget.pairData, scaffoldMessengerKey);
                      }),
                  ModalOptionModel(
                      particulars: "Delete",
                      icon: Icons.delete,
                      onTap: () {
                        Navigator.pop(popupContext);
                        deleteModule(widget.pairData, context, this);
                      }),
                ].map((ModalOptionModel choice) {
                  return PopupMenuItem<ModalOptionModel>(
                    value: choice,
                    child: ListTile(
                      title: Text(choice.particulars),
                      leading: Icon(
                        choice.icon,
                        color: choice.iconColor,
                      ),
                      onTap: choice.onTap,
                    ),
                  );
                }).toList();
              },
            ),
          ],
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
                        validator: validateName,
                        onSaved: (value) {
                          widget.pairData.name = value;
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
                          widget.pairData.age = ((diff.inDays) / 365).round();
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
                        controller: kidneyTextField,
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
                            widget.pairData.k = double.parse(value);
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
                        keyboardType: TextInputType.number,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pincode",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          widget.pairData.pin = int.parse(value ?? "0");
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
                          widget.pairData.mobileNo = value;
                        },
                        validator: (value) {
                          return validatePhoneNumber(
                              value, phoneNumberTextField);
                        },
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
                        validator: validateName,
                        onSaved: (value) {
                          widget.pairData.dName = value;
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
                          widget.pairData.dAge = ((diff.inDays) / 365).round();
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
                        controller: donorKidneyTextField,
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
                            widget.pairData.dK = double.parse(value);
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
                        keyboardType: TextInputType.number,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pincode",
                          contentPadding: EdgeInsets.only(
                              bottom: 10.0, left: 10.0, right: 10.0),
                        ),
                        onSaved: (value) {
                          widget.pairData.dPin = int.parse(value ?? "0");
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
                          widget.pairData.dMobileNo = value;
                        },
                        validator: (value) {
                          return validatePhoneNumber(
                              value, donorPhoneNumberTextField);
                        },
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
          heroTag: "saveClientInformationHeroTag",
          onPressed: () {
            _handleSubmitted();
          },
          label: const Text("Save"),
          icon: const Icon(
            Icons.save,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
      key: scaffoldMessengerKey,
    );
  }

  Future<PermissionStatus> _getContactPermission() async {
    return await Permission.contacts.request();
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      globalShowInSnackBar(scaffoldMessengerKey, "Access Denied by the user!!");
    } else if (permissionStatus == PermissionStatus.restricted) {
      globalShowInSnackBar(
          scaffoldMessengerKey, "Location data is not available on device");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
