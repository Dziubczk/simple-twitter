import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/user_post.dart';

class DetailedTweet extends StatefulWidget {
  final UserPost _userPost;

  DetailedTweet(this._userPost);

  @override
  _DetailedTweetState createState() => _DetailedTweetState();
}

class _DetailedTweetState extends State<DetailedTweet> {
  List<Comment> curTweets;
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://jsonplaceholder.typicode.com/posts/${widget._userPost.id}/comments");
    if (response.statusCode == 200) {
      curTweets = (json.decode(response.body) as List)
                .map((data) => new Comment.fromJson(data))
                .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._userPost.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Container(padding: EdgeInsets.all(4.0), color: Colors.green[300], child: Text(widget._userPost.body, style: TextStyle(fontSize: 24),)),
            Center(
              child: Container(
                height: 400,
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: curTweets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.greenAccent,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10.0),
                          title: new Text(curTweets[index].body),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
