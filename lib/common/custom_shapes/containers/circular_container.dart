import 'package:flutter/cupertino.dart';

import '../../../utils/constants/color.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.margin,
    this.backgroundColor = TColors.white,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: backgroundColor,
      ), // BoxDecoration
      child: child,
    ); // Container
  }
}