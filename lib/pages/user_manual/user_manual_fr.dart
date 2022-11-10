import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

import '../../widgets/app-icon.dart';
class UserManualFR extends StatelessWidget {
  const UserManualFR({Key? key}) : super(key: key);

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
                          child: Text("Manuel de l'Utilisateur",
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
                  child: Text("Cette image ci-dessus 1 avec la zone ombrée, leur description est ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1: Utiliser l'application en langue anglaise",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2: Utiliser l'application en langue kinyarwanda",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3: Utiliser l'application en langue française",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_2.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cette image ci-dessus 2 avec la zone ombrée, leur description est ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1: Cliquez pour lire Décentralisation",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2: Cliquez pour lire la catégorie Loi et leurs informations",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3: Cliquez pour lire le manuel d'utilisation",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_3.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cette image ci-dessus 3 avec la zone ombrée, leur description est ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cliquez pour lire voir tous les articles appartient à la loi organique régissant les élections",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),

                SizedBox(height: 50,),
                Image.asset("assets/images/phones_4.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cette image ci-dessus 4 avec la zone ombrée, leur description est ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cliquez sur l'icône flèche vers le bas pour lire l'article sélectionné plus d'informations",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                Image.asset("assets/images/phones_5.jpg",  scale: 2,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Cette image ci-dessus 5 avec la zone ombrée, leur description est ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Maintenant que vous lisez les informations, la flèche vers le bas est cliqué sur l'article sélectionné plus d'informations",textAlign: TextAlign.center, style: TextStyle(
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
