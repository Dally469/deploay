import 'package:flutter/material.dart';
import 'package:ralga/pages/categories/category-en.dart';
import 'package:ralga/pages/categories/category-fr.dart';
import 'package:ralga/pages/categories/category-rw.dart';
import 'package:ralga/pages/home-en.dart';
import 'package:ralga/pages/home-fr.dart';
import 'package:ralga/pages/home-rw.dart';
import 'package:ralga/pages/infos/information_en.dart';
import 'package:ralga/pages/infos/information_fr.dart';
import 'package:ralga/pages/infos/information_rw.dart';
import 'package:ralga/utils/colors.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", scale: 3),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.only(left: 50, right: 50,top: 40),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Striving for an efficient, effective, transparent and accountable Local Government in Rwanda",
                    textAlign: TextAlign.justify, style: TextStyle(fontSize: 15),),
                  ),
                  SizedBox(height: 60,),
                  Text("Choose language", style: TextStyle(color: appColor),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const InformationEN()),
                          );
                        }),
                        child: Column(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text("English",style: TextStyle(color: appColor, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const InformationRW()),
                          );
                        }),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: overlayColor, width: 3),
                              ),
                              child: Image.asset("assets/images/flagrw.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Kinyarwanda",style: TextStyle(color: appColor, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const InformationFR()),
                          );
                        }),
                        child: Column(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text("Français",style: TextStyle(color: appColor, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
