import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class NotificationItem {
  String name;
  String profilePic;
  String content;
  String timeAgo;

  NotificationItem({
    required this.name,
    required this.profilePic,
    required this.content,
    required this.timeAgo
  });
  /*@override
  String toString() => 'NotificationItem: $content\ntimeAgo: $timeAgo\nname: $name\nprofilePic: $profilePic';
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'content': content,
        'profilePic': profilePic,
        'timeAgo': timeAgo,

      };*/

  factory NotificationItem.fromMap(Map< String, dynamic> json) {
    return NotificationItem(
        name: json['name'],
        profilePic: json['profilePic'],
        content: json['content'],
        timeAgo: json['timeAgo']
    );
  }


  //Map<String, dynamic> toJson() => _$NotificationItemToJson(this);

}