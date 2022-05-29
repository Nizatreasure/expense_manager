import 'package:flutter/material.dart';

class SingleCell extends StatelessWidget {
  final String text;
  final double width;
  final bool showBorder;
  final double padding;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  const SingleCell(this.text,
      {this.showBorder = false,
      this.fontWeight = FontWeight.normal,
      this.padding = 0,
      this.width = 100,
      this.fontStyle = FontStyle.normal,
      this.color = Colors.black,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      padding: EdgeInsets.only(left: padding),
      decoration: BoxDecoration(
        border: BorderDirectional(
            bottom: const BorderSide(color: Colors.black, width: 0.1),
            end: showBorder
                ? const BorderSide(color: Colors.black, width: 0.1)
                : BorderSide.none),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: 16,
            fontStyle: fontStyle,
            fontWeight: fontWeight),
      ),
    );
  }
}
