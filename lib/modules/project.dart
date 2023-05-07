class Project {
  int projectId;
  int statusId;
  int categoryId;
  int partnershipId;
  String image;
  String title;
  String location;
  String description;
  double finalValue;
  int totalInvestor;

  Project(
    this.projectId,
    this.statusId,
    this.categoryId,
    this.partnershipId,
    this.image,
    this.title,
    this.location,
    this.description,
    this.finalValue,
    this.totalInvestor,
  );

  @override
  String toString() =>
      'Project: $projectId, Status: $statusId, Category: $categoryId, Partnership: $partnershipId, Image: $image, Title: $title, Location: $location, Description: $description, Value: $finalValue, Investors: $totalInvestor';
}
