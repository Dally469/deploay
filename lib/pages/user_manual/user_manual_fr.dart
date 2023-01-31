import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

import '../../widgets/app-icon.dart';
class UserManualFR extends StatelessWidget {
  const UserManualFR({Key? key}) : super(key: key);

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
                          child: Text("Manuel de l'Utilisateur",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: appColor,
                                  fontSize: 26,
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
                  child: Text("Step 1: Choisir la langue ",textAlign: TextAlign.center, style: TextStyle(
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
                  child: Text("2.  Kinya ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3.  Francais ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 2: Choisir la rubrique",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
                  child: Text("Cliquez sur la section qui vous intéresse et indiquée dans l'image ci-dessous",textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
                ),
                Image.asset("assets/images/two.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1. Décentralisation ",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2. Catégorie Droit",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("3. Manuel de l'Utilisateur",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(" Step 3: Choisir les documents",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
                  child: Text("Cliquez sur le document dans la table des matières pour accéder à l'intégralité de son contenu",textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
                ),
                Image.asset("assets/images/six.jpg",  scale: 3,),


                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("1. Sélectionner le document selon l'année",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2. Partage des documents en PDF",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),

                SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 4: Choisir le contenu",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),
                Image.asset("assets/images/three.jpg",  scale: 3,),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 7),
                  child: Text("Pour les lois, cliquez sur la flèche pour afficher le contenu sous la rubrique sélectionnée",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                SizedBox(height: 10,),
                Image.asset("assets/images/four.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 5: Affichage du contenu",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),

                SizedBox(height: 10,),
                Image.asset("assets/images/five.jpg",  scale: 3,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                  child: Text("Vous pouvez maintenant lire les informations que vous recherchez",textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 6: Aller aux pages précédentes",textAlign: TextAlign.center, style: TextStyle(
                      color: appColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
                ),const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Step 7: Partage des documents en PDF",textAlign: TextAlign.center, style: TextStyle(
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

