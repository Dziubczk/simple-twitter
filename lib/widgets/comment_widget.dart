import 'package:flutter/material.dart';
import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/user_post.dart';
import 'package:mytwitter/pages/detailed_tweet.dart';

class CommentWidget extends StatefulWidget {
  final Comment _comment;
  CommentWidget(this._comment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(200, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget._comment.name, style: TextStyle(fontSize:18, fontWeight: FontWeight.bold),),
            SizedBox(height: 2.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget._comment.email),
              ],
            ),
            SizedBox(height: 8.0,),
            Text(widget._comment.body),
          ],
        ),
      ),
    );
  }
}
