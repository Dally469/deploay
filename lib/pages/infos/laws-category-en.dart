import 'package:flutter/material.dart';
import 'package:ralga/pages/categories/category-en.dart';
import 'package:ralga/pages/home-kgl-en.dart';
import 'package:ralga/utils/colors.dart';

class LawsCategoryEN extends StatefulWidget {
  const LawsCategoryEN({Key? key}) : super(key: key);

  @override
  State<LawsCategoryEN> createState() => _LawsCategoryENState();
}

class _LawsCategoryENState extends State<LawsCategoryEN> {
  PreferredSizeWidget _appBar(double height) => PreferredSize(
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
                            'Laws',
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

  Widget _buildLawCard({
    required String title,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset('assets/images/rwlogo.png'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: appDarkColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.arrow_forward_rounded,
                    size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  actionLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.black38,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: const Color(0xFFF6F8F9),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 6, 8, 10),
            child: Text(
              'Choose what you want to explore',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildLawCard(
            title: 'Law governing the District',
            actionLabel: 'Click here',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryEN()),
              );
            },
          ),
          _buildLawCard(
            title: 'Law governing the City of Kigali',
            actionLabel: 'Click here',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeKGL_EN()),
              );
            },
          ),
        ],
      ),
    );
  }
}
