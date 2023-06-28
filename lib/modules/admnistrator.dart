class Administrator {
  int userId;
  String name;
  String email;
  String image;
  int validatedProposals;

  Administrator(
      {required this.userId,
      required this.name,
      required this.email,
      required this.image,
      required this.validatedProposals});

  factory Administrator.fromJson(Map<String, dynamic> json) {
    return Administrator(
        userId: json['user_id'],
        name: json['username'],
        email: json['email'],
        image: json['image'],
        validatedProposals: json['validated_proposals']);
  }
}
