import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
class Chatinputfield extends StatelessWidget {
  const Chatinputfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10,
      ),
      decoration: BoxDecoration(
        color:Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [BoxShadow(offset: Offset(0,4),
          blurRadius:32,
          color: Color(0xFF087949).withOpacity(0.08),
        ),
        ],
      ),
      child: SafeArea(
          child: Row(
            children: [
              Icon(Icons.mic, color: AppColors.backgroundColor),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20*0.75),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor!.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      SizedBox(width: 5,),
                      Expanded(child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                      ),
                      ),
                      Icon(
                        Icons.attach_file,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),

                    ],


                  ),
                ),
              ),

            ],
          )
      ),

    );
  }
}