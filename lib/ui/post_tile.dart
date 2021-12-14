import 'package:flutter/material.dart';
import 'package:untitled/models/post.dart';


class PostTile extends StatelessWidget {

  final Post post;
  final VoidCallback delete;
  final VoidCallback incrementLike;
  final VoidCallback incrementComment;
  final VoidCallback incrementDislike;

  const PostTile({
    required this.post,
    required this.delete,
    required this.incrementLike,
    required this.incrementComment,
    required this.incrementDislike,

  });
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

            if (post.image != null) Image.network(
              post.image!,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [


                  Text(
                    post.text,
                  ),
                  IconButton(
                    onPressed: delete,
                    padding: EdgeInsets.all(0),
                    iconSize: 14,
                    splashRadius: 24,
                    color: Colors.red,
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Text(
                  post.date,

                ),

                Spacer(),
                TextButton.icon(
                  onPressed: incrementDislike,
                  icon: Icon(
                    Icons.thumb_down,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.dislikeCount}',

                  ),
                ),

                SizedBox(width: 16,),

                TextButton.icon(
                  onPressed: incrementLike,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.likeCount}',

                  ),
                ),

                SizedBox(width: 16,),

                TextButton.icon(
                  onPressed: incrementComment,
                  icon: Icon(
                    Icons.comment,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.commentCount}',

                  ),
                ),

                SizedBox(width: 16,),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
