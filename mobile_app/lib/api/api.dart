import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to signup:',
      };
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to login',
      };
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      Map<String, dynamic> passwordData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(passwordData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to change password',
      };
    }
  }

  Future<Map<String, dynamic>> resetEmail(
      Map<String, dynamic> emailData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/reset-email'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(emailData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to reset email:',
      };
      // throw Exception('Failed to reset email: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/verify-email?token=$token'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to verify email:',
      };
    }
  }

  Future<Map<String, dynamic>> forgotPassword(
      String emailData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/request-forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": emailData}),
    );
    // print(response);
    // return {};
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to request password reset:',
      };
    }
  }

  Future<Map<String, dynamic>> addWeapon(
      Map<String, dynamic> weaponData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/armory'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to add weapon:',
      };
      // throw Exception('Failed to add weapon: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editWeapon(
      String id, Map<String, dynamic> weaponData, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/mobile/armory/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(weaponData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'success': true,
        'data': responseBody,
      };
    } else {
      final errorResponse = jsonDecode(response.body);
      return {
        'success': false,
        'message': errorResponse['message'] ?? 'Failed to edit weapon:',
      };
    }
  }

  Future<void> deleteWeapon(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/mobile/armory/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete weapon: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> searchWeapons(
    String query, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/mobile/armory/search?query=$query'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to search weapons: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editFirstName(
      Map<String, dynamic> firstNameData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/firstName'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(firstNameData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit first name: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editLastName(
      Map<String, dynamic> lastNameData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/lastName'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(lastNameData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit last name: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> editProfilePicture(
      Map<String, dynamic> profilePictureData, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/edit/profilePicture'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(profilePictureData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit profile picture: ${response.body}');
    }
  }


   Future<Map<String, dynamic>> deleteAccount(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/mobile/request-deletion'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(''),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit first name: ${response.body}');
    }
  }

}
