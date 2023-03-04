import 'package:cloud_kitchen/utils/dimensions/dimension.dart';
import 'package:cloud_kitchen/widgets/big_text.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  final String btn_txt;
  final Color color;
  const AppButton({
    Key? key,
    required this.btn_txt,
    this.color = const Color.fromARGB(169, 46, 38, 196),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.height55,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimensions.radius20)),
        child: Center(
          child: BigText(
            text: btn_txt,
            color: Colors.white,
          ),
        ));
  }
}
