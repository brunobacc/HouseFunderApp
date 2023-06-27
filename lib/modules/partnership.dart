class Partnership {
  int id;
  String name;
  String image;
  int validatedProposals;

  Partnership(
      {required this.id,
      required this.name,
      required this.image,
      required this.validatedProposals});

  factory Partnership.fromJson(Map<String, dynamic> json) {
    return Partnership(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        validatedProposals: json['validated_proposals'] ?? 0);
  }
}
