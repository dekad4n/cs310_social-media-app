class Chat {
  /*final String name, lastMessage, image, time;
  final bool isActive;

   */
  late String  lastMessage;
  late String name;
  late String image;
  late String time;

  late int chatId;
  late String userId;
  late String username;




  Chat({
    required this.name,
    required this.lastMessage,
    required this.image,
    required this.time,
    required this.chatId,
    required this.userId,
    required this.username,
  });

  @override
  String toString() => 'Chat: $lastMessage\nTime: $time\nName: $name\nImage: $image';
  Map<String, dynamic> toJson() =>
  {
  'name': name, //otherusername
  'lastMessage': lastMessage,
  'image': image,
  'time': time,
    'userId': userId,
    'username': username,
    'chatId': chatId,
  };




  factory Chat.fromMap(Map data){
    return Chat(
      image: data['image'],
      lastMessage: data['lastMessage'],
      time: data['time'],
      name: data['name'],
      chatId: data['chatId'],
      userId: data['userId'],
      username: data['userName'],


    );
  }
}



