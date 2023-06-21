class Product {
  int productId;
  String image;
  String title;
  String description;
  int price;

  Product({
    required this.productId,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

    factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      title: json['title'],
    );
  }
}
