import 'package:mytwitter/model/comment.dart';
import 'package:mytwitter/model/user_post.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mytwitter/main.dart';

class CustomDataBase {
  static List<UserPost> tweets = List<UserPost>();
  static List<Comment> comments = List<Comment>();
  static Future<Database> database;
  //static Database twidatabase;
  //  join(await getDatabasesPath(), 'twitter_database.db')
  //)

  static void initDataBase() async {
    database = openDatabase(
        join(await getDatabasesPath(), 'twitter_database.db'),
        onCreate: (db, version) {
    return db.execute(
    "CREATE TABLE tweets(id INTEGER PRIMARY KEY, title TEXT, body TEXT, userId INTEGER)",
    );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
  }

  static Future<void> insertTweet(UserPost tweet) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'tweets',
      tweet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<UserPost>> getTweets() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tweets');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
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
