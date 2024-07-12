import 'dart:convert';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

const url =
    "mongodb+srv://root:COP4331iscool@cluster0.f9xcqli.mongodb.net/Team9LargeProject";

class MongoDatabase {
  static Db? _db;

  static Future<void> connect() async {
    try {
      _db = await Db.create(url);
      await _db!.open();
      inspect(_db);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> close() async {
    try {
      await _db?.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //TODO: Modify to return the user object instead of a string
  Future<String> loginUser(username, password) async {
    String userJson = '';
    try {
      await MongoDatabase.connect();
      var user = await MongoDatabase._db
          ?.collection('Users')
          .findOne({'username': username, 'password': password});
      if (user != null) {
        userJson = jsonEncode(user);
      } else {
        userJson = 'User not found';
      }
    } catch (err) {
      log('Error in loginUser: $err');
      userJson = 'Error: $err';
    } finally {
      await MongoDatabase.close();
    }
    return userJson;
  }


Future<String> signUpUser(String username, String email, String password) async {
    String result = '';
    try {
      await connect();
      var userCollection = _db!.collection('Users');

      // Check if username already exists
      var existingUser =
          await userCollection.findOne({'username': username});
      if (existingUser != null) {
        result = 'Username already exists';
      } else {
        // Insert new user document
        var insertResult = await userCollection.insertOne({
          'username': username,
          'email': email,
          'password': password,
        });

        // Check if insertion was successful
        if (insertResult.isSuccess) {
          result = 'User successfully signed up';
        } else {
          result = 'Failed to sign up user';
        }
      }
    } catch (err) {
      print('Error in signUpUser: $err');
      result = 'Error: $err';
    } finally {
      await close();
    }
    return result;
  }
}
