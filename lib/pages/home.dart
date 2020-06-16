import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'file:///C:/Users/frostrch/AndroidStudioProjects/my_twitter/lib/controller/controllerDB.dart';
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
  var isLoadingDB = false;
  List<UserPost> fromDBTweets;

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
        curTweets.forEach((element) {
          CustomDataBase.insertTweet(element);
        });
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  _readFromDB() async {
    setState(() {
      isLoadingDB = true;
    });
    await _fetchData();
    fromDBTweets = await CustomDataBase.getTweets();
    if (fromDBTweets != null) {
      setState(() {
        isLoadingDB = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _readFromDB();
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
          child: isLoadingDB
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: fromDBTweets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ListTile(
                        title: new Tweet(fromDBTweets[index]),
                      ),
                    );
                  })),
    );
  }
}
