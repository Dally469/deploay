import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';

class UserManualEN extends StatelessWidget {
  const UserManualEN({Key? key}) : super(key: key);

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
                            'User Manual',
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
              'Follow these steps to use the app',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _stepCard(
            title: 'Step 1: Choose Language',
            image: 'assets/images/one.jpg',
            helper: 'Select your preferred language on the first screen.',
            bullets: const ['1. English', '2. Kinyarwanda', '3. Francais'],
          ),
          _stepCard(
            title: 'Step 2: Choose Section',
            image: 'assets/images/two.jpg',
            helper: 'Open the section that matches your need.',
            bullets: const ['1. Decentralization', '2. Law category', '3. User manual'],
          ),
          _stepCard(
            title: 'Step 3: Choose Document',
            image: 'assets/images/six.jpg',
            helper: 'Pick a document from the table of contents.',
            bullets: const ['1. Select document by year', '2. Share document as PDF'],
          ),
          _stepCard(
            title: 'Step 4: Open Content',
            image: 'assets/images/three.jpg',
            helper: 'For laws, tap the arrow to expand section content.',
            bullets: const ['1. Expand the selected heading to read details'],
          ),
          _stepCard(
            title: 'Step 5: Read and Share',
            image: 'assets/images/five.jpg',
            helper: 'Read the information and share documents when needed.',
            bullets: const [
              '1. Use back to return to previous pages',
              '2. Share the document in PDF'
            ],
          ),
        ],
      ),
    );
  }
}
