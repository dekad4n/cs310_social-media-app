import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/report_service.dart';

Future<void> showAlertScreen(BuildContext context, String title, String message) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ],
        );
      });
}
Future<void> reportUserAlert(BuildContext context, String title, String message, bool reportType, String reportedUserId, String postId, String userId) async {
  String reason = "";
  final _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: TextFormField(
                onSaved: (value){
                  if(value != null)
                    {
                      reason = value;
                    }
                },
              ),

            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("Cancel")
            ),
            TextButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  if(reportType) {
                    ReportService().reportUser(
                        reportedUserId, userId, reason);
                  }
                  else{
                    ReportService().reportPost(reportedUserId +postId, userId, reason);
                  }

                  Navigator.of(context).pop();
                },
                child: const Text('Report!')),
          ],
        );
      });
}