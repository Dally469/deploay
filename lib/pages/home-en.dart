import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/chapter_model.dart'; // Correct path
import 'package:ralga/pages/laws/laws-en.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:expandable/expandable.dart'; // Keep this, it's used
import 'package:path_provider/path_provider.dart';

class HomeEN extends StatefulWidget {
  final String id, title;
  const HomeEN(this.id, this.title, {Key? key}) : super(key: key); // Add key

  @override
  State<HomeEN> createState() => _HomeENState();
}

class _HomeENState extends State<HomeEN> {
  List<Chapters> chapters = []; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    String fileName =
        "${widget.id}chaptersDataEN.json"; // Use string interpolation
    Directory dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");

    try {
      if (file.existsSync()) {
        print("Loading from CACHE");
        String jsonData = file.readAsStringSync();
        List<dynamic> list1 = json.decode(jsonData);
        setState(() {
          chapters = list1.map((model) => Chapters.fromJson(model)).toList();
        });
      } else {
        print("Loading from API");
        final response = await HttpRequest()
            .getPublicData("chapters/withArticleCount/${widget.id}/en");

        if (response.statusCode == 200) {
          String responseBody = response.body; // Get the response body
          List<dynamic> list = json.decode(responseBody);
          setState(() {
            chapters = list.map((model) => Chapters.fromJson(model)).toList();
          });

          await file.writeAsString(responseBody,
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
                        width: 150,
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
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      AppIcon(icon: Icons.search),
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
                    if (widget.id != "1") {
                      // Use != instead of toString() !=
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawsEN(
                            chapters[position].id.toString(),
                            chapters[position].description ??
                                '', //Use description here
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
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the top
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
                      chapters[index].title ?? '', //Use title, handle null
                      style: TextStyle(color: appDarkColor),
                    ),
                    const SizedBox(height: 4),
                    if (widget.id != "1")
                      Text(
                        "Articles : ${chapters[index].articleCount ?? 0}", //handle null
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black45),
                      ),
                    if (widget.id ==
                        "1") // Use if instead of ternary inside Text
                      ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            chapters[index].title ??
                                '', //Use title, handle null
                            style: const TextStyle(
                                fontSize: 16, color: appDarkColor),
                          ),
                        ),
                        collapsed: const Text(
                          " ",
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            chapters[index].description ??
                                '', // Use description, handle null
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ),
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
