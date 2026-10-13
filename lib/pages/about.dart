import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ralga/utils/colors.dart';

class AboutSourcesPage extends StatefulWidget {
const AboutSourcesPage({Key? key}) : super(key: key);
  @override
  State<AboutSourcesPage> createState() => _AboutSourcesPageState();
}

class _AboutSourcesPageState extends State<AboutSourcesPage> {
  static const String sourceUrl = 'https://www.ralga.rw/resources/laws';

  Future<void> _openSource() async {
    final uri = Uri.parse(sourceUrl);

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        _showError();
      }
    } catch (_) {
      if (mounted) _showError();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open the link.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: appColor,
        foregroundColor: Colors.white,
        title: const Text(
          'About RALGA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ---------------------------------------------------------
          // APP HEADER
          // ---------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F8F8),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: appColor.withOpacity(0.12),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/rwlogo.png',
                  height: 75,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 15),

                const Text(
                  'RALGA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: appDarkColor,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Rwanda Association of Local Government Authorities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ---------------------------------------------------------
          // ABOUT
          // ---------------------------------------------------------
          _sectionTitle(
            icon: Icons.info_outline_rounded,
            title: 'About RALGA',
          ),

          const Text(
            'RALGA (Rwanda Association of Local Government Authorities) '
            'is an organization representing local government authorities '
            'in Rwanda.',
            style: TextStyle(
              fontSize: 14,
              height: 1.65,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'The RALGA mobile application provides convenient access '
            'to laws, regulations, legal documents, and other information '
            'relevant to local government, land, persons, cities, and '
            'districts in Rwanda.',
            style: TextStyle(
              fontSize: 14,
              height: 1.65,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 28),

          // ---------------------------------------------------------
          // OFFICIAL SOURCE
          // ---------------------------------------------------------
          _sectionTitle(
            icon: Icons.language_rounded,
            title: 'Official Information Source',
          ),

          const Text(
            'Legal and government-related information available through '
            'the application is sourced from publicly available resources '
            'provided through RALGA.',
            style: TextStyle(
              fontSize: 14,
              height: 1.65,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 15),

          InkWell(
            onTap: _openSource,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF8F7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: appColor.withOpacity(0.20),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.public_rounded,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Official RALGA Laws Resource',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: appDarkColor,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'www.ralga.rw/resources/laws',
                          style: TextStyle(
                            fontSize: 13,
                            color: appColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.open_in_new_rounded,
                    color: appColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ---------------------------------------------------------
          // DISCLAIMER
          // ---------------------------------------------------------
          _sectionTitle(
            icon: Icons.gavel_rounded,
            title: 'Disclaimer',
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E9),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE6CC76),
              ),
            ),
            child: const Text(
              'This application provides access to publicly available '
              'legal and government-related information for informational '
              'and educational purposes.\n\n'
              'The information provided through the application does not '
              'replace official government publications or the original '
              'legal documents.\n\n'
              'Users are encouraged to verify laws and regulations using '
              'the original official sources, particularly when relying '
              'on information for legal or official purposes.\n\n'
              'RALGA does not provide legal advice. The information '
              'provided through the application should not be considered '
              'a substitute for professional legal advice or official '
              'legal publications.',
              style: TextStyle(
                fontSize: 13,
                height: 1.65,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ---------------------------------------------------------
          // SOURCE VERIFICATION
          // ---------------------------------------------------------
          _sectionTitle(
            icon: Icons.verified_outlined,
            title: 'Source Verification',
          ),

          const Text(
            'For the latest laws, regulations, and legal resources, '
            'users can visit the official RALGA resource:',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: _openSource,
            child: const Text(
              'https://www.ralga.rw/resources/laws',
              style: TextStyle(
                fontSize: 14,
                color: appColor,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ---------------------------------------------------------
          // ORGANIZATION
          // ---------------------------------------------------------
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  'Rwanda Association of Local Government Authorities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: appDarkColor,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'RALGA',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'RALGA Mobile Application',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black38,
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  static Widget _sectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: appColor,
          ),

          const SizedBox(width: 8),

          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: appDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}