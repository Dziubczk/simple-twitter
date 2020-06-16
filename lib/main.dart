import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mytwitter/model/comment.dart';

import 'package:mytwitter/model/mockDB.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:mytwitter/pages/home.dart';

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
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
