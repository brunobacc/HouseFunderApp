class FinancerQuery {
  String username;
  String image;

  FinancerQuery({
    required this.username,
    required this.image,
  });

  factory FinancerQuery.fromJson(Map<String, dynamic> json) {
    return FinancerQuery(
      username: json['username'],
      image: json['image'],
    );
  }
}
