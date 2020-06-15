import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mytwitter/model/comment.dart';

import 'package:mytwitter/model/mockDB.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:mytwitter/pages/home.dart';
/*
Future<UserPost> fetchUserPost(int index) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/$index');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserPost.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load post');
  }
}

Future<Comment> fetchComment(int index) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/comments/$index');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Comment.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load comment');
  }
}
*/

_fetchData() async {
  final response =
  await http.get("https://jsonplaceholder.typicode.com/posts");
  if (response.statusCode == 200) {
    CustomDataBase.tweets = (json.decode(response.body) as List)
        .map((data) => new UserPost.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load posts');
  }
  await http.get("https://jsonplaceholder.typicode.com/comments");
  if (response.statusCode == 200) {
    CustomDataBase.comments = (json.decode(response.body) as List)
        .map((data) => new Comment.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load comments');
  }
}

void main() {
  //for(int i = 1; i<101;i++){
  //  CustomDataBase.comments.add(fetchComment(i));
  //}
  _fetchData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Twitter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
