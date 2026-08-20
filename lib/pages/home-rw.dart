import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/chapter_model.dart';
import 'package:ralga/pages/laws/laws-rw.dart';
import 'package:ralga/utils/colors.dart';

class HomeRW extends StatefulWidget {
  final String id, title;
  const HomeRW(this.id, this.title, {Key? key}) : super(key: key);

  @override
  State<HomeRW> createState() => _HomeRWState();
}

class _HomeRWState extends State<HomeRW> {
  List<Chapters> chapters = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final response = await HttpRequest().getPublicData(
        'chapters/category/${widget.id}',
        forceRefresh: forceRefresh,
        cacheKey: 'chapters_rw_${widget.id}_v1',
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        setState(() {
          chapters = Chapters.listFromResponse(decoded);
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _errorMessage = 'Request failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
        _errorMessage = 'Failed to load data. Please try again.';
      });
      debugPrint('Error loading data: $e');
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
              colors: [appColor, Color(0xFF008C8B)],
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
            padding: const EdgeInsets.only(left: 14, right: 8, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 22),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: whiteColor, size: 19),
                          splashRadius: 20,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
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
                  margin: const EdgeInsets.only(top: 26),
                  child: Row(
                    children: [
                      _buildHeaderIcon(
                        Icons.refresh_rounded,
                        onPressed: () => _initData(forceRefresh: true),
                      ),
                      // _buildHeaderIcon(Icons.tune_rounded),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildHeaderIcon(IconData icon, {VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, color: whiteColor, size: 20),
        onPressed: onPressed ?? () {},
        splashRadius: 20,
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: SpinKitDoubleBounce(
          color: appColor,
          size: 62,
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 44, color: appColor),
              const SizedBox(height: 10),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => _initData(forceRefresh: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  foregroundColor: whiteColor,
                ),
                child: const Text('Subiramo'),
              ),
            ],
          ),
        ),
      );
    }

    if (chapters.isEmpty) {
      return const Center(
        child: Text(
          'Nta bisobanuro bihari.',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      );
    }

    return RefreshIndicator(
      color: appColor,
      onRefresh: () => _initData(forceRefresh: true),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: chapters.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              if (widget.id != '1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawsRW(
                      chapters[position].id.toString(),
                      chapters[position].description ?? '',
                    ),
                  ),
                );
              }
            },
            child: _buildShopItem(position),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: const Color(0xFFF6F8F9),
      body: _buildBody(),
    );
  }

  Widget _buildShopItem(int index) {
  final chapter = chapters[index];

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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Image.asset('assets/images/rwlogo.png', fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),

          // Title + article count / description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.title ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: appDarkColor,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                if (widget.id != "1") ...[
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.article_outlined, size: 13, color: Colors.black38),
                      const SizedBox(width: 4),
                      Text(
                        '${chapter.articleCount ?? 0} Ingingo',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                if (widget.id == "1" && (chapter.description ?? '').isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    chapter.description ?? '',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF718096),
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Chevron arrow
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: Colors.black26,
          ),
        ],
      ),
    ),
  );
}
}
