class ProjectAdd {
  int statusId;
  int categoryId;
  int partnershipId;
  String location;
  String title;
  String description;
  double finalValue;

  ProjectAdd({
    required this.statusId,
    required this.categoryId,
    required this.partnershipId,
    required this.location,
    required this.title,
    required this.description,
    required this.finalValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'status_id': statusId,
      'category_id': categoryId,
      'partnership_id': partnershipId,
      'location': location,
      'title': title,
      'description': description,
      'final_value': finalValue,
    };
  }
}
