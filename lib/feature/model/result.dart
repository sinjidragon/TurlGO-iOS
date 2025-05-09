class Result {
  final String breed;
  final String percentage;
  final String personality;
  final String traits;

  Result({
    required this.breed,
    required this.percentage,
    required this.personality,
    required this.traits,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      breed: json['견종'],
      percentage: json['퍼센테이지'],
      personality: json['성격'],
      traits: json['특성'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '견종': breed,
      '퍼센테이지': percentage,
      '성격': personality,
      '특성': traits,
    };
  }
}
