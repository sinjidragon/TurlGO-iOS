import 'dart:convert';

// 동물 정보 클래스
class AnimalInfo {
  final String animalNo;
  final String name;
  final String status;
  final String entranceDate;
  final String breed;
  final String sex;
  final String age;
  final double bodyWeight;
  final String introductionContent;
  final String introductionVideoUrl;
  final List<String> photoUrls;
  final List<ExpenseItem> calculatedData;

  AnimalInfo({
    required this.animalNo,
    required this.name,
    required this.status,
    required this.entranceDate,
    required this.breed,
    required this.sex,
    required this.age,
    required this.bodyWeight,
    required this.introductionContent,
    required this.introductionVideoUrl,
    required this.photoUrls,
    required this.calculatedData,
  });

  factory AnimalInfo.fromJson(Map<String, dynamic> json) {
    // 이름에서 괄호 내용 분리
    String fullName = json['name'] as String? ?? '';
    String name = fullName;
    String status = '';

    RegExp regExp = RegExp(r'(.*?)\((.*?)\)');
    Match? match = regExp.firstMatch(fullName);
    if (match != null && match.groupCount >= 2) {
      name = match.group(1)?.trim() ?? '';
      status = match.group(2)?.trim() ?? '';
    }

    // calculatedData 파싱
    List<ExpenseItem> expenses = [];
    if (json['calculatedData'] != null) {
      try {
        List<dynamic> expenseList = jsonDecode(json['calculatedData']);
        expenses = expenseList.map((item) => ExpenseItem.fromJson(item)).toList();
      } catch (e) {
        print('calculatedData 파싱 오류: $e');
      }
    }

    String species = json['species'] == 'DOG' ? '강아지' : '고양이';

    String rawAge = json['age'];
    String processedAge = '';

    final ageMatch = RegExp(r'(\d+)\(세\)').firstMatch(rawAge);
    if (ageMatch != null) {
      processedAge = '${ageMatch.group(1)}살';
    } else {
      processedAge = rawAge;
    }

    // YouTube ID만 추출
    String rawVideoUrl = json['introductionVideoUrl'] as String? ?? '';
    String videoId = extractYoutubeId(rawVideoUrl);

    return AnimalInfo(
      animalNo: json['animalNo'] as String? ?? '',
      name: name,
      status: status,
      entranceDate: json['entranceDate'] as String? ?? '',
      breed: json['breed'] as String? ?? '',
      sex: json['sex'] == 'M'? '남아' : '여야 ' as String? ?? '',
      age: processedAge,
      bodyWeight: (json['bodyWeight'] as num?)?.toDouble() ?? 0.0,
      introductionContent: json['introductionContent'] as String? ?? '',
      introductionVideoUrl: videoId,
      photoUrls: (json['photoUrls'] as List<dynamic>?)?.map((url) => url as String).toList() ?? [],
      calculatedData: expenses,
    );
  }
}

// 유튜브 URL에서 영상 ID만 추출
String extractYoutubeId(String url) {
  final shortUrlRegex = RegExp(r'youtu\.be/([a-zA-Z0-9_-]+)');
  final longUrlRegex = RegExp(r'[?&]v=([a-zA-Z0-9_-]+)');

  final shortMatch = shortUrlRegex.firstMatch(url);
  if (shortMatch != null && shortMatch.groupCount >= 1) {
    return shortMatch.group(1)!;
  }

  final longMatch = longUrlRegex.firstMatch(url);
  if (longMatch != null && longMatch.groupCount >= 1) {
    return longMatch.group(1)!;
  }

  return ''; // 추출 실패 시 빈 문자열
}

// 비용 항목 클래스
class ExpenseItem {
  final String name;
  final int content;

  ExpenseItem({
    required this.name,
    required this.content,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      name: json['name'] as String? ?? '',
      content: (json['content'] as num?)?.toInt() ?? 0,
    );
  }
}
