
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
}