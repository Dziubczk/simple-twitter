import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mytwitter/model/mockDB.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:mytwitter/widgets/tweet.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'My Twitter';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserPost> curTweets;
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      curTweets = (json.decode(response.body) as List)
          .map((data) => new UserPost.fromJson(data))
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
      //backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        height: 8000,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            ///**
            : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: curTweets.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: ListTile(
                  title: new Tweet(curTweets[index]),
                ),
              );})///*/
            /**
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: CustomDataBase.tweets.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                    child: new Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Tweet(CustomDataBase.tweets.elementAt(index))),
                  );
                }),
        */
      ),
    );
  }
}
