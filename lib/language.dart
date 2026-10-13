import 'package:flutter/material.dart';
import 'package:ralga/pages/about.dart'; // adjust path if needed
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
  Widget _languageTile({
    required String title,
    required String subtitle,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: appDarkColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 15, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _flag(String asset) {
    return Container(
      width: 36,
      height: 36,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: overlayColor, width: 2.5),
      ),
      child: Image.asset(asset),
    );
  }

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE9F6F6), Color(0xFFF8FBFB)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -10,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 127, 126, 0.09),
                  ),
                ),
              ),
              Positioned(
                bottom: -45,
                left: -25,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 127, 126, 0.08),
                  ),
                ),
              ),
              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 0.96, end: 1),
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 430),
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.75),
                          width: 1.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.09),
                            blurRadius: 24,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/logo.png', scale: 3.2),
                          const SizedBox(height: 14),
                          const Text(
                            'Rwanda Association of Local Government Authorities',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appDarkColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Striving for an efficient, effective, transparent and accountable Local Government in Rwanda',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.5,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Choose Language',
                              style: TextStyle(
                                color: appColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _languageTile(
                            title: 'English',
                            subtitle: 'Open in English',
                            icon: _flag('assets/images/flaguk.png'),
                            onTap: () => _open(const InformationEN()),
                          ),
                          _languageTile(
                            title: 'Kinyarwanda',
                            subtitle: 'Fungura mu Kinyarwanda',
                            icon: _flag('assets/images/flagrw.png'),
                            onTap: () => _open(const InformationRW()),
                          ),
                          _languageTile(
                            title: 'Français',
                            subtitle: 'Ouvrir en Français',
                            icon: _flag('assets/images/flagfr.png'),
                            onTap: () => _open(const InformationFR()),
                          ),

                          const SizedBox(height: 4),

                          // About / Source / Disclaimer link
                          InkWell(
                            onTap: () => _open(const AboutSourcesPage()),
                            borderRadius: BorderRadius.circular(10),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 17,
                                    color: appColor,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'About  •  Source  •  Disclaimer',
                                    style: TextStyle(
                                      color: appColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      decorationColor: appColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}