import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = AppColors.sucialColor,
    this.padding = const EdgeInsets.all(20*0.75),
}) :super(key: key);
  final String text;
  final VoidCallback press;
  final color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      padding: padding,
      color: color,
      minWidth: double.infinity,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );

  }
  
}