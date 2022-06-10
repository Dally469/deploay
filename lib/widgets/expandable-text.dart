import 'package:flutter/material.dart';
class ExpandableText extends StatefulWidget {

  final String text;
  const ExpandableText({Key? key,required this.text}) : super(key: key);
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  double textHeight=30;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?Text(firstHalf,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),):Column(
        children: [
          Text(hiddenText?(firstHalf+'...'):(firstHalf+secondHalf),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)),
          
        ],
      ),
    );
  }
}