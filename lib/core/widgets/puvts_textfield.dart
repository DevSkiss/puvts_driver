import 'package:flutter/material.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';

class PuvtsTextfield extends StatelessWidget {
  final String? hintText;
  final TextInputType keyboardType;
  final String? labelText;
  final bool obscureText;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? testing;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final String? errorText;
  final BorderRadius borderRadius;
  final bool visible;
  final bool enabled;

  const PuvtsTextfield({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.textStyle,
    this.labelText,
    this.visible = true,
    this.enabled = true,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 30),
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.borderRadius = const BorderRadius.all(Radius.circular(15.0)),
    this.suffixIcon,
    this.controller,
    this.testing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextField(
        style: textStyle,
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        onSubmitted: (value) {
          if (onSubmitted != null) {
            onSubmitted!(value);
          }
        },
        autocorrect: false,
        enabled: enabled,
        enableInteractiveSelection: false,
        enableSuggestions: false,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: puvtsWhite),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: puvtsWhite),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: puvtsWhite),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: textStyle,
          labelStyle: textStyle,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
