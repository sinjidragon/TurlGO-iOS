import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  final TextEditingController idEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();


  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;

  Future<void> login() async {
    final username = idEditingController.text;
    final password = passwordEditingController.text;


    if (username.isEmpty || password.isEmpty) {
      _errorMessage = '아이디와 비밀번호를 입력해주세요.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final uri = Uri.parse('${dotenv.get('API_URL')}auth/login');
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {
                'username' : username,
                'password' : password
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));

        final accessToken = responseData['accessToken'];
        final refreshToken = responseData['refreshToken'];

        if (accessToken != null) {
          await _secureStorage.write(key: 'access_token', value: accessToken);
        }
        if (refreshToken != null) {
          await _secureStorage.write(key: 'refresh_token', value: refreshToken);
        }
        _isSuccess = true;
        _isSuccess = true;
        notifyListeners();
      } else {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        _errorMessage = responseData['message'] ?? "알 수 없는 오류가 발생하였습니다";
        notifyListeners();
      }
    }
    catch (e) {
      _errorMessage = '서버와 통신할 수 없습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void clearErrorMessage(){
    _errorMessage = "";
    notifyListeners();
  }
}