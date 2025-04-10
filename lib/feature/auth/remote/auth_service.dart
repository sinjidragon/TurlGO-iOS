import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = dotenv.env['API_URL']!;

  Future<String> signup(String username, String email, String password) async {
    final url = Uri.parse('${baseUrl}auth/sign-up');

    final response = await http.post(
      url,
      body: jsonEncode({
        'username' : username,
        'email' : email,
        'password' : password
      }),
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return 'success';
    }
    else {
      final body = jsonDecode(response.body);
      return body['message'] ?? 'Unknown error';
    }
  }
}