import '../../product/model/product_model.dart';

class CartModel {
  final ProductModel product;

  int quantity;

  CartModel({required this.product, this.quantity = 1});

  double get totalPrice {
    return product.price * quantity;
  }

  double get discountedPrice {
    final discount = (product.price * product.discountPercentage) / 100;

    return (product.price - discount) * quantity;
  }
}
