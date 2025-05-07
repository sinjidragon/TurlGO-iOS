import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../model/animal.dart';
import '../../../shared/util/show_toast.dart';

class HomeViewModel extends ChangeNotifier {
  late List<Animal> animals;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isLoading = false;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;

  Future<void> getAnimalList() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? accessToken = await _secureStorage.read(key: 'access_token');

      if (accessToken == null) {
        showToast('다시 로그인 해주세요.');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final uri = Uri.parse('${dotenv.get('API_URL')}animal');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        animals = (responseData['data'] as List).map((item) => Animal.fromJson(item)).toList();
        _isSuccess = true;
      } else {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        showToast(responseData['message'] ?? "불러오기에 실패했습니다.");
      }
    } catch (e) {
      showToast('서버 오류: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

