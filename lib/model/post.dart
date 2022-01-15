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
  bool isDisabled;
  bool isShared;
  String fromWho;
  String topic;

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
    required this.isDisabled,
    required this.fromWho,
    required this.isShared,
    required this.topic
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
        'isDisabled': isDisabled,
        'fromWho': fromWho,
        'isShared': isShared,
        'topic': topic
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
      isDisabled: data['isDisabled'] ?? false,
      isShared: data['isShared'] ?? false,
      fromWho: data['fromWho'] ?? "",
      topic: data['topic'] ?? ""
    );
  }
}