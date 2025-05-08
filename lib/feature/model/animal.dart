class Animal {
  final String animalNo;
  final String name;
  final String age;
  final String species;
  final List<String> photoUrls;

  Animal({
    required this.animalNo,
    required this.name,
    required this.age,
    required this.species,
    required this.photoUrls,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    String rawName = json['name'];
    String cleanedName = rawName.replaceAll(RegExp(r'\(.*?\)'), '').trim();

    String rawAge = json['age'];
    String processedAge = '';

    String species = json['species'] == 'DOG' ? '강아지' : '고양이';

    final ageMatch = RegExp(r'(\d+)\(세\)').firstMatch(rawAge);
    if (ageMatch != null) {
      processedAge = '${ageMatch.group(1)}살';
    } else {
      processedAge = rawAge;
    }

    return Animal(
      animalNo: json['animalNo'],
      name: cleanedName,
      age: processedAge,
      species: species,
      photoUrls: List<String>.from(json['photoUrls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animalNo': animalNo,
      'name': name,
      'age': age,
      'species': species,
      'photoUrls': photoUrls,
    };
  }
}