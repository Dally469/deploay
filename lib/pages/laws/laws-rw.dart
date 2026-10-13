
import 'package:flutter/material.dart';
import 'package:ralga/pages/laws/laws_page.dart';

class LawsRW extends StatelessWidget {
  final String id;
  final String title;
  const LawsRW(this.id, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LawsPage(
        id: id,
        title: title,
        lang: 'rw',
        strings: LawsStrings.rw,
      );
}