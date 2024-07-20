import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData, String jwtToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
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
      Uri.parse('$baseUrl/api/mobile/login'),
      headers: {
        'Content-Type': 'application/json',
      },
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
      Uri.parse('$baseUrl/api/mobile/request-password-reset'),
      headers: {
        'Content-Type': 'application/json',
      },
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
      Uri.parse('$baseUrl/api/mobile/reset-email'),
      headers: {
        'Content-Type': 'application/json',
      },
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
      Uri.parse('$baseUrl/api/mobile/verify-email?token=$token'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify email: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> passwordData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/reset-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(passwordData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset password: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> addWeapon(Map<String, dynamic> weaponData, String jwtToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/armory'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add weapon: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editWeapon(String id, Map<String, dynamic> weaponData, String jwtToken) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/mobile/armory/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit weapon: ${response.body}');
    }
  }

  Future<void> deleteWeapon(String id, String jwtToken) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/mobile/armory/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete weapon: ${response.body}');
    }
  }

  Future<List<dynamic>> searchWeapons(String query, String jwtToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/armory/search?query=$query'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search weapons: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editFirstName(Map<String, dynamic> firstNameData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/firstName'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(firstNameData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit first name: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editLastName(Map<String, dynamic> lastNameData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/lastName'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(lastNameData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit last name: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editProfilePicture(Map<String, dynamic> profilePictureData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/profilePicture'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profilePictureData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit profile picture: ${response.body}');
    }
  }
}
