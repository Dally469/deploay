import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

import '../../widgets/app-icon.dart';
class UserManualRW extends StatelessWidget {
  const UserManualRW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    _appBar(height) => PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, height + 30),
      child: Stack(
        children: <Widget>[
          Container(
            height: height + 20,
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
                          child: Text("UKO IKORESHWA",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: appColor,
                                  fontSize: 22,
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

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 1: Hitamo ururimi",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                Image.asset("assets/images/one.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1. English",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2.	Kinyarwanda ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3.	Francais ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 2: Hitamo igice ushaka kureba ",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
                  child: Text("Kanda hano uhitemo igice wasoma kugaragara mu ifoto ikurikira",textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
                ),
                Image.asset("assets/images/two.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1. Politiki Ubuyobozi Bwegereye abaturage",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2. Amategeko",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3. Uko ikoreshwa",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(" Step 3: Guhitamo dokima",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
                  child: Text("Fungura dokima mu ishakiro ubashe kuyisoma",textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
                ),
                Image.asset("assets/images/six.jpg",  scale: 3,),


                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1. Hitamo dokima ugindeye ku mwaka",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2. Sangiza angiza abantu dokima iri muri PDF ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),

                SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 4: Hitamo amakuru",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                Image.asset("assets/images/three.jpg",  scale: 3,),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 7),
                  child: Text("Ku mategeko kandi ku kamenyetso kareba hasi kugira ngo usome amategeko",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 10,),
                Image.asset("assets/images/four.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 5: Reba amakuru",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),

                SizedBox(height: 10,),
                Image.asset("assets/images/five.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                  child: Text("Ubu noneho wabasha gusoma amategeko",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 6: Gusubira ahabanza",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 7: Sangiza abandi dokima iri muri PDF ",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                SizedBox(height: 70,),
              ],
            ),
          ),
        ));
  }


}
