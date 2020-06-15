import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:http/http.dart' as http;
class CustomDataBase {
  static List<UserPost> tweets = List<UserPost>();
  static List<Comment> comments = List<Comment>();

  //Future<http.Response> fetchUserPost() {
  //  return http.get('https://jsonplaceholder.typicode.com/posts');
  //}
  //Future<http.Response> fetchComment() {
  //  return http.get('https://jsonplaceholder.typicode.com/comments');
  //}
}