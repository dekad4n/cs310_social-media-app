import 'package:sucial_cs310_project/routes/requests.dart';

class Topic{
  String? topicName;
  List<dynamic> postIDlist;

  Topic({
    required this.topicName,
    required this.postIDlist

  });

  Map<String, dynamic> toJson() =>
      {
        'topicName': topicName,
        'postIDlist': postIDlist
      };

  factory Topic.fromMap(Map data){
    return Topic(
      topicName: data["topicName"],
      postIDlist: data["postIDlist"]
    );
  }
}