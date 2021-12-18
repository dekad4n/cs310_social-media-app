

class UserProfile
{
  late String username;
  late String fullName;
  late String profilepicture;
  late String userId;
  late String biography;
  late List<dynamic> followers;
  late List<dynamic> following;
  late int followerCount;
  late int followingCount;
  List<dynamic> posts;

  UserProfile({
    required this.username,
    required this.fullName,
    required this.profilepicture,
    required this.userId,
    required this.biography,
    required this.followers,
    required this.following,
    required this.followerCount,
    required this.followingCount,
    required this.posts,
  });

  factory UserProfile.fromMap(Map data){
    return UserProfile(
        username: data['username'],
        fullName: data['fullName'],
        profilepicture: data['profilepicture'],
        userId: data['userId'],
        biography: data['biography'],
        followers: data['followers'],
        following: data['following'],
        followerCount: data['followerCount'],
        followingCount: data['followingCount'],
        posts:  data["posts"]
    );
  }
}