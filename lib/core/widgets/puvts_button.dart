import 'package:flutter/material.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';

class PuvtsButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Widget? icon;

  const PuvtsButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.width,
      this.height,
      this.textSize,
      this.textColor = Colors.white,
      this.fontWeight,
      this.icon,
      this.buttonColor,
      this.borderColor,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor ?? puvtsWhite,
            width: 2,
          )),
      child: ElevatedButton(
        onPressed: onPressed,
        child: icon ??
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding,
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
