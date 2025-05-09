import '../main/presentation/home/test/test_view.dart';

class AnimalPreference {
  HouseType housingType;
  PrefAnimal preferredAnimal;
  String preferredPersonality;
  SheddSens sheddingSensitivity;
  String availableTime;
  String budget;
  HasAllergy hasAllergy;

  // 생성자
  AnimalPreference({
    required this.housingType,
    required this.preferredAnimal,
    required this.preferredPersonality,
    required this.sheddingSensitivity,
    required this.availableTime,
    required this.budget,
    required this.hasAllergy,
  });

  // JSON에서 객체 생성
  factory AnimalPreference.fromJson(Map<String, dynamic> json) {
    return AnimalPreference(
      housingType: HouseType.values.firstWhere(
            (e) => e.toString() == 'HouseType.${json['housingType']}',
        orElse: () => HouseType.apartment,
      ),
      preferredAnimal: PrefAnimal.values.firstWhere(
            (e) => e.toString() == 'PrefAnimal.${json['preferredAnimal']}',
        orElse: () => PrefAnimal.dog,
      ),
      preferredPersonality: json['preferredPersonality'] as String,
      sheddingSensitivity: SheddSens.values.firstWhere(
            (e) => e.toString() == 'SheddingSens.${json['sheddingSensitivity']}',
        orElse: () => SheddSens.low,
      ),
      availableTime: json['availableTime'] as String,
      budget: json['budget'] as String,
      hasAllergy: HasAllergy.values.firstWhere(
            (e) => e.toString() == 'HasAllergy.${json['hasAllergy']}',
        orElse: () => HasAllergy.no,
      ),
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'housingType': housingType.toString().split('.').last,
      'preferredAnimal': preferredAnimal.toString().split('.').last,
      'preferredPersonality': preferredPersonality,
      'sheddingSensitivity': sheddingSensitivity.toString().split('.').last,
      'availableTime': availableTime,
      'budget': budget,
      'hasAllergy': hasAllergy.toString().split('.').last,
    };
  }

  // 객체 복사본 생성 (값 변경 가능)
  AnimalPreference copyWith({
    HouseType? housingType,
    PrefAnimal? preferredAnimal,
    String? preferredPersonality,
    SheddSens? sheddingSensitivity,
    String? availableTime,
    String? budget,
    HasAllergy? hasAllergy,
  }) {
    return AnimalPreference(
      housingType: housingType ?? this.housingType,
      preferredAnimal: preferredAnimal ?? this.preferredAnimal,
      preferredPersonality: preferredPersonality ?? this.preferredPersonality,
      sheddingSensitivity: sheddingSensitivity ?? this.sheddingSensitivity,
      availableTime: availableTime ?? this.availableTime,
      budget: budget ?? this.budget,
      hasAllergy: hasAllergy ?? this.hasAllergy,
    );
  }
}