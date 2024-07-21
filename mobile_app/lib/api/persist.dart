import 'dart:convert';
import 'dart:math';

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
  Future<void> storeCards(List<Map<String, dynamic>> cards) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(cards);
    await prefs.setString(_arsenalKey, jsonString);
  }

  // Method to retrieve asenal json array?
  Future<List<Map<String, dynamic>>> retrieveCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_arsenalKey);
    if (jsonString == null) {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) => item as Map<String, dynamic>).toList();
  }

  // Method to add a gun to arsenal array
  Future<void> addCard(Map<String, dynamic> newCard) async {
    List<Map<String, dynamic>> cards = await retrieveCards();
    cards.add(newCard);
    await storeCards(cards);
  }

  // Method to store login response as JSON
  Future<void> storeLoginResponse(Map<String, dynamic> response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(response);
    await prefs.setString(_loginResponseKey, jsonString);
    processStoredLoginResponse();
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
    print('Response: $response');
    
    // Check if the response contains the 'token' key
    if (response.containsKey('token')) {
      String token = response['token'] as String? ?? '';
      Map<String, dynamic>? user = response['user'] as Map<String, dynamic>?;

      // Safely retrieve and handle values from the 'user' map
      String? firstName = user?['firstName'] as String?;
      String? lastName = user?['lastName'] as String?;
      String? email = user?['email'] as String?;
      
      // Print for debugging
      print('Token: $token');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Email: $email');
      
      // Store values if they are not null or empty
      if (token.isNotEmpty) {
        await storeJwt(token);
      }
      if (firstName != null && lastName != null) {
        await storeName(firstName, lastName);
      }
      if (email != null) {
        await storeEmail(email);
      }
    } else {
      print('Token not found in the response.');
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