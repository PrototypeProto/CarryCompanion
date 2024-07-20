import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'persist.dart';

const url =
    "mongodb+srv://root:COP4331iscool@cluster0.f9xcqli.mongodb.net/Team9LargeProject";

class MongoDatabase {
  static Db? _db;
  static const String _usernameKey = 'username';
  String? _username;
  final PreferencesHelper _prefsHelper = PreferencesHelper();

  MongoDatabase();

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

  Future<bool> loginUser(String username, String password) async {
    bool validLogin = false;
    try {
      await MongoDatabase.connect();
      var user = await MongoDatabase._db
          ?.collection('Users')
          .findOne({'username': username, 'password': password});
      if (user != null) {
        validLogin = true;
        await _prefsHelper.storeUsername(username); // Store username here
        await _prefsHelper.storePassword(password); // Store password here
        await _prefsHelper.storeEmail(user['email']); // Store password here
        print(user['email']);

      } else {
        log('User not found');
        validLogin = false;
      }
    } catch (err) {
      log('Error in loginUser: $err');
    } finally {
      await MongoDatabase.close();
    }
    return validLogin;
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
