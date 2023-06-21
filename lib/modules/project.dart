class Project {
  int projectId;
  int statusId;
  int categoryId;
  int partnershipId;
  String location;
  String image;
  String title;
  String description;
  double totalFinanced;
  double finalValue;
  int totalInvestor;
  DateTime dateCreated;

  Project({
    required this.projectId,
    required this.statusId,
    required this.categoryId,
    required this.partnershipId,
    required this.location,
    required this.image,
    required this.title,
    required this.description,
    required this.totalFinanced,
    required this.finalValue,
    required this.totalInvestor,
    required this.dateCreated,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'],
      statusId: json['status_id'],
      categoryId: json['category_id'],
      partnershipId: json['partnership_id'],
      location: json['location'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      totalFinanced: double.parse(json['total_financed'].toString()),
      finalValue: double.parse(json['final_value'].toString()),
      totalInvestor: json['total_investor'],
      dateCreated: DateTime.parse(json['date_created']),
    );
  }
}
