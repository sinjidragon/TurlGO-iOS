import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SignupViewModel extends ChangeNotifier {
  final TextEditingController idEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();


  bool _isLoading = false;
  bool _isFirstSuccess = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isFirstSuccess => _isFirstSuccess;
  String get errorMessage => _errorMessage;

  SignupViewModel() {
    idEditingController.addListener(() {
      clearErrorMessage();
    });
  }

  void dispose() {
    idEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  Future<void> checkUserName() async {
    final String id = idEditingController.text;
    final String password = passwordEditingController.text;

    if (id.isEmpty || password.isEmpty) {
      _errorMessage = '아이디와 비밀번호를 입력해주세요.';
      notifyListeners();
      return;
    }

    if (id.length < 6){
      _errorMessage = '아이디는 6자 이상이여야 합니다.';
      notifyListeners();
      return;
    }

    if (!RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$').hasMatch(password)){
      _errorMessage = '비밀번호는 8자 이상, 특수기호/숫자/영어를 포함해야합니다.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final uri = Uri.parse('${dotenv.get('API_URL')}auth/check-username').replace(
        queryParameters: {
          'username': id,
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );



      if (response.statusCode == 200 || response.statusCode == 201) {
        _isFirstSuccess = true;
        notifyListeners();
      } else {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        _errorMessage = responseData['message'] ?? "알 수 없는 오류가 발생하였습니다";
      }
    } catch (e) {
      _errorMessage = '서버와 통신할 수 없습니다.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void testError(){
    _errorMessage = "안녕하세요";
    notifyListeners();
  }

  void clearErrorMessage(){
    _errorMessage = "";
    notifyListeners();
  }
}