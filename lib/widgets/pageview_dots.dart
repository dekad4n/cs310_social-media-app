import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';

enum dotSize {
  Big,
  Small
}

class PageViewDots extends StatelessWidget {
  dotSize bigSmall;

  PageViewDots({Key? key, required this.bigSmall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(1,),
        height: bigSmall == dotSize.Big ? 14 : 8,
        width: bigSmall == dotSize.Big ? 14 : 8,
        decoration: BoxDecoration(
          color: bigSmall == dotSize.Big ? AppColors.activeDots: AppColors.passiveDots,
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
    );
  }
}
