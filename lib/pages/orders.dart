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
          Center(
              child: Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: appColor, fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              )),
          const SizedBox(height: 30,),
          const SpinKitDoubleBounce(
            color: appDarkColor,
          )
        ],
      ),
    );
  }
}
