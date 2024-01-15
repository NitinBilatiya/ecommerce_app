// product_provider.dart
import 'package:flutter/material.dart';
import 'product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(image: 'assets/galaxyA15.webp', name: 'Galaxy A15', price: 199.99),
    Product(image: 'assets/iphone13.jpg', name: 'iPhone 13', price: 699.99),
    Product(image: 'assets/iqooZ6.jpeg', name: 'iQOO Z6', price: 329.99),
    Product(
        image: 'assets/oneplusnord.webp', name: 'OnePlus Nord', price: 429.99),
    Product(
        image: 'assets/realmeNarzoN53.jpeg',
        name: 'Realme Narzo N53',
        price: 249.99),
    Product(
        image: 'assets/redmiNote12.jpg', name: 'Redmi Note 12', price: 179.99),
    Product(image: 'assets/vivoY56.jpeg', name: 'Vivo Y56', price: 289.99),
    // Add more products here
  ];

  List<Product> get products => _products;

  List<Product> get cartProducts =>
      _products.where((product) => product.addedToCart).toList();

  double get totalCartPrice =>
      cartProducts.fold(0, (total, product) => total + product.price);

  void addToCart(int index) {
    _products[index].addedToCart = true;
    notifyListeners();
  }

  void removeFromCart(int index) {
    _products[index].addedToCart = false;
    notifyListeners();
  }

  void clearCart() {
    _products.forEach((product) {
      product.addedToCart = false;
    });
    notifyListeners();
  }
}
