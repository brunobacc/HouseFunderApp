class User {
  int userId;
  String username;
  String email;
  String password;
  String image;
  DateTime registrationDate;
  int permissionLevel;
  int validatedProposals;
  int activeProjects;
  int finishedProjects;
  int financingDone;
  double totalAmountFinanced;
  int acceptedProjects;
  int points;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.image,
    required this.registrationDate,
    required this.permissionLevel,
    required this.validatedProposals,
    required this.activeProjects,
    required this.finishedProjects,
    required this.financingDone,
    required this.totalAmountFinanced,
    required this.acceptedProjects,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      registrationDate: DateTime.parse(json['registration_date']),
      permissionLevel: json['permission_level'],
      validatedProposals: json['validated_proposals'] ?? 0,
      activeProjects: json['active_projects'] ?? 0,
      finishedProjects: json['finished_projects'] ?? 0,
      financingDone: json['financed_done'] ?? 0,
      totalAmountFinanced:
          double.parse(json['total_amount_financed'].toString()),
      acceptedProjects: json['accepted_projects'] ?? 0,
      points: json['points'] ?? 0,
    );
  }
}
