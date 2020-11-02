class Product {
  String name;
  String price;
  String weight;
  String description;
  dynamic cover;
  bool isLocal;

  Product(
      {this.name,
      this.price,
      this.weight,
      this.description,
      this.cover,
      this.isLocal = false});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    weight = json['weight'];
    description = json['description'];
    cover = json['cover'];
    isLocal = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['cover'] = this.cover;
    return data;
  }
}
