import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial_cs310_project/model/post.dart';
import 'package:sucial_cs310_project/routes/posting/edit_post.dart';
import 'package:sucial_cs310_project/services/report_service.dart';
import 'package:sucial_cs310_project/widgets/alert.dart';


class PostTile extends StatelessWidget {

  final Post post;
  final VoidCallback delete;
  final VoidCallback incrementLike;
  final VoidCallback incrementComment;
  final VoidCallback incrementDislike;
  final VoidCallback sharePost;
  final bool isOther;


  PostTile({
    required this.post,
    required this.isOther,
    required this.delete,
    required this.incrementLike,
    required this.incrementComment,
    required this.incrementDislike,
    required this.sharePost
  });
   List<String> choices =  const<String>[
     "Report user",
     "Report post"
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shadowColor: Colors.grey,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [

                Text("@${post.username}"),
                if(post.isShared)
                  Text(" via @${post.fromWho}"),

                const Spacer(),
                IconButton(
                    onPressed: sharePost,
                    icon: const Icon(Icons.share)
                ),
                PopupMenuButton(
                    onSelected: (String choice){
                      if(choice == choices[0])
                        {
                          // report user
                          reportUserAlert(context, "Reporting user", "Why?", true,post.userId,post.postId.toString(),user!.uid);
                          //ReportService().reportUser(post.userId,user!.uid , "Null for now");
                        }
                      else if(choice == choices[1]){
                        // report post
                        reportUserAlert(context, "Reporting post", "Why", false, post.userId,post.postId.toString(),user!.uid);
                          //ReportService().reportPost(post.userId +post.postId.toString(), user!.uid, "post report");
                      }
                    },
                    itemBuilder: (BuildContext context)
                        {
                          return choices.skip(0).map((String choice){
                            return PopupMenuItem(
                                value: choice,
                                child: Text(choice),
                            );
                          }).toList();
                        }
                )


              ],
            ),
            const SizedBox(height: 16),
            if (post.image != null) Image.network(
              post.image!,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      post.text,
                    ),
                  ),
                  if(!isOther)
                    IconButton(
                      onPressed: delete,
                      padding: const EdgeInsets.all(0),
                      iconSize: 14,
                      splashRadius: 24,
                      color: Colors.red,
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  if(!isOther)
                    IconButton(
                        onPressed: (){
                          // Edit Post page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditPost(
                                          userId: post.userId,
                                          postId: post.postId,
                                          picture: post.image,
                                      )
                              )
                          );
                        },
                        iconSize: 14,
                        splashRadius: 24,
                        icon: const Icon(Icons.edit)
                    )
                ],
              ),
            ),

            Row(
              children: [
                Text(
                  post.date,
                ),

                const Spacer(),
                TextButton.icon(
                  onPressed: incrementDislike,
                  icon: const Icon(
                    Icons.thumb_down,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.dislikeCount}',

                  ),
                ),

                const SizedBox(width: 16,),

                TextButton.icon(
                  onPressed: incrementLike,
                  icon: const Icon(
                    Icons.thumb_up,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.likeCount}',

                  ),
                ),

                const SizedBox(width: 16,),

                TextButton.icon(
                  onPressed: incrementComment,
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.blueAccent,
                    size: 14,
                  ),
                  label: Text(
                    ' x ${post.comments.length}',
                  ),
                ),
                const SizedBox(width: 16,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
