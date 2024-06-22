import 'dart:convert';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

const url = "mongodb+srv://root:COP4331iscool@cluster0.f9xcqli.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

class MongoDatabase {
  static Db? _db;

  static Future<void> connect() async {
    try {
      _db = await Db.create(url);
      await _db!.open();
      inspect(_db);
      print('Connected to db successfully');
    } catch (e) {
      log(e.toString());
      print('Failed to connect to db');
    }
  }

  static Future<void> close() async {
    try {
      await _db?.close();
      print('Closed db connection');
    } catch (e) {
      log(e.toString());
      print('Failed to close db connection');
    }
  }

  //TODO: Modify to return the user object instead of a string
  Future<String> loginUser(username, password) async {
    String userJson = '';
    try {
      await MongoDatabase.connect();
      var user = await MongoDatabase._db?.collection('Users').findOne({'username': username, 'password': password});
      if (user != null) {
        userJson = jsonEncode(user);
      } else {
        userJson = 'User not found';
      }
      print(userJson);
    } catch (err) {
      log('Error in loginUser: $err');
      userJson = 'Error: $err';
    } finally {
      await MongoDatabase.close();
    }
    return userJson;
  }
}
