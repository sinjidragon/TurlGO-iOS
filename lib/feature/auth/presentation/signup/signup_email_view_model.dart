import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SignupEmailViewModel extends ChangeNotifier {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController verifyCodeEditingController = TextEditingController();

  String? id;
  String? password;


  bool _isLoading = false;
  bool _isVerify = false;
  bool _isSignUpFinish = false;
  String _errorMessage = '';
  Timer? _timer;
  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _timer != null && _timer!.isActive;
  bool get isLoading => _isLoading;
  bool get isVerify => _isVerify;
  bool get isSignUpFinish => _isSignUpFinish;
  String get errorMessage => _errorMessage;


  void setCredentials(String id, String password) {
    this.id = id;
    this.password = password;
  }

  void startTimer({int seconds = 300}) {
    _timer?.cancel(); // 기존 타이머 취소
    _remainingSeconds = seconds;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        notifyListeners();
      } else {
        _remainingSeconds--;
        notifyListeners();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _remainingSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    verifyCodeEditingController.dispose();
    super.dispose();
  }

  Future<void> sendEmail() async {
    final email = emailEditingController.text;
    if (email.isEmpty){
      _errorMessage = "이메일을 입력해주세요.";
      notifyListeners();
      return ;
    }

    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      _errorMessage = "이메일을 올바르게 입력해주세요.";
      notifyListeners();
      return ;
    }
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final uri = Uri.parse('${dotenv.get('API_URL')}auth/sendmail');
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {
                'email': email
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _errorMessage = "인증번호가 발송 되었습니다, 스팸함을 확인해 주세요.";
        startTimer();
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

  Future<void> verify() async {
    final String email = emailEditingController.text;
    final String verifyCode = verifyCodeEditingController.text;

    if (email.isEmpty || verifyCode.isEmpty) {
      _errorMessage = '이메일과 인증코드를 입력해주세요.';
      notifyListeners();
      return;
    }
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final uri = Uri.parse('${dotenv.get('API_URL')}auth/verify');
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {
                'email': email,
                'verifyCode' : verifyCode
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isVerify = true;
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

  Future<void> signup() async {
    final username = id;
    final password = this.password;
    final email = emailEditingController.text;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final uri = Uri.parse('${dotenv.get('API_URL')}auth/sign-up');
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {
                'username' : username,
                'email' : email,
                'password' : password
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isSignUpFinish = true;
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