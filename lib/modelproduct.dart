class Product {
  String name;
  int price;
  String image;
  int jumlah;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.jumlah,
  });

  factory Product.fromJson(Map json) {
    return Product(
        name: json['name'],
        price: json['price'],
        image: json['image'],
        jumlah: json['jumlah']);
  }
}
