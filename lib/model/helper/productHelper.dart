import 'package:goldmarket/model/core/product.dart';
import 'package:goldmarket/model/service/Api/SystemApi.dart';

class ProductHelper {
  final api = SystemApi();
  Future<List<Product>> fetchProducts() async {
    var json = await api.fetchPosts();
    List<Product> products;
    if (json['post'] != null) {
      products = new List<Product>();
      json['post'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    return products;
  }
}
