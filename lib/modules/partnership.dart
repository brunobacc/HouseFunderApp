class Partnership {
  String name;
  String image;
  int validatedProposals;

  Partnership(
      {required this.name,
      required this.image,
      required this.validatedProposals});

  factory Partnership.fromJson(Map<String, dynamic> json) {
    return Partnership(
        name: json['username'],
        image: json['image'],
        validatedProposals: json['validated_proposals']);
  }
}
