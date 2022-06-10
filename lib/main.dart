import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/language.dart';
import 'package:ralga/pages/categories/category-rw.dart';
import 'package:ralga/pages/decentralization/decentralization-en.dart';
import 'package:ralga/pages/home-rw.dart';
import 'package:ralga/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Language()),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png", scale: 2,),
          SizedBox(height: 40,),
          new Center(
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              child: Align(
                alignment: Alignment.center,
                child: Text("Rwanda Local Government Law",
                  textAlign: TextAlign.center,
                        style: TextStyle(color: appColor, fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            )),
          SizedBox(height: 30,),
          SpinKitDoubleBounce(
            color: appDarkColor,
          )
        ],
      ),
    );
  }
}
