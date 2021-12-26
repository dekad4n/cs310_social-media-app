import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
class VideoMessage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.45,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRect(
              child: Image.asset("assets/logo.jpg"),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                size: 16,
                color:Colors.white,
              ),

            ),

          ],
        ),
      ),


    );
  }
}