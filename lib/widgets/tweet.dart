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
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(200, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text(widget._userPost.title, style: TextStyle(fontSize: 24),),
      ),
    );
  }
}
