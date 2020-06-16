import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/mockDB.dart';

class UserPost {
  int id;
  String title;
  String body;
  int userId;
  List<Comment> comments;

  UserPost({this.id, this.title, this.body, this.userId});

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  void addCommentsFromDB() {}
}
