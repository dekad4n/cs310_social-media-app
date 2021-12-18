import 'package:flutter/material.dart';
class Post{
  String? image;
  String text;
  String date;
  int likeCount;
  int commentCount;
  int dislikeCount;

  Post({
    this.image,
    required this.text,
    required this.likeCount,
    required this.date,
    required this.commentCount,
    required this.dislikeCount,
  });
  @override
  String toString() => 'Post: $text\nDate: $date\nLikes: $likeCount\nComments: $commentCount\nDislikes: $dislikeCount';
  Map<String, dynamic> toJson() =>
      {
        'image': image,
        'text': text,
        'date': date,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'dislikeCount': dislikeCount,
      };
  factory Post.fromMap(Map data){
    return Post(
      image: data['image'],
      text: data['text'],
      date: data['date'],
      likeCount: data['likeCount'],
      commentCount: data['commentCount'],
      dislikeCount: data['dislikeCount'],

    );
  }
}