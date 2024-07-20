import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to signup: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/request-password-reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to request password reset: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> resetEmail(Map<String, dynamic> emailData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/reset-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(emailData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset email: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/verify-email?token=$token'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify email: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> passwordData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(passwordData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset password: ${response.body}');
    }
  }

  // Add methods for armory CRUD operations similarly
  Future<Map<String, dynamic>> addWeapon(Map<String, dynamic> weaponData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/armory'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add weapon: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editWeapon(String id, Map<String, dynamic> weaponData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mobile/armory/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit weapon: ${response.body}');
    }
  }

  Future<void> deleteWeapon(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/mobile/armory/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete weapon: ${response.body}');
    }
  }

  Future<List<dynamic>> searchWeapons(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/mobile/armory/search?query=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search weapons: ${response.body}');
    }
  }
}
