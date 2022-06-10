import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:ralga/pages/decentralization/decentralization-en.dart';
import 'package:ralga/pages/infos/laws-category-en.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';



class Decentralization extends StatefulWidget {
  const Decentralization({Key? key}) : super(key: key);

  @override
  State<Decentralization> createState() => _DecentralizationState();
}

class _DecentralizationState extends State<Decentralization> {
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
                        child: Text("Decentralization",
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
                            Share.share('https://rwtest.yesconnect.rw/assets/pdf/english_decentralization_2012');
                            //onButtonTap(Share.whatsapp);
                            //Navigator.push( context,MaterialPageRoute( builder: (context) => LawsCategoryFR()),);
                          },
                          child: AppIcon(icon: Icons.share)),
                      InkWell(
                          onTap: () {

                            Navigator.push( context,MaterialPageRoute( builder: (context) => LawsCategoryEN()),);
                          },
                          child: AppIcon(icon: Icons.arrow_forward)),
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
                    Navigator.push( context, MaterialPageRoute(builder: (context) => DecentralizationEN()),);
                  });
                },
                child: Container(
                  height: 50,
                  width: 110,
                  color: whiteColor,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 4,),
                      isNew == false ? Icon(Icons.check_circle, size: 20, color: appColor,) : Icon(Icons.check_circle, color: whiteColor,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Year",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              )),
                          Text("2001",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
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
                  width: 110,
                  color: whiteColor,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 4,),
                      isNew == true ? Icon(Icons.check_circle, size: 20, color: appColor,) : Icon(Icons.check_circle, color: whiteColor,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Year",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              )),
                          Text("2012",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
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
                    Navigator.push( context, MaterialPageRoute(builder: (context) => DecentralizationEN()),);
                  });
                },
                child: Container(
                  height: 50,
                  width: 110,
                  color: whiteColor,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 4,),
                      isNew == false ? Icon(Icons.check_circle, size: 20, color: appColor,) : Icon(Icons.check_circle, color: whiteColor,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Year",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              )),
                          Text("2021",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                      Icon(Icons.check_circle, color: whiteColor,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )// Required some widget in between to float AppBar
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body:Container(
            color: appColor,
            margin: EdgeInsets.all(3),
            child: SfPdfViewer.network(
                'https://rwtest.yesconnect.rw/assets/pdf/english_decentralization_2012.pdf'))
            );
  }

}
