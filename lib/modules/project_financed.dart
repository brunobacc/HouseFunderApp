class ProjectFinanced {
  int projectId;
  String location;
  String image;
  String title;
  String description;
  double totalFinanced;
  double finalValue;
  double totalFinancedUser;

  ProjectFinanced({
    required this.projectId,
    required this.location,
    required this.image,
    required this.title,
    required this.description,
    required this.totalFinanced,
    required this.finalValue,
    required this.totalFinancedUser,
  });

  factory ProjectFinanced.fromJson(Map<String, dynamic> json) {
    return ProjectFinanced(
      projectId: json['project_id'],
      location: json['location'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      totalFinanced: double.parse(json['total_financed'].toString()),
      finalValue: double.parse(json['final_value'].toString()),
      totalFinancedUser: double.parse(json['total_financed_user'].toString()),
    );
  }
}
