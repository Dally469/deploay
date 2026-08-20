import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/category_model.dart';
import 'package:ralga/pages/home-fr.dart';
import 'package:ralga/utils/colors.dart';

class CategoryFR extends StatefulWidget {
  const CategoryFR({Key? key}) : super(key: key);

  @override
  State<CategoryFR> createState() => _CategoryFRState();
}

class _CategoryFRState extends State<CategoryFR> {
  List<Category> categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    const String fileName = 'categoryDataFR_v2.json';
    final Directory dir = await getTemporaryDirectory();
    final File file = File('${dir.path}/$fileName');

    try {
      if (!forceRefresh && file.existsSync()) {
        final String jsonData = file.readAsStringSync();
        final decoded = json.decode(jsonData);
        setState(() {
          categories = Category.listFromResponse(decoded);
          _isLoading = false;
        });
      } else {
        final response = await HttpRequest()
            .getPublicData(
          'categories/lang/fr',
          forceRefresh: forceRefresh,
          cacheKey: 'categories_fr_v1',
        );

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          setState(() {
            categories = Category.listFromResponse(decoded);
            _isLoading = false;
          });
          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write);
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Echec du chargement (${response.statusCode}).';
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Impossible de charger les donnees. Reessayez.';
        });
      }
    }
  }

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
                            'Lois',
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
                      _buildHeaderIcon(
                        icon: Icons.refresh_rounded,
                        onTap: () => _initData(forceRefresh: true),
                      ),
                      _buildHeaderIcon(
                        icon: Icons.tune_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildHeaderIcon({required IconData icon, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, color: whiteColor, size: 20),
        onPressed: onTap,
        splashRadius: 20,
      ),
    );
  }

  String _countText(Category category) {
    final int count = category.chaptersCount ?? 0;
    if (category.id?.toString() == '1') return 'Articles: $count';
    return 'Chapitres: $count';
  }

   Widget _buildCategoryItem(int index) {
    final category = categories[index];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Logo ──────────────────────────────────────────
            Container(
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child:
                  Image.asset('assets/images/rwlogo.png', fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),

            // ── Title + law number + count ────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title ?? '',
                    style: const TextStyle(
                      color: appDarkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
             
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 13,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _countText(category),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Chevron ───────────────────────────────────────
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: appDarkColor,
                size: 18,
              ),
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
      body: _isLoading
          ? const Center(
              child: SpinKitDoubleBounce(
                color: appColor,
                size: 70,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => _initData(forceRefresh: true),
                          child: const Text('Reessayer'),
                        ),
                      ],
                    ),
                  ),
                )
              : categories.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Aucune donnee disponible.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _initData(forceRefresh: true),
                              child: const Text('Actualiser'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeFR(
                          categories[index].id.toString(),
                          categories[index].title.toString(),
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryItem(index),
                );
              },
            ),
    );
  }
}
