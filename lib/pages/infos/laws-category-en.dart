import 'package:flutter/material.dart';
import 'package:ralga/pages/categories/category-en.dart';
import 'package:ralga/pages/home-kgl-en.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';

class LawsCategoryEN extends StatefulWidget {
  const LawsCategoryEN({ Key? key }) : super(key: key);

  @override
  State<LawsCategoryEN> createState() => _LawsCategoryENState();
}

class _LawsCategoryENState extends State<LawsCategoryEN> {
  

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 70,
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
                      margin: const EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                          const SizedBox(
                            width: 190,
                            child: Text("Laws",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 23),
                      child: Row(
                        children: const [
                          AppIcon(icon: Icons.search),
                          AppIcon(icon: Icons.settings),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CategoryEN()
                              ),
                            );
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFe8e8e8),
                                    offset: Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Container(
                            padding: EdgeInsets.only(left: 0, right: 3, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: overlayWhiteColor, width: 3),
                                      ),
                                      child: Image.asset("assets/images/rwlogo.png"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 270,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Law governing the District", style: TextStyle(color: appDarkColor, fontSize: 20, fontWeight: FontWeight.bold),),
                                                  SizedBox(height: 4,),
                                                  
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.arrow_forward, color: Colors.green,),
                                                SizedBox(width: 10,),
                                                Text("Click here",
                                                    style: TextStyle(
                                                        fontSize: 14, color:appDarkColor)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeKGL_EN()
                              ),
                            );
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFe8e8e8),
                                    offset: Offset(0, 5),
                                    blurRadius: 5)
                              ]),
                          child: Container(
                            padding: EdgeInsets.only(left: 0, right: 3, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: overlayWhiteColor, width: 3),
                                      ),
                                      child: Image.asset("assets/images/rwlogo.png"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 270,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Law governing the city of Kigali", style: TextStyle(color: appDarkColor, fontSize: 20, fontWeight: FontWeight.bold),),
                                                  SizedBox(height: 4,),
                                                 
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.arrow_forward, color: Colors.green,),
                                                SizedBox(width: 10,),
                                                Text("Click here",
                                                    style: TextStyle(
                                                        fontSize: 14, color:appDarkColor)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )   
              ),
            ],
          ),
        ));
  }
}