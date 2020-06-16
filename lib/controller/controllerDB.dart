import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/user_post.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomDataBase {
  static List<UserPost> tweets = List<UserPost>();
  static List<Comment> comments = List<Comment>();
  static Future<Database> database;

  static void initDataBase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'twitter_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tweets(id INTEGER PRIMARY KEY, title TEXT, body TEXT, userId INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertTweet(UserPost tweet) async {
    final Database db = await database;

    await db.insert(
      'tweets',
      tweet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<UserPost>> getTweets() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tweets');

    return List.generate(maps.length, (i) {
      return UserPost(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        userId: maps[i]['userId'],
      );
    });
  }
}
