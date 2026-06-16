import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

class UserManualFR extends StatelessWidget {
  const UserManualFR({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context, double height) =>
      PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 82),
        child: Container(
          height: height + 82,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [appDarkColor, Color(0xFF008C8B)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8, top: 26),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: whiteColor,
                            size: 19,
                          ),
                          splashRadius: 20,
                        ),
                        const Expanded(
                          child: Text(
                            "Manuel de l'utilisateur",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      _buildHeaderIcon(Icons.search_rounded),
                      _buildHeaderIcon(Icons.tune_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, color: whiteColor, size: 20),
        onPressed: () {},
        splashRadius: 20,
      ),
    );
  }

  Widget _stepCard({
    required String title,
    required String image,
    required String helper,
    required List<String> bullets,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: appDarkColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            helper,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                line,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context, AppBar().preferredSize.height),
      backgroundColor: const Color(0xFFF6F8F9),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 6, 8, 10),
            child: Text(
              'Suivez ces etapes pour utiliser l application',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _stepCard(
            title: 'Etape 1: Choisir la langue',
            image: 'assets/images/one.jpg',
            helper: 'Selectionnez la langue preferee sur le premier ecran.',
            bullets: const ['1. English', '2. Kinyarwanda', '3. Francais'],
          ),
          _stepCard(
            title: 'Etape 2: Choisir la rubrique',
            image: 'assets/images/two.jpg',
            helper: 'Ouvrez la section qui vous interesse.',
            bullets: const ['1. Decentralisation', '2. Categorie de lois', '3. Manuel utilisateur'],
          ),
          _stepCard(
            title: 'Etape 3: Choisir le document',
            image: 'assets/images/six.jpg',
            helper: 'Choisissez un document depuis la table des matieres.',
            bullets: const ['1. Selection par annee', '2. Partage en PDF'],
          ),
          _stepCard(
            title: 'Etape 4: Ouvrir le contenu',
            image: 'assets/images/three.jpg',
            helper: 'Pour les lois, touchez la fleche pour afficher les details.',
            bullets: const ['1. Depliez la rubrique pour lire le contenu'],
          ),
          _stepCard(
            title: 'Etape 5: Lire et partager',
            image: 'assets/images/five.jpg',
            helper: 'Lisez les informations et partagez les documents si besoin.',
            bullets: const [
              '1. Revenez aux pages precedentes',
              '2. Partagez le document en PDF'
            ],
          ),
        ],
      ),
    );
  }
}
