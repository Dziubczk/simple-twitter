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
    final response = await http.get(
        "https://jsonplaceholder.typicode.com/posts/${widget._userPost.id}/comments");
    if (response.statusCode == 200) {
      curTweets = (json.decode(response.body) as List)
          .map((data) => new Comment.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load comments');
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
        height: 8000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(200, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Text(
                  widget._userPost.body,
                  style: TextStyle(fontSize: 24),
                )),
            Container(
              height: 300,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: curTweets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(200, 255, 255, 255),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            title: new Text(curTweets[index].body),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
