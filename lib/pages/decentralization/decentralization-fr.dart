import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:http/http.dart' as http;
import 'package:ralga/pages/infos/laws-category-en.dart';
import 'package:ralga/pages/infos/laws-category-fr.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';

///sharing platform
// enum Share {
//   facebook,
//   messenger,
//   twitter,
//   whatsapp,
//   whatsapp_personal,
//   whatsapp_business,
//   share_system,
//   share_instagram,
//   share_telegram
// }

class DecentralizationFR extends StatefulWidget {
  const DecentralizationFR({Key? key}) : super(key: key);

  @override
  State<DecentralizationFR> createState() => _DecentralizationFRState();
}

class _DecentralizationFRState extends State<DecentralizationFR> {
  File? file;
  bool videoEnable = false;
  bool isNew = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Future<void> onButtonTap(Share share) async {
//     String msg =
//         'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
//     String url = 'https://pub.dev/packages/flutter_share_me';

//     String? response;
//     final FlutterShareMe flutterShareMe = FlutterShareMe();
//     switch (share) {
//       case Share.facebook:
//         response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
//         break;
//       case Share.messenger:
//         response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
//         break;
//       case Share.twitter:
//         response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
//         break;
//       case Share.whatsapp:
//         if (file != null) {
//           response = await flutterShareMe.shareToWhatsApp(
//               imagePath: file!.path,
//               fileType: videoEnable ? FileType.video : FileType.image);
//         } else {
//           response = await flutterShareMe.shareToWhatsApp(msg: msg);
//         }
//         break;
//       case Share.whatsapp_business:
//         response = await flutterShareMe.shareToWhatsApp(msg: msg);
//         break;
//       case Share.share_system:
//         response = await flutterShareMe.shareToSystem(msg: msg);
//         break;
//       case Share.whatsapp_personal:
//         response = await flutterShareMe.shareWhatsAppPersonalMessage(
//             message: msg, phoneNumber: 'phone-number-with-country-code');
//         break;
//       case Share.share_instagram:
//         response = await flutterShareMe.shareToInstagram(
//             filePath: file!.path,
//             fileType: videoEnable ? FileType.video : FileType.image);
//         break;
//       case Share.share_telegram:
//         response = await flutterShareMe.shareToTelegram(msg: msg);
//         break;
//     }
//     debugPrint(response);
//   }
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 145),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 145,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appDarkColor,
                  appDarkColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text("Decentralization",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                // Share.share('check out my website \n  https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');
                                //onButtonTap(Share.whatsapp);
                                //Navigator.push( context,MaterialPageRoute( builder: (context) => LawsCategoryFR()),);
                              },
                              child: AppIcon(icon: Icons.share)),
                          InkWell(
                              onTap: () {

                                Navigator.push( context,MaterialPageRoute( builder: (context) => LawsCategoryFR()),);
                              },
                              child: AppIcon(icon: Icons.arrow_forward)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(), // Required some widget in between to float AppBar
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isNew = false;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 160,
                      color: whiteColor,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          isNew == false
                              ? Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: appColor,
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: whiteColor,
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Annee",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text("2001",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                            ],
                          ),
                          Icon(
                            Icons.check_circle,
                            color: whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isNew = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 160,
                      color: whiteColor,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          isNew == true
                              ? Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: appColor,
                                )
                              : Icon(
                                  Icons.check_circle,
                                  color: whiteColor,
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Annee",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text("2021",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                            ],
                          ),
                          Icon(
                            Icons.check_circle,
                            color: whiteColor,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body: isNew == true
            ? Container(
                color: appColor,
                margin: EdgeInsets.all(3),
                // child: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')
            )
            : Container(
                color: orangeColor,
                margin: EdgeInsets.all(3),
                // child: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')
    ));
  }
}
