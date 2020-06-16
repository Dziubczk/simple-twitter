import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/mockDB.dart';

class UserPost {
  final int id;
  final String title;
  final String body;
  final int userId;
  //List<Comment> comments;

  UserPost({this.id, this.title, this.body, this.userId});

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  //void addCommentsFromDB() {}
}
