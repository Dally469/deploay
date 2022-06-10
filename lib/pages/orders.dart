import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/utils/colors.dart';
class Orders extends StatefulWidget {
  final String title;
  const Orders(this.title);
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Center(
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(widget.title,
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
