class Administrator {
  String name;
  String image;
  int validatedProposals;

  Administrator( 
      {required this.name,
      required this.image,
      required this.validatedProposals});

  factory Administrator.fromJson(Map<String, dynamic> json) {
    return Administrator(
        name: json['username'],
        image: json['image'],
        validatedProposals: json['validated_proposals']);
  }
}
