import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow textOverflow;
  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 0,
      this.height = 0,
      this.textOverflow = TextOverflow.fade})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimensions.font10 + 2 : size,
        height: height == 0 ? Dimensions.height10 * 0.12 : height,
      ),
    );
  }
}
