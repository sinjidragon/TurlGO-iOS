import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:turlgo/feature/model/animal.dart';
import 'package:turlgo/feature/model/animal_preference.dart';
import 'package:turlgo/feature/model/result.dart';

import '../../../../../shared/util/show_toast.dart';
import '../test_view.dart';

class TestResultViewModel extends ChangeNotifier{
  late AnimalPreference animalPre;
  late List<Result> results;
  bool _isLoading = true;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool get isLoading => _isLoading;

  void setPref(AnimalPreference pref){
    _isLoading = true;
    animalPre = pref;
    getTestResult();
  }

  Future<void> getTestResult() async {
    notifyListeners();

    try {
      String? accessToken = await _secureStorage.read(key: 'access_token');

      if (accessToken == null) {
        showToast('다시 로그인 해주세요.');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final uri = Uri.parse('${dotenv.get('API_URL')}test');
      final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(
              {
                "housingType": convertHouseType(animalPre.housingType),
                "preferredAnimal": convertPrefAnimal(animalPre.preferredAnimal),
                "preferredPersonality": animalPre.preferredPersonality,
                "sheddingSensitivity": convertSheddSens(animalPre.sheddingSensitivity),
                "availableTime": animalPre.availableTime,
                "budget": animalPre.budget,
                "hasAllergy": convertHasAllergy(animalPre.hasAllergy)
              }
          )
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        List<dynamic> jsonData = jsonDecode(responseData['data']);
        results = jsonData.map((e) => Result.fromJson(e)).toList();
        print(results[0].breed);
        _isLoading = false;
      }
      else {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        showToast(responseData['message'] ?? "알 수 없는 오류가 발생하였습니다");
        notifyListeners();
      }
    }
    catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}

String convertHouseType(HouseType type) {
  switch (type) {
    case HouseType.apartment:
      return '아파트';
    case HouseType.singleFamilyHouse:
      return '단독주택';
    case HouseType.multiFamilyHouse:
      return '다세대 주택/빌라';
  }
}

String convertPrefAnimal(PrefAnimal type) {
  switch (type) {
    case PrefAnimal.dog:
      return '강아지';
    case PrefAnimal.cat:
      return '고양이';
  }
}

String convertSheddSens(SheddSens type) {
  switch (type) {
    case SheddSens.no:
      return '없음';
    case SheddSens.low:
      return '조금 예민';
    case SheddSens.very:
      return '많이 예민';
  }
}

String convertHasAllergy(HasAllergy type) {
  switch (type) {
    case HasAllergy.no:
      return '없음';
    case HasAllergy.yes:
      return '있음';
  }
}