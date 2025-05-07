import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:turlgo/feature/shared/util/show_toast.dart';

Future<bool> refresh() async {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? refreshToken = await secureStorage.read(key: 'refresh_token');

  if (refreshToken == null) {
    showToast('다시 로그인 해주세요.');
    return false;
  }

  try {
    final uri = Uri.parse('${dotenv.get('API_URL')}auth/refresh');
    final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {
              'refreshToken': refreshToken
            }
        )
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));

      final accessToken = responseData['data']['accessToken'];
      final refreshToken = responseData['data']['refreshToken'];

      if (accessToken != null) {
        await secureStorage.write(key: 'access_token', value: accessToken);
      }
      if (refreshToken != null) {
        await secureStorage.write(key: 'refresh_token', value: refreshToken);
      }
      return true;
    } else {
      showToast('알 수 없는 오류가 발생하였습니다.');
      return false;
    }
  }
  catch (e) {
    showToast('서버 오류: ${e.toString()}');
  } finally {
    return false;
  }
}