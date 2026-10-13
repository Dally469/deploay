// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:ralga/api/http_request.dart';
// import 'package:ralga/models/article_model.dart';
// import 'package:ralga/utils/colors.dart';

// class LawsEN extends StatefulWidget {
//   final String id;
//   final String title;
//   const LawsEN(this.id, this.title, {Key? key}) : super(key: key);

//   @override
//   State<LawsEN> createState() => _LawsENState();
// }

// class _LawsENState extends State<LawsEN> {
//   List<Article> laws = [];
//   bool _isLoading = true;
//   String? _errorMessage;
//   int _expandedIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     _initData();
//   }

//   Future<void> _initData({bool forceRefresh = false}) async {
//     if (mounted) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });
//     }

//     final String fileName = '${widget.id}_articleDataEN_v2.json';
//     final Directory dir = await getTemporaryDirectory();
//     final File file = File('${dir.path}/$fileName');

//     try {
//       if (!forceRefresh && file.existsSync()) {
//         final String jsonData = file.readAsStringSync();
//         final decoded = json.decode(jsonData);

//         if (mounted) {
//           setState(() {
//             laws = Article.listFromResponse(decoded);
//             _sortArticles();
//             _isLoading = false;
//           });
//         }
//       } else {
//         final response = await HttpRequest().getPublicData(
//           'articles/chapter/${widget.id}',
//           forceRefresh: forceRefresh,
//           cacheKey: 'laws_en_${widget.id}_v1',
//         );

//         if (response.statusCode == 200) {
//           final decoded = json.decode(response.body);
//           if (mounted) {
//             setState(() {
//               laws = Article.listFromResponse(decoded);
//               _sortArticles();
//               _isLoading = false;
//             });
//           }
//           await file.writeAsString(response.body, flush: true, mode: FileMode.write);
//         } else {
//           if (mounted) {
//             setState(() {
//               _isLoading = false;
//               _errorMessage = 'Failed to load laws (${response.statusCode}).';
//             });
//           }
//         }
//       }
//     } catch (_) {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _errorMessage = 'Unable to load laws. Please try again.';
//         });
//       }
//     }
//   }

//   void _sortArticles() {
//     laws.sort((a, b) {
//       final int numA = _articleNumber(a);
//       final int numB = _articleNumber(b);
//       return numA.compareTo(numB);
//     });
//   }

//   int _articleNumber(Article article) {
//     final match = RegExp(
//       r'\b(?:article|ingingo(?:\s+ya)?)\s*(\d+)',
//       caseSensitive: false,
//     ).firstMatch(article.title);
//     return int.tryParse(match?.group(1) ?? '') ??
//         int.tryParse(article.id) ??
//         1 << 30;
//   }


//   PreferredSizeWidget _appBar(double height) => PreferredSize(
//         preferredSize: Size(MediaQuery.of(context).size.width, height + 82),
//         child: Container(
//           height: height + 82,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [appDarkColor, Color(0xFF008C8B)],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Color.fromRGBO(0, 0, 0, 0.15),
//                 blurRadius: 10,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 14, right: 8, top: 26),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 22),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: const Icon(
//                             Icons.arrow_back_ios_new_rounded,
//                             color: whiteColor,
//                             size: 19,
//                           ),
//                           splashRadius: 20,
//                         ),
//                         Expanded(
//                           child: Text(
//                             widget.title,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: whiteColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 0.15,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 16),
//                   child: Row(
//                     children: [
//                       _buildHeaderIcon(
//                         icon: Icons.refresh_rounded,
//                         onTap: () => _initData(forceRefresh: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Widget _buildHeaderIcon({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         color: const Color.fromRGBO(255, 255, 255, 0.18),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: whiteColor, size: 20),
//         onPressed: onTap,
//         splashRadius: 20,
//       ),
//     );
//   }

//   Widget _buildLawsItem(int index) {
//     final Article item = laws[index];
//     final String content = item.law.isEmpty ? '<p>No details available.</p>' : item.law;
//     final bool isExpanded = _expandedIndex == index;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _expandedIndex = isExpanded ? -1 : index;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.white,
//           border: Border.all(
//             color: isExpanded ? appDarkColor.withOpacity(0.3) : const Color(0xFFE6EDF2),
//             width: isExpanded ? 1.5 : 1.0,
//           ),
//           boxShadow: isExpanded
//               ? [
//                   BoxShadow(
//                       color: appDarkColor.withOpacity(0.08),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4))
//                 ]
//               : [
//                   BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2))
//                 ],
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 36,
//                     width: 36,
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF0F4F8),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset('assets/images/rwlogo.png', fit: BoxFit.contain),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       item.title,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: appDarkColor,
//                         fontWeight: FontWeight.w600,
//                         height: 1.3,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   AnimatedRotation(
//                     turns: isExpanded ? 0.5 : 0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Container(
//                       height: 28,
//                       width: 28,
//                       decoration: BoxDecoration(
//                         color: isExpanded ? appDarkColor : const Color(0xFFF0F4F8),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(
//                         Icons.keyboard_arrow_down_rounded,
//                         size: 18,
//                         color: isExpanded ? Colors.white : appDarkColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isExpanded) const Divider(height: 1, thickness: 1, color: Color(0xFFEEF2F6)),
//             AnimatedCrossFade(
//               firstChild: const SizedBox.shrink(),
//               secondChild: Padding(
//                 padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     HtmlWidget(
//                       content,
//                       textStyle: const TextStyle(
//                         fontSize: 13,
//                         color: Color(0xFF4A5568),
//                         height: 1.6,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 300),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(AppBar().preferredSize.height),
//       backgroundColor: const Color(0xFFF6F8F9),
//       body: _isLoading
//           ? const Center(
//               child: SpinKitDoubleBounce(
//                 color: appColor,
//                 size: 70,
//               ),
//             )
//           : _errorMessage != null
//               ? Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           _errorMessage!,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(color: Colors.black54),
//                         ),
//                         const SizedBox(height: 12),
//                         ElevatedButton(
//                           onPressed: () => _initData(forceRefresh: true),
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : laws.isEmpty
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Text(
//                               'No laws available.',
//                               style: TextStyle(color: Colors.black54),
//                             ),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: () => _initData(forceRefresh: true),
//                               child: const Text('Refresh'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
//                       itemCount: laws.length,
//                       itemBuilder: (context, index) => _buildLawsItem(index),
//                     ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ralga/pages/laws/laws_page.dart';

class LawsEN extends StatelessWidget {
  final String id;
  final String title;
  const LawsEN(this.id, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LawsPage(
        id: id,
        title: title,
        lang: 'en',
        strings: LawsStrings.en,
      );
}