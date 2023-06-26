class Financer {
  String username;
  String image;
  int financingDone;
  double totalAmountFinanced;

  Financer(
      {required this.username,
      required this.image,
      required this.financingDone,
      required this.totalAmountFinanced});

  factory Financer.fromJson(Map<String, dynamic> json) {
    return Financer(
      username: json['username'],
      image: json['image'],
      financingDone: json['financingDone'],
      totalAmountFinanced: json['totalAmountFinanced'].toDouble(),
    );
  }
}
