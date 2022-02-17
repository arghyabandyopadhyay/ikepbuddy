import '../Modules/universal_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Modules/database.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  final String qrCode;
  const QrCodePage({Key? key, required this.qrCode}) : super(key: key);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late String qrCode;
  @override
  void initState() {
    super.initState();
    qrCode = widget.qrCode;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("QR Code"),
        ),
        body: Center(
          child: QrImage(
            data: qrCode,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            backgroundColor: Colors.white,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "qrCodePageHeroTag",
          onPressed: () async {
            String _data = '';
            try {
              final pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 300,
                maxHeight: 300,
                imageQuality: 30,
              );
              setState(() {
                // QrCodeToolsPlugin.decodeFrom(pickedFile!.path).then((value) {
                //   _data = value;
                //   getUserDetails().then((value) {
                //     value!.qrcodeDetail = _data;
                //     setState(() {
                //       qrCode = _data;
                //     });
                //     value.update();
                //   });
                // });
              });
            } catch (e) {
              globalShowInSnackBar(scaffoldMessengerKey, e.toString());
              setState(() {
                _data = '';
              });
            }
          },
          child: const Icon(Icons.edit),
        ),
      ),
      key: scaffoldMessengerKey,
    );
  }
}
