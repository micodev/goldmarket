import 'package:flutter/cupertino.dart';
import 'package:goldmarket/model/core/product.dart';
import 'package:goldmarket/model/helper/productHelper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ProductProvider extends ChangeNotifier {
  final ProductHelper _productHelper = new ProductHelper();
  List<Product> products;
  List<Asset> resultList;
  Product newAddedProduct;
  ProductProvider() {
    products = [];
    resultList = List<Asset>();
    fetchProducts();
  }
  void fetchProducts() async {
    products = await _productHelper.fetchProducts();
    notifyListeners();
  }

  void addProduct({Product product, bool initiate = false}) {
    if (initiate) {
      newAddedProduct = Product();
    } else {
      newAddedProduct = product;
      products.add(newAddedProduct);
    }
    clearImage();
  }

  void clearImage() {
    resultList.clear();
    notifyListeners();
  }

  void addImage(Asset asset) {
    resultList.add(asset);
    notifyListeners();
  }
}
