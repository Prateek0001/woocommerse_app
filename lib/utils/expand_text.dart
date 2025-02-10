import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ExpandText extends StatefulWidget {
  final String labelHeader;
  final String desc;
  final String shortDesc;
  const ExpandText(
      {super.key,
      required this.labelHeader,
      required this.desc,
      required this.shortDesc});

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelHeader,
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          HtmlWidget(descTextShowFlag ? widget.desc : widget.shortDesc),
          Align(
            child: GestureDetector(
              child: Text(
                descTextShowFlag ? "Show More" : "Show Less",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: (){
                setState(() {
                  descTextShowFlag = !descTextShowFlag;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
