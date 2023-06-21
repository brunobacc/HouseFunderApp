class ProjectFinanced {
  String image;
  String title;
  double totalFinanced;

  ProjectFinanced({
    required this.image,
    required this.title,
    required this.totalFinanced,
  });

  factory ProjectFinanced.fromJson(Map<String, dynamic> json) {
    return ProjectFinanced(
      image: json['image'],
      title: json['title'],
      totalFinanced: double.parse(json['total_financed'].toString()),
    );
  }
}
