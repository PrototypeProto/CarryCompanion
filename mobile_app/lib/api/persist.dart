import 'dart:convert';
import 'dart:developer';

import 'package:gun/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* A collection of get and set methods to store persistant data */

class PreferencesHelper {
  final String _jwtKey = 'jwt';
  final String _usernameKey = 'username';
  final String _passwordKey = 'password';
  final String _emailKey = 'email';
  final String _nameKey = 'name';
  final String _arsenalKey = 'arsenal';
  final String _loginResponseKey = 'loginResponse';

  // Method to store JWT
  Future<void> storeJwt(String jwt) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtKey, jwt);
  }

  // Method to retrieve JWT
  Future<String> getJwt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_jwtKey);
    
    if (token == null) {
      return "no token";
    }
    return token;
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

  // Method to store name
  Future<void> storeName(String firstName, String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, '$firstName $lastName');
  }

  // Method to retrieve name
  Future<String?> retrieveName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
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

  // Method to store asenal json array?
  Future<void> storeGuns(List<Map<String, dynamic>> guns) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(guns);
    await prefs.setString(_arsenalKey, jsonString);
  }

  // Method to retrieve asenal json array?
  Future<List<Map<String, dynamic>>> retrieveGuns() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_arsenalKey);
    if (jsonString == null) {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => item as Map<String, dynamic>).toList();
  }

  // Method to add a gun to arsenal array
  Future<void> addWeapon(Map<String, dynamic> newWeapon) async {
    List<Map<String, dynamic>> guns = await retrieveGuns();
    guns.add(newWeapon);
    await storeGuns(guns);
  }

  // Method to store login response as JSON
  Future<void> storeLoginResponse(
      Map<String, dynamic> response, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Extract the 'data' field from the response
    Map<String, dynamic> data = response['data'];

    String jsonString = jsonEncode(data);
    await prefs.setString(_loginResponseKey, jsonString);
    await prefs.setString(_passwordKey, password);
    // await prefs.setString(_jwtKey, response['token']);
    log(jsonString);
  }

  Future<void> processStoredLoginResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_loginResponseKey);

    // Ensure the JSON string is not null
    if (jsonString == null) {
      print('No login response found in SharedPreferences.');
      return;
    }

    Map<String, dynamic> response;
    try {
      response = jsonDecode(jsonString);
    } catch (e) {
      print('Failed to decode JSON: $e');
      return;
    }

    // Print the entire response for debugging
    log('PRINTING Response: $response');

    // Check if the response contains the 'token' key
    if (response.containsKey('token')) {
      log('SUCCESS Response: $response');
    await prefs.setString(_jwtKey, response['token']);

      String token = response['token'] as String? ?? '';
      Map<String, dynamic>? user = response['user'] as Map<String, dynamic>?;

      // Safely retrieve and handle values from the 'user' map
      String? firstName = user?['firstName'] as String?;
      String? lastName = user?['lastName'] as String?;
      String? email = user?['email'] as String?;

      // Print for debugging
      log('Token: $token');
      log('First Name: $firstName');
      log('Last Name: $lastName');
      log('Email: $email');

      // Store values if they are not null or empty
      if (token.isNotEmpty) {
        ApiService serv = ApiService(baseUrl: "https://www.thisisforourclass.xyz");

        // ApiService serv = ApiService(
            // baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");

        // Fetch and store weapons
        try {
          List<Map<String, dynamic>> weapons =
              await serv.searchWeapons('', token);
          await storeGuns(weapons);
        } catch (e) {
          print('Failed to fetch or store weapons: $e');
        }
      }
      if (firstName != null && lastName != null) {
        await storeName(firstName, lastName);
      }
      if (email != null) {
        await storeEmail(email);
      }
    } else {
      log('Token not found in the response.');
    }
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