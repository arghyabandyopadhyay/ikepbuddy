import 'package:flutter/material.dart';
import '../Models/pair_model.dart';

class ClientCardWidget extends StatefulWidget {
  final PairModel item;
  final Function onTapList;
  final Function onLongPressed;
  final Function onDoubleTap;
  final int index;
  const ClientCardWidget(
      {required this.item,
      required Key key,
      required this.onTapList,
      required this.index,
      required this.onLongPressed,
      required this.onDoubleTap})
      : super(key: key);
  @override
  _ClientCardWidgetState createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends State<ClientCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTapList(widget.index);
        },
        onLongPress: () {
          widget.onLongPressed(widget.index);
        },
        onDoubleTap: () {
          widget.onDoubleTap(widget.index);
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            color: widget.item.isSelected ? Colors.grey.withOpacity(0.1) : null,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.item.name ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    )),
                    Text(
                      widget.item.dName ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        (widget.item.uid != null && widget.item.uid != ""
                            ? widget.item.uid!
                            : widget.item.id!.key!),
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    Text("\u2706: " + (widget.item.mobileNo ?? "N/A")),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        (widget.item.age ?? "").toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text((widget.item.dAge ?? "").toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
