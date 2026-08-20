import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/chapter_model.dart'; // Corrected path
import 'package:ralga/pages/laws/laws-fr.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:expandable/expandable.dart'; // Keep this import
import 'package:path_provider/path_provider.dart';

class HomeFR extends StatefulWidget {
  final String id, title;
  const HomeFR(this.id, this.title, {Key? key}) : super(key: key); // Add key

  @override
  State<HomeFR> createState() => _HomeFRState();
}

class _HomeFRState extends State<HomeFR> {
  List<Chapters> chapters = []; // Initialized as an empty list

  @override
  void initState() {
    super.initState();
    _initData();
    print(widget.id);
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    String fileName = "${widget.id}chaptersDataFR_v2.json"; // String interpolation
    Directory dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");

    try {
      if (!forceRefresh && file.existsSync()) {
        print("Loading from CACHE");
        String jsonData = file.readAsStringSync();
        final decoded = json.decode(jsonData);
        setState(() {
          chapters = Chapters.listFromResponse(decoded);
        });
      } else {
        print("Loading from API");
        final response = await HttpRequest()
            .getPublicData(
          "chapters/category/${widget.id}",
          forceRefresh: forceRefresh,
          cacheKey: "chapters_fr_${widget.id}_v1",
        );

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          setState(() {
            chapters = Chapters.listFromResponse(decoded);
          });

          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write); // Use await
        } else {
          print('Request failed with status: ${response.statusCode}.');
          // Handle the error appropriately
        }
      }
    } catch (e) {
      print("Error loading data: $e");
      // Handle the error appropriately
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
                            maxLines: 2,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      backgroundColor: whiteColor,
      body: chapters.isEmpty
          ? Center(
              child: SizedBox(
                height: 600,
                child: Center(
                  child: SpinKitDoubleBounce(
                    color: appColor,
                    size: 70,
                  ),
                ),
              ),
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: chapters.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    if (widget.id != "1") {
                      // Use != directly
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawsFR(
                            chapters[position].id.toString(),
                            chapters[position].description ??
                                '', // Use description
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
                        '${chapter.articleCount ?? 0} Articles',
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
