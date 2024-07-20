import 'package:shared_preferences/shared_preferences.dart';

/* A collection of get and set methods to store persistant data */

class PreferencesHelper {
  final String _jwtKey = 'jwt';
  final String _usernameKey = 'username';
  final String _passwordKey = 'password';
  final String _emailKey = 'email';

  // Method to store JWT
  Future<void> storeJwt(String jwt) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtKey, jwt);
  }

  // Method to retrieve JWT
  Future<String?> getJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtKey);
  }

  // Method to store username
  Future<void> storeUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Method to retrieve username
  Future<String?> retrieveUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Method to store password
  Future<void> storePassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_passwordKey, password);
  }

  // Method to retrieve password
  Future<String?> retrievePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }

   // Method to store email
  Future<void> storeEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  // Method to retrieve email
  Future<String?> retrieveEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

}


/* TODO: */
/* TODO: */
/* TODO: */
/* TODO: */
/* TODO: */
/* TODO: */
/* TODO: */
/* TODO: */