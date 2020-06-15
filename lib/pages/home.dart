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

  void _addTweet(UserPost tweet) {
    setState(() {
      CustomDataBase.tweets.add(tweet);
    });
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
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        height: 8000,
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: curTweets.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //margin: EdgeInsets.all(4.0),
                //color: Colors.greenAccent,
                child: ListTile(
                  //contentPadding: EdgeInsets.all(10.0),
                  title: new Tweet(curTweets[index]),
                ),
              );
            }),
        /*child: ListView.builder(
            scrollDirection: Axis.vertical,
            //reverse: true,
            itemCount: CustomDataBase.tweets.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Center(
                child: new Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Tweet(CustomDataBase.tweets.elementAt(index))
                ),
              );
            }),*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTweet(UserPost(id:0, title:'shototam', body: 'many text', userId: 0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
