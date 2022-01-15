import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/services/topic_service.dart';

class TopicCard extends StatefulWidget {
  String topicName;
  TopicCard({Key? key, required this.topicName}) : super(key: key);

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  TopicService topicService = TopicService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return FutureBuilder(
        future: topicService.topics.doc(widget.topicName).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
        {
          if(snapshot.data != null) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            bool doesContain = data['subscribed'].contains(user!.uid);
            return Card(
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                          '#${widget.topicName}'
                      )),
                  const Spacer(),
                  OutlinedButton(
                      onPressed: () {
                        if (doesContain) {
                          // UNSUB
                          topicService.unsubscribeFromTopic(widget.topicName, user.uid);

                        }
                        else {
                          // SUB
                          topicService.subscribeToTopic(widget.topicName, user.uid);

                        }
                      },
                      child: doesContain
                          ? const Text('Unsubscribe')
                          : const Text('Subscribe')
                  )

                ],
              ),
            );
          }
          return Container();
        }
    );
  }
}
