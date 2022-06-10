import 'dart:convert';
import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/category_model.dart';
import 'package:ralga/models/chapter_model.dart';
import 'package:ralga/pages/home-en.dart';
import 'package:ralga/pages/home-rw.dart';
import 'package:ralga/pages/kgl/kgl-home-en.dart';
import 'package:ralga/pages/kgl/kgl-home-rw.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:ralga/widgets/big-text.dart';
import 'package:ralga/widgets/expandable-text.dart';
import 'package:path_provider/path_provider.dart';

class HomeKGL_RW extends StatefulWidget {
  const HomeKGL_RW({Key? key}) : super(key: key);

  @override
  State<HomeKGL_RW> createState() => _HomeKGL_RWState();
}

class _HomeKGL_RWState extends State<HomeKGL_RW> {
  var categories = <Category>[];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {

    String fileName = "categoryDataKglRW.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("Loading from CACHE");

      var jsonData = file.readAsStringSync();
      setState(() {
        Iterable list1 = json.decode(jsonData);
        categories = list1.map((model) => Category.fromJson(model)).toList();

        print(list1);

      });
      //return Category.fromJson(json.decode(jsonData));
    } else {
      print("Loading from API");

      await HttpRequest()
          .getPublicData("retrieveCategoriesKglRW")
          .then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          categories = list.map((model) => Category.fromJson(model)).toList();

          print(list);
          //save json in local file
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);
        });
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              height: height + 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  appDarkColor,
                  appDarkColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (() => Navigator.pop(context)),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            ),
                          ),
                          Container(
                            width: 190,
                            child: Text("Iburiro ",
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
                      margin: EdgeInsets.only(top: 23),
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

            Container(), // Required some widget in between to float AppBar
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(AppBar().preferredSize.height),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              categories.isEmpty
                  ? Container(
                      height: 600,
                      margin: EdgeInsets.only(
                          bottom: 10, left: 8, right: 8, top: 10),
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: appColor,
                          size: 70,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(
                          bottom: 10, left: 8, right: 8, top: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KglHomeRW(
                                              categories[position].id,
                                              categories[position].title,
                                            )),
                                  );
                                }),
                                child: _buildCategoryItem(position));
                          }),
                    ),
            ],
          ),
        ));
  }

  Widget _buildCategoryItem(int index) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFe8e8e8),
                      offset: Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: Container(
              padding: EdgeInsets.only(left: 0, right: 3, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: overlayWhiteColor, width: 3),
                        ),
                        child: Image.asset("assets/images/rwlogo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      categories[index].title,
                                      style: TextStyle(
                                          color: appDarkColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      categories[index].law_no,
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(categories[index].description,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black45)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                  categories[index].id == "1"
                                      ? "Ingingo : " +
                                          categories[index].chapters_count
                                      : "Imitwe : " +
                                          categories[index].chapters_count,
                                  style: TextStyle(
                                      fontSize: 14, color: appDarkColor)),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
