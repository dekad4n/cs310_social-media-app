import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/topic_service.dart';
import 'package:sucial_cs310_project/ui/topic_card.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class SubscribedTopics extends StatefulWidget {
  const SubscribedTopics({Key? key}) : super(key: key);

  @override
  _SubscribedTopicsState createState() => _SubscribedTopicsState();
}

class _SubscribedTopicsState extends State<SubscribedTopics> {
  TopicService topicService = TopicService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: topicService.topics.snapshots(),
      builder:
      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.data != null) {
            return Scaffold(
              appBar: appBarBack(context, 'Subscribed Topics'),
              body: SingleChildScrollView(
                child: Column(
                  children: snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> element) =>
                          element['subscribed']
                              .toString().contains(
                              user!.uid))
                      .map((QueryDocumentSnapshot<Object?> data) =>
                      TopicCard(topicName: data['topicName'])).toList(),
                ),
              ),
            );
          }
          return  Scaffold(
            appBar: appBarBack(context, 'Subscribed Topics'),
          );
        }
    );
  }
}
