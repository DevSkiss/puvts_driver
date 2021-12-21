import 'package:flutter/material.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';

class PuvtsButton extends StatelessWidget {
  const PuvtsButton({
    Key? key,
    this.text,
    this.onPressed,
    this.width = 150,
    this.isLoading = false,
    this.height,
    this.textSize,
    this.textColor = Colors.white,
    this.fontWeight,
    this.icon,
    this.buttonColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  }) : super(key: key);

  final String? text;
  final bool isLoading;
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
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: puvtsWhite,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Deactivate'),
                ],
              )
            : icon ??
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
