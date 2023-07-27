import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:ralga/pages/infos/laws-category-en.dart';
import 'package:ralga/pages/infos/laws-category-rw.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DecentralizationRW extends StatefulWidget {
  const DecentralizationRW({Key? key}) : super(key: key);

  @override
  State<DecentralizationRW> createState() => _DecentralizationRWState();
}

class _DecentralizationRWState extends State<DecentralizationRW> {
  bool isNew = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                            child: Text("Ubuyobozi Bwegereye Abaturage",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
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
                                Share.share('https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2012.pdf');
                                //onButtonTap(Share.whatsapp);
                                //Navigator.push( context,MaterialPageRoute( builder: (context) => LawsCategoryFR()),);
                              },
                              child: AppIcon(icon: Icons.share)),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(),
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
                          SizedBox(width: 4,),
                          isNew == false ? Icon(Icons.check_circle, size: 30, color: appColor,) : Icon(Icons.check_circle, color: whiteColor,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Umwaka",
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
                          Icon(Icons.check_circle, color: whiteColor,)
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
                          SizedBox(width: 4,),
                            isNew == true ? Icon(Icons.check_circle, size: 30, color: appColor,) : Icon(Icons.check_circle, color: whiteColor,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Umwaka",
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
                          Icon(Icons.check_circle, color: whiteColor,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
            // Required some widget in between to float AppBar
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
              child: SfPdfViewer.network(
                    'https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2012.pdf'))
            : Container(
              color: orangeColor,
              margin: EdgeInsets.all(3),
              child: SfPdfViewer.network('https://ralgaapi.awm-global.org/public/assets/pdf/kinyarwanda_decentralization_2012.pdf')
        ));
  }
}
