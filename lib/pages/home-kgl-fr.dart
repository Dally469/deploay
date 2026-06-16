import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/category_model.dart'; // Correct path
import 'package:ralga/pages/kgl/kgl-home-fr.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';

import 'package:path_provider/path_provider.dart';

class HomeKGL_FR extends StatefulWidget {
  const HomeKGL_FR({Key? key}) : super(key: key);

  @override
  State<HomeKGL_FR> createState() => _HomeKGL_FRState();
}

class _HomeKGL_FRState extends State<HomeKGL_FR> {
  List<Category> categories = []; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData({bool forceRefresh = false}) async {
    String fileName = "categoryDataKglFR.json";
    Directory dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName"); // Use string interpolation

    try {
      if (!forceRefresh && file.existsSync()) {
        print("Loading from CACHE");
        String jsonData = file.readAsStringSync();
        final decoded = json.decode(jsonData);
        setState(() {
          categories = Category.listFromResponse(decoded);
        });
      } else {
        print("Loading from API");
        final response =
            await HttpRequest().getPublicData("retrieveCategoriesKglFR", forceRefresh: forceRefresh);

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          setState(() {
            categories = Category.listFromResponse(decoded);
          });
          await file.writeAsString(response.body,
              flush: true, mode: FileMode.write);
        } else {
          print('Request failed with status: ${response.statusCode}.');
          // Handle the error appropriately (e.g., show an error message)
        }
      }
    } catch (e) {
      print("Error loading data: $e");
      // Handle the error appropriately (e.g., show an error message)
    }
  }

  PreferredSizeWidget _appBar(double height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Container(
          height: height + 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              appDarkColor,
              appDarkColor,
            ]),
          ), // Background
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
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
                        width: 190,
                        child: const Text("Sommaire",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
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
      body: categories.isEmpty
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
              itemCount: categories.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KglHomeFR(
                          categories[position].id.toString(),
                          categories[position].title.toString(),
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryItem(position),
                );
              },
            ),
    );
  }

  Widget _buildCategoryItem(int index) {
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
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: overlayWhiteColor, width: 3),
              ),
              child: Image.asset("assets/images/rwlogo.png"),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories[index].title ?? '',
                    style: TextStyle(
                      color: appDarkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categories[index].lawNo ?? '', // Correct field access
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categories[index].description ?? '',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                  const SizedBox(height: 4),
                  Text(
                      categories[index].id == "1"
                          ? "Articles : ${categories[index].chaptersCount ?? 0}"
                          : "Chapitres : ${categories[index].chaptersCount ?? 0}",
                      style:
                          const TextStyle(fontSize: 14, color: appDarkColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
