class FinancerQuery2 {
  String username;
  String image;
  int financingDone;
  double totalAmountFinanced;

  FinancerQuery2(
      {required this.username,
      required this.image,
      required this.financingDone,
      required this.totalAmountFinanced});

  factory FinancerQuery2.fromJson(Map<String, dynamic> json) {
    return FinancerQuery2(
      username: json['username'],
      image: json['image'],
      financingDone: json['financingDone'],
      totalAmountFinanced: json['totalAmountFinanced'].toDouble(),
    );
  }
}
