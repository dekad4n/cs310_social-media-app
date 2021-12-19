// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      name: json['name'] as String,
      profilePic: json['profilePic'] as String,
      content: json['content'] as String,
      timeAgo: json['timeAgo'] as String,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profilePic': instance.profilePic,
      'content': instance.content,
      'timeAgo': instance.timeAgo,
    };
