import '../Models/modal_option_model.dart';
import '../Modules/api_module.dart';
import '../Modules/universal_module.dart';
import '../global_class.dart';
import '../Widgets/client_card_widget.dart';
import '../custom_colors.dart';
import '../Models/pair_model.dart';
import 'option_modal_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class ClientList extends StatefulWidget {
  final List<PairModel> listItems;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final Function onLongPressed;
  final Function onTapList;
  final Function onDoubleTapList;
  final Future<void> Function() refreshData;
  final ScrollController scrollController;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  const ClientList(
      {Key? key,
      required this.listItems,
      required this.scaffoldMessengerKey,
      required this.onTapList,
      required this.onLongPressed,
      required this.onDoubleTapList,
      required this.refreshData,
      required this.scrollController,
      required this.refreshIndicatorKey})
      : super(key: key);
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  final TextEditingController alertTextController = TextEditingController();
  late bool isLoading;
  @override
  void initState() {
    super.initState();
    isLoading = false;
    _loadMore();
  }

  List displayList = [];
  int currentLength = 0;
  final int increment = 100;
  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });
    int end = currentLength + increment;
    displayList.addAll(widget.listItems.getRange(currentLength,
        end >= widget.listItems.length ? widget.listItems.length : end));
    setState(() {
      isLoading = false;
      currentLength = displayList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadScrollView(
          isLoading: isLoading,
          scrollOffset: 500,
          onEndOfPage: () => _loadMore(),
          child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              displacement: 10,
              key: widget.refreshIndicatorKey,
              onRefresh: widget.refreshData,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: widget.scrollController,
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    child: ClientCardWidget(
                      key: ObjectKey(displayList[index].id.key),
                      item: displayList[index],
                      index: index,
                      onTapList: (index) {
                        widget.onTapList(index);
                      },
                      onLongPressed: (index) {
                        widget.onLongPressed(index);
                      },
                      onDoubleTap: (index) {
                        widget.onDoubleTapList(index);
                      },
                    ),
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: <Widget>[
                        SlidableAction(
                          label: 'Call',
                          icon: Icons.call,
                          onPressed: (context) async {
                            callModule(displayList[index],
                                widget.scaffoldMessengerKey);
                          },
                        ),
                        SlidableAction(
                          label: 'SMS',
                          icon: Icons.send,
                          onPressed: (context) {
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
                                                            "Are you sure to send a reminder to ${widget.listItems[index].name}?"),
                                                        actions: [
                                                          ActionChip(
                                                              label: const Text(
                                                                  "Yes"),
                                                              onPressed: () {
                                                                smsModule(
                                                                    displayList[
                                                                        index],
                                                                    widget
                                                                        .scaffoldMessengerKey);
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
                                                  GlobalClass.userDetail!
                                                          .smsMobileNo !=
                                                      null &&
                                                  GlobalClass.userDetail!
                                                          .smsAccessToken !=
                                                      "" &&
                                                  GlobalClass
                                                          .userDetail!.smsApiUrl !=
                                                      "" &&
                                                  GlobalClass.userDetail!
                                                          .smsUserId !=
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
                                                              "Are you sure to send a reminder to ${widget.listItems[index].name}?"),
                                                          actions: [
                                                            ActionChip(
                                                                label:
                                                                    const Text(
                                                                        "Yes"),
                                                                onPressed: () {
                                                                  try {
                                                                    postForBulkMessage(
                                                                        [
                                                                          widget
                                                                              .listItems[index]
                                                                        ],
                                                                        "${GlobalClass.userDetail!.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
                                                                            ", please clear your dues for further continuation of services."}\npowered by IKEP Buddy Business Solutions");
                                                                    globalShowInSnackBar(
                                                                        widget
                                                                            .scaffoldMessengerKey,
                                                                        "Message Sent!!");
                                                                  } catch (E) {
                                                                    globalShowInSnackBar(
                                                                        widget
                                                                            .scaffoldMessengerKey,
                                                                        "Something Went Wrong!!");
                                                                  }
                                                                  Navigator.of(
                                                                          _)
                                                                      .pop();
                                                                }),
                                                            ActionChip(
                                                                label:
                                                                    const Text(
                                                                        "No"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          _)
                                                                      .pop();
                                                                })
                                                          ],
                                                        ));
                                              } else {
                                                globalShowInSnackBar(
                                                    widget.scaffoldMessengerKey,
                                                    "Please configure Sms Gateway Data in Settings.");
                                                Navigator.of(_).pop();
                                              }
                                            }),
                                      ],
                                    ));
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      children: <Widget>[
                        SlidableAction(
                          label: 'WhatsApp',
                          icon: FontAwesomeIcons.whatsappSquare,
                          backgroundColor: CustomColors.whatsAppGreen,
                          onPressed: (context) async {
                            whatsAppModule(displayList[index],
                                widget.scaffoldMessengerKey);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ))),
    );
  }

  @override
  void didChangeDependencies() {
    Provider.of<int>(context);
    displayList.clear();
    currentLength = 0;
    _loadMore();
    super.didChangeDependencies();
  }
}
