import 'package:flutter/material.dart';
import 'package:untitled/models/post.dart';


class PostTile extends StatelessWidget {

  final Post post;

  const PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shadowColor: Colors.grey,
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                post.text,
              ),
            ),

            Row(
              children: [
                Text(
                  post.date,

                ),

                Spacer(),

                Icon(
                  Icons.thumb_up,
                  color: Colors.blue,
                  size: 14,
                ),
                Text(
                  ' x ${post.likeCount}',

                ),

                SizedBox(width: 16,),

                Icon(
                  Icons.comment,
                  size: 14,
                  color: Colors.blueAccent,
                ),

                Text(
                  ' x ${post.commentCount}',

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
