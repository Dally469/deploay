import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/chapter_model.dart'; // Corrected path
import 'package:ralga/pages/laws/laws-en.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:expandable/expandable.dart'; // Keep this
import 'package:path_provider/path_provider.dart';

class KglHomeEN extends StatefulWidget {
  final String id, title;
  const KglHomeEN(this.id, this.title, {Key? key}) : super(key: key);

  @override
  State<KglHomeEN> createState() => _KglHomeENState();
}

class _KglHomeENState extends State<KglHomeEN> {
  List<Chapters> chapters = []; // Initialized

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    String fileName =
        "${widget.id}chaptersKglDataEN.json"; // String interpolation
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
            .getPublicData("chapters/withArticleCount/${widget.id}/en", forceRefresh: forceRefresh);

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          setState(() {
            chapters = Chapters.listFromResponse(decoded);
          });

          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write); // Await
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
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Container(
          height: height + 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              appColor,
              appColor,
            ]),
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
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 23),
                  child: Row(
                    children: [
                      GestureDetector(
                            onTap: () => _initData(forceRefresh: true),
                            child: AppIcon(icon: Icons.refresh),
                          ),
                      AppIcon(icon: Icons.settings),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

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
                    if (widget.id != "3") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawsEN(
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

  Widget _buildShopItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0XFFe8e8e8),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: overlayWhiteColor, width: 6),
              ),
              child: Image.asset("assets/images/rwlogo.png"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapters[index].title ?? '',
                      style: const TextStyle(color: appDarkColor),
                    ),
                    const SizedBox(height: 4),
                    if (widget.id != "3")
                      ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            chapters[index].title ?? '',
                            style: const TextStyle(
                                fontSize: 16, color: appDarkColor),
                          ),
                        ),
                        collapsed: const Text(
                          ' ',
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            chapters[index].description ?? '',
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    if (widget.id == "3")
                      Text(
                        "Articles : ${chapters[index].articleCount ?? 0}",
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black45),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
