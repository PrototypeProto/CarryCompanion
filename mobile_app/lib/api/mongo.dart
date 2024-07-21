import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'persist.dart';
import '../../api/api.dart';

const url =
    "mongodb+srv://root:COP4331iscool@cluster0.f9xcqli.mongodb.net/Team9LargeProject";

class MongoDatabase {
  static Db? _db;
  static const String _usernameKey = 'username';
  String? _username;
  final PreferencesHelper _prefsHelper = PreferencesHelper();
  // ApiService serv = ApiService(baseUrl: "http://10.0.2.2:5000");
  ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
  late Map<String, dynamic> auth;

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

  Future<void> loginstuff(String username, String password) async {
    // Map<String, dynamic> 
    auth = await serv.login(
      {"username": username, "password": password},
    );
    // log(auth['message']);
    // await _prefsHelper.storeName(auth['firstName'], auth['lastName']);
    // await _prefsHelper.storeJwt(auth['token']);
    // await _prefsHelper.storeEmail("email");
    // log(auth['token']);
  }

  Future loginUser(String username, String password) async {
    try {
      auth =
          await serv.login({"username": username, "password": password});
      // await loginstuff(username, password);
      if (auth['success'] == true) {
          await _prefsHelper.storeLoginResponse(auth, password);
          return auth;
      } else {
        log('User not found');
        return auth;
      }
    } catch (err) {
      log('Error in loginUser: $err');
      /* TODO: pretty up invalid sign in msg */
      return err.toString();
    } 
  }

  Future<String> signUpUser(
      String username, String email, String password) async {
    String result = '';
    try {
      await connect();
      var userCollection = _db!.collection('Users');

      // Check if username already exists
      var existingUser = await userCollection.findOne({'username': username});
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
