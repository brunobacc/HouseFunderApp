class Product {
  int productId;
  String image;
  String title;
  String description;
  int price;
  double? value;
  bool active;

  Product({
    required this.productId,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.value,
    required this.active,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
      value:
          json['value'] != null ? double.parse(json['value'].toString()) : null,
      active: json['active'],
    );
  }
}
