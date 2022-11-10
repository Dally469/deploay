import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

import '../../widgets/app-icon.dart';
class UserManualEN extends StatelessWidget {
  const UserManualEN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    _appBar(height) => PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
      child: Stack(
        children: <Widget>[
          Container(
            height: height + 70,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
             color: Colors.white
            ), // Background
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (() => Navigator.pop(context)),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: appColor,
                          ),
                        ),
                        const SizedBox(
                          width: 200,
                          child: Text("User Manual",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: appColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: Row(
                      children: const [
                        AppIcon(icon: Icons.settings,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(), // Required some widget in between to float AppBar
        ],
      ),
    );
    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/phones_1.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This above image 1 with Shaded area they description are below",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1: Use application in English language",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2: Use application in Kinyarwanda language",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3: Use application in French language",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_2.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This above image 2 with Shaded area they description are below",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1: Click to read Decentralization",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2: Click to read Law category and their information",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3: Click to read user manual",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_3.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This above image 3 with Shaded area they description are below",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Click to read view all articles belongs in Organic law governing elections",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),

                SizedBox(height: 50,),
                Image.asset("assets/images/phones_4.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This above image 4 with Shaded area they description are below",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Click on icon arrow down to read  selected article more information",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_5.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("This above image 5 with Shaded area they description are below",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Now you are reading information arrow down is clicked on  selected article more information",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 70,),
              ],
            ),
          ),
        ));
  }


}
