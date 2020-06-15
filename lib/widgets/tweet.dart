import 'package:flutter/material.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:mytwitter/pages/detailed_tweet.dart';

class Tweet extends StatefulWidget {
  final UserPost _userPost;
  Tweet(this._userPost);

  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailedTweet(widget._userPost)));
      },
      child: Container(
        width: 400,
        //height: 100,
        color: Colors.green[200],
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget._userPost.title, style: TextStyle(fontSize: 24),),
        ),
      ),
    );
  }
}
