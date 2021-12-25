class Post{
  String? image;
  int postId;
  String userId;
  String username;
  String text;
  String date;
  int likeCount;
  List<dynamic> comments;
  int dislikeCount;

  Post({
    required this.postId,
    required this.userId,
    required this.username,
    this.image,
    required this.text,
    required this.likeCount,
    required this.date,
    required this.comments,
    required this.dislikeCount,
  });
  @override
  String toString() => 'Post: $text\nDate: $date\nLikes: $likeCount\nComments: $comments\nDislikes: $dislikeCount';
  Map<String, dynamic> toJson() =>
      {
        'postId': postId,
        'userId': userId,
        'username': username,
        'image': image,
        'text': text,
        'date': date,
        'likes': [],
        'comments': [],
        'dislikes': [],
      };
  factory Post.fromMap(Map data){
    return Post(
      userId: data['userId'],
      postId: data["postId"],
      username: data["username"],
      image: data['image'],
      text: data['text'],
      date: data['date'],
      likeCount: data['likes'].length,
      comments: data['comments'],
      dislikeCount: data['dislikes'].length,


    );
  }
}