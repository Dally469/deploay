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
        'chapters',
        forceRefresh: forceRefresh,
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
            padding: const EdgeInsets.only(left: 14, right: 8, top: 26),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 18,
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
                        Icons.refresh_rounded,
                        onPressed: () => _initData(forceRefresh: true),
                      ),
                      _buildHeaderIcon(Icons.tune_rounded),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,
              margin: const EdgeInsets.only(top: 2, right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: overlayWhiteColor, width: 6),
              ),
              child: Image.asset('assets/images/rwlogo.png'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapters[index].title ?? '',
                    style: const TextStyle(
                      color: appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (widget.id != '1')
                    Text(
                      'Ingingo: ${chapters[index].articleCount ?? 0}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (widget.id == '1')
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        iconColor: appColor,
                        collapsedIconColor: appColor,
                        childrenPadding: const EdgeInsets.only(bottom: 6),
                        title: const Text(
                          'Soma ibisobanuro',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          Text(
                            chapters[index].description ?? '',
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.id != '1')
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
