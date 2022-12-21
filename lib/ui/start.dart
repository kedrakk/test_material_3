import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  void initPlatformState() async {
    // By default, this example doesn't set a license key, but instead runs in trial mode (which is the default, and which requires no
    // specific initialization). If you want to use a different license key for evaluation (e.g. a production license), you can uncomment
    // the next line and set the license key.
    //
    // To set the license key for both platforms, use:
    // await Pspdfkit.setLicenseKeys("YOUR_FLUTTER_ANDROID_LICENSE_KEY_GOES_HERE", "YOUR_FLUTTER_IOS_LICENSE_KEY_GOES_HERE");
    //
    // To set the license key for the currently running platform, use:
    // await Pspdfkit.setLicenseKey("YOUR_FLUTTER_LICENSE_KEY_GOES_HERE");
  }

  // void showDocument(BuildContext context) async {
  //   final bytes = await DefaultAssetBundle.of(context)
  //       .load("file:///sdk_gpone64_arm64/Download/KhinEaindraKyaw.pdf");
  //   final list = bytes.buffer.asUint8List();

  //   final tempDir = await Pspdfkit.getTemporaryDirectory();
  //   final tempDocumentPath =
  //       '${tempDir.path}/file:///sdk_gpone64_arm64/Download/KhinEaindraKyaw.pdf';

  //   final file = await File(tempDocumentPath).create(recursive: true);
  //   file.writeAsBytesSync(list);

  //   await Pspdfkit.present(tempDocumentPath);
  // }

  showDocument() async {
    final res = await FilePicker.platform.pickFiles();
    if (res != null) {
      var file = File(res.files.single.path!);
      Uint8List uint8list = file.readAsBytesSync();
      final tempDir = await Pspdfkit.getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/file.pdf';
      final myFile = await File(tempDocumentPath).create(recursive: true);
      myFile.writeAsBytesSync(uint8list);
      await Pspdfkit.present(tempDocumentPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Tap to Open Document',
                      style: themeData.textTheme.headline4
                          ?.copyWith(fontSize: 21.0),
                    ),
                    onPressed: () => showDocument(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
