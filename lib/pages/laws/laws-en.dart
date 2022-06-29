import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ralga/api/http_request.dart';
import 'package:ralga/models/article_model.dart';
import 'package:ralga/models/chapter_model.dart';
import 'package:ralga/utils/colors.dart';
import 'package:ralga/widgets/app-icon.dart';
import 'package:ralga/widgets/expandable-text.dart';
import 'package:path_provider/path_provider.dart';

class LawsEN extends StatefulWidget {
  final String id, title;
  const LawsEN(this.id, this.title);

  @override
  State<LawsEN> createState() => _LawsENState();
}

class _LawsENState extends State<LawsEN> {
  var laws = <Article>[];

  @override
  void initState() {
    super.initState();
    _initData();

    print("id: " + widget.id.toString());
  }


  _initData() async {

    String fileName = widget.id+"articleDataEN.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("Loading from CACHE");

      var jsonData = file.readAsStringSync();
      setState(() {
        Iterable list1 = json.decode(jsonData);
        laws = list1.map((model) => Article.fromJson(model)).toList();

        print(list1);

      });
      //return Category.fromJson(json.decode(jsonData));
    } else {
      print("Loading from API");

      await HttpRequest()
          .getPublicData("articleRetrieveEN/" + widget.id)
          .then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          laws = list.map((model) => Article.fromJson(model)).toList();

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
                  appColor,
                  appColor,
                ]),
              ), // Background
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 25),
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
                            width: 220,
                            child: Text(widget.title,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          AppIcon(icon: Icons.search),
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
              laws.isEmpty
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
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: laws.length,
                          itemBuilder: (context, position) {
                            return _buildLawsItem(position);
                          }),
                    ),
            ],
          ),
        ));
  }

  Widget _buildLawsItem(int index) {
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
              padding: EdgeInsets.only(left: 0, right: 5, top: 5),
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
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: overlayWhiteColor, width: 6),
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
                                width: 220,
                                child: ExpandablePanel(
                                  header: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(laws[index].title, style: TextStyle(fontSize: 16, color: appDarkColor),),
                                  ),
                                  collapsed: Text(' ', softWrap: true, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,),
                                  expanded: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(laws[index].law == null ? "Ntayo" : laws[index].law, softWrap: true, textAlign: TextAlign.justify),
                                  ),
                                  
                                ),
                              ),
                             
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
