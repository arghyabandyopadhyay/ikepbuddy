import '../Models/modal_option_model.dart';
import 'package:flutter/material.dart';

class OptionModalBottomSheet extends StatelessWidget {
  final String? appBarText;
  final IconData? appBarIcon;
  final List<ModalOptionModel>? list;
  const OptionModalBottomSheet(
      {Key? key, this.list, this.appBarText, this.appBarIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(appBarText ?? ""),
        leading: IconButton(
          icon: Icon(appBarIcon),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list![index].particulars),
                  leading: Icon(
                    list![index].icon,
                    color: list![index].iconColor,
                  ),
                  onTap: list![index].onTap,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
