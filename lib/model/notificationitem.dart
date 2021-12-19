import 'package:json_annotation/json_annotation.dart';

part 'notificationitem.g.dart';

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

  factory NotificationItem.fromJson(Map< String, dynamic> json) {
    return NotificationItem(
        name: json['name'],
        profilePic: json['profilePic'],
        content: json['content'],
        timeAgo: json['timeAgo']
    );
  }
  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);

}