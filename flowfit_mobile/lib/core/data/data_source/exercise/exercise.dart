
class Exercise {
  final String name;
  final String gifUrl;
  final dynamic bodyPart;
  final dynamic instructions;

  Exercise({this.bodyPart, this.instructions, required this.name, required this.gifUrl});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      gifUrl: json['gifUrl'],
      bodyPart: json['bodyPart'],
      instructions: json['instructions'],
    );
  }
    static Exercise fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] as String,
      gifUrl: map['gifUrl'] as String,
      bodyPart: map['bodyPart'] as String,
      instructions: (map['instructions'] as List<dynamic>).cast<String>(),
    );
  }

}