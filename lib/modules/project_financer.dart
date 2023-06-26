class ProjectFinancer {
  String username;
  String image;

  ProjectFinancer({
    required this.username,
    required this.image,
  });

  factory ProjectFinancer.fromJson(Map<String, dynamic> json) {
    return ProjectFinancer(
      username: json['username'],
      image: json['image'],
    );
  }
}
