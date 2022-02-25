import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ikepbuddy/Models/pair_model.dart';
import 'package:ikepbuddy/Modules/database.dart';
import 'package:provider/provider.dart';

import '../Models/modal_option_model.dart';
import '../Modules/api_module.dart';
import '../Modules/error_page.dart';
import '../Modules/universal_module.dart';
import '../Widgets/client_list.dart';
import '../Widgets/loader_widget.dart';
import '../Widgets/option_modal_bottom_sheet.dart';
import '../global_class.dart';
import 'add_patient_page.dart';
import 'client_information_page.dart';

class Exchanges extends StatefulWidget {
  const Exchanges({Key? key}) : super(key: key);
  @override
  _ExchangesState createState() => _ExchangesState();
}

class _ExchangesState extends State<Exchanges> {
  List<PairModel>? clients;
  int _counter = 0;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  bool _isSearching = false;
  List<PairModel> searchResult = [];
  Icon icon = const Icon(
    Icons.search,
  );
  bool? _isLoading;
  //Controller
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController scrollController = ScrollController();
  //Widgets
  Widget appBarTitle = const Text(
    "",
    textScaleFactor: 1,
    style: TextStyle(fontSize: 24.0, height: 2.5),
  );

  void getPairs() {
    getUniversalClientList().then((clients) => {
          if (mounted)
            setState(() {
              this.clients = clients;
              _counter++;
              _isLoading = false;
              appBarTitle = const Text(
                "Registered Pairs",
              );
            })
        });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    getPairs();
    appBarTitle = const Text("Registered Pairs");
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      icon = const Icon(
        Icons.search,
      );
      appBarTitle = const Text(
        "Notifications",
      );
      _isSearching = false;
      _searchController.clear();
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching && clients != null) {
      searchResult = clients!
          .where((PairModel element) => (element.masterFilter!.toLowerCase())
              .contains(
                  searchText.toLowerCase().replaceAll(RegExp(r"\s+"), "")))
          .toList();
      setState(() {});
    }
  }

  void newPairModel(PairModel pairModel) {
    addPairInRegister(pairModel);
    setState(() {
      if (clients != null) {
        clients!.add(pairModel);
      } else {
        clients = [pairModel];
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshData() async {
    try {
      if (_isSearching) _handleSearchEnd();
      Connectivity connectivity = Connectivity();
      await connectivity.checkConnectivity().then((value) async {
        if (value != ConnectivityResult.none) {
          if (!_isLoading!) {
            _isLoading = true;
            return getNotificationClients(context).then((clients) => {
                  if (mounted)
                    setState(() {
                      this.clients = clients;
                      _counter++;
                      _isLoading = false;
                      appBarTitle = const Text(
                        "Notifications",
                      );
                    })
                });
          } else {
            globalShowInSnackBar(
                scaffoldMessengerKey, "Data is being loaded...");
            return null;
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          globalShowInSnackBar(
              scaffoldMessengerKey, "No Internet Connection!!");
          return null;
        }
      });
    } catch (E) {
      setState(() {
        _isLoading = false;
      });
      globalShowInSnackBar(scaffoldMessengerKey, "Something Went Wrong");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(
          onPressed: () {
            if (!_isSearching) Navigator.of(context).pop();
          },
          icon: Icon(_isSearching ? Icons.search : Icons.arrow_back),
        ),
        actions: [
          IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (icon.icon == Icons.search) {
                    icon = const Icon(Icons.close);
                    appBarTitle = TextFormField(
                      autofocus: true,
                      controller: _searchController,
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Search Notifications",
                          hintStyle: TextStyle(fontSize: 15)),
                      onChanged: searchOperation,
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                });
              }),
          PopupMenuButton<ModalOptionModel>(
            itemBuilder: (BuildContext popupContext) {
              return [
                ModalOptionModel(
                    particulars: "Send Reminder",
                    icon: Icons.send,
                    onTap: () async {
                      Navigator.pop(popupContext);
                      showModalBottomSheet(
                          context: context,
                          builder: (_) => OptionModalBottomSheet(
                                appBarIcon: Icons.send,
                                appBarText: "How to send the reminder",
                                list: [
                                  ModalOptionModel(
                                      particulars: "Send Sms using Default Sim",
                                      icon: Icons.sim_card_outlined,
                                      onTap: () {
                                        Navigator.of(_).pop();
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: const Text(
                                                      "Confirm Send"),
                                                  content: const Text(
                                                      "Are you sure to send a reminder to all the clients?"),
                                                  actions: [
                                                    ActionChip(
                                                        label:
                                                            const Text("Yes"),
                                                        onPressed: () {
                                                          List<String>
                                                              addressList = [];
                                                          clients?.forEach(
                                                              (PairModel
                                                                  element) {
                                                            String? address =
                                                                element
                                                                    .mobileNo;
                                                            if (address !=
                                                                    null &&
                                                                address != "") {
                                                              addressList
                                                                  .add(address);
                                                            }
                                                          });
                                                          sendSMS(
                                                              message:
                                                                  "${GlobalClass.userDetail!.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
                                                                      ", please clear your dues for further continuation of services."}\npowered by IKEP Buddy Business Solutions",
                                                              recipients:
                                                                  addressList);
                                                          Navigator.of(_).pop();
                                                        }),
                                                    ActionChip(
                                                        label: const Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(_).pop();
                                                        })
                                                  ],
                                                ));
                                      }),
                                  ModalOptionModel(
                                      particulars: "Send Sms using Sms Gateway",
                                      icon: FontAwesomeIcons.server,
                                      onTap: () {
                                        if (GlobalClass.userDetail
                                                    ?.smsAccessToken !=
                                                null &&
                                            GlobalClass.userDetail?.smsApiUrl !=
                                                null &&
                                            GlobalClass.userDetail?.smsUserId !=
                                                null &&
                                            GlobalClass.userDetail?.smsMobileNo !=
                                                null &&
                                            GlobalClass.userDetail
                                                    ?.smsAccessToken !=
                                                "" &&
                                            GlobalClass.userDetail?.smsApiUrl !=
                                                "" &&
                                            GlobalClass.userDetail?.smsUserId !=
                                                "" &&
                                            GlobalClass
                                                    .userDetail?.smsMobileNo !=
                                                "") {
                                          Navigator.of(_).pop();
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    title: const Text(
                                                        "Confirm Send"),
                                                    content: const Text(
                                                        "Are you sure to send a reminder to all the clients?"),
                                                    actions: [
                                                      ActionChip(
                                                          label:
                                                              const Text("Yes"),
                                                          onPressed: () {
                                                            try {
                                                              postForBulkMessage(
                                                                  clients!,
                                                                  "${GlobalClass.userDetail?.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
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
                                                          label:
                                                              const Text("No"),
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
                    particulars: "Sort",
                    icon: Icons.sort,
                    onTap: () {
                      Navigator.pop(popupContext);
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext alertDialogContext) {
                            return OptionModalBottomSheet(
                                appBarText: "Sort Options",
                                appBarIcon: Icons.sort,
                                list: [
                                  ModalOptionModel(
                                    icon: Icons.more_time,
                                    particulars: "Age Ascending",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "Age Ascending", clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                  ModalOptionModel(
                                    icon: Icons.more_time,
                                    particulars: "Age Descending",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "Age Descending", clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                  ModalOptionModel(
                                    icon: Icons.more_time,
                                    particulars: "Registration Id Ascending",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "Registration Id Ascending",
                                              clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                  ModalOptionModel(
                                    icon: Icons.more_time,
                                    particulars: "Registration Id Descending",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "Registration Id Descending",
                                              clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                  ModalOptionModel(
                                    icon: Icons.sort_by_alpha_outlined,
                                    particulars: "A-Z",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "A-Z", clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                  ModalOptionModel(
                                    icon: Icons.sort_by_alpha_outlined,
                                    particulars: "Z-A",
                                    onTap: () {
                                      if (clients != null) {
                                        setState(() {
                                          clients = sortClientsModule(
                                              "Z-A", clients!);
                                        });
                                      }
                                      Navigator.pop(alertDialogContext);
                                    },
                                  ),
                                ]);
                          });
                    }),
                if (clients != null && clients!.isNotEmpty)
                  ModalOptionModel(
                      particulars: "Move to top",
                      icon: Icons.vertical_align_top_outlined,
                      onTap: () async {
                        Navigator.pop(popupContext);
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      }),
              ].map((ModalOptionModel choice) {
                return PopupMenuItem<ModalOptionModel>(
                  value: choice,
                  child: ListTile(
                    title: Text(choice.particulars),
                    leading: Icon(choice.icon, color: choice.iconColor),
                    onTap: choice.onTap,
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: clients != null
          ? clients!.isEmpty
              ? const NoDataError()
              : Column(children: <Widget>[
                  Expanded(
                      child: _isSearching
                          ? Provider.value(
                              value: _counter,
                              updateShouldNotify: (oldValue, newValue) => true,
                              child: ClientList(
                                  listItems: searchResult,
                                  refreshData: () {
                                    return refreshData();
                                  },
                                  refreshIndicatorKey: refreshIndicatorKey,
                                  scrollController: scrollController,
                                  scaffoldMessengerKey: scaffoldMessengerKey,
                                  onTapList: (index) {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (context) =>
                                                ClientInformationPage(
                                                    pairData:
                                                        searchResult[index])))
                                        .then((value) {
                                      setState(() {
                                        if (value == null) {
                                        } else {
                                          clients!.remove(searchResult[index]);
                                          searchResult
                                              .remove(searchResult[index]);
                                        }
                                      });
                                    });
                                  },
                                  onLongPressed: (index) {},
                                  onDoubleTapList: (index) {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title:
                                                  const Text("Confirm Delete"),
                                              content: Text(
                                                  "Are you sure to delete ${searchResult[index].name}?"),
                                              actions: [
                                                ActionChip(
                                                    label: const Text("Yes"),
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteDatabaseNode(
                                                            searchResult[index]
                                                                .id!);
                                                        searchResult
                                                            .removeAt(index);
                                                        Navigator.of(_).pop();
                                                      });
                                                    }),
                                                ActionChip(
                                                    label: const Text("No"),
                                                    onPressed: () {
                                                      setState(() {
                                                        Navigator.of(_).pop();
                                                      });
                                                    })
                                              ],
                                            ));
                                  }))
                          : Provider.value(
                              value: _counter,
                              updateShouldNotify: (oldValue, newValue) => true,
                              child: ClientList(
                                  listItems: clients!,
                                  scaffoldMessengerKey: scaffoldMessengerKey,
                                  onTapList: (index) {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                            builder: (context) =>
                                                ClientInformationPage(
                                                    pairData: clients![index])))
                                        .then((value) {
                                      setState(() {
                                        if (value == null) {
                                        } else {
                                          clients!.remove(clients![index]);
                                        }
                                      });
                                    });
                                  },
                                  scrollController: scrollController,
                                  refreshData: () {
                                    return refreshData();
                                  },
                                  refreshIndicatorKey: refreshIndicatorKey,
                                  onLongPressed: (index) {},
                                  onDoubleTapList: (index) {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title:
                                                  const Text("Confirm Delete"),
                                              content: Text(
                                                  "Are you sure to delete ${clients![index].name}?"),
                                              actions: [
                                                ActionChip(
                                                    label: const Text("Yes"),
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteDatabaseNode(
                                                            clients![index]
                                                                .id!);
                                                        clients!
                                                            .removeAt(index);
                                                        Navigator.of(_).pop();
                                                      });
                                                    }),
                                                ActionChip(
                                                    label: const Text("No"),
                                                    onPressed: () {
                                                      setState(() {
                                                        Navigator.of(_).pop();
                                                      });
                                                    })
                                              ],
                                            ));
                                  }))),
                ])
          : LoaderWidget(),
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
