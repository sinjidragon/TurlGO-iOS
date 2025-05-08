import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../model/animal_info.dart';
import '../../../../shared/util/refresh.dart';
import '../../../../shared/util/show_toast.dart';

class DetailViewModel extends ChangeNotifier {
  late String animalNo;
  bool _isLoading = true;
  late AnimalInfo animalInfo;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool get isLoading => _isLoading;


  void setAnimalNo(String animalNo){
    this.animalNo = animalNo;
    getAnimalInfo();
  }

  Future<void> getAnimalInfo() async {
    notifyListeners();

    try {
      String? accessToken = await _secureStorage.read(key: 'access_token');

      if (accessToken == null) {
        showToast('다시 로그인 해주세요.');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final uri = Uri.parse('${dotenv.get('API_URL')}animal/$animalNo');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        animalInfo = AnimalInfo.fromJson(body['data']);
        _isLoading = false;
        notifyListeners();
      }
      else if (response.statusCode == 401) {
        final Future<bool> isRefresh = refresh();
        if (await isRefresh) {
          getAnimalInfo();
          notifyListeners();
        }
      }
      else {
        showToast("${response.statusCode}");
      }
    }
    catch (e) {
      showToast('서버 오류: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}