import 'package:flutter/material.dart';

import '../../product/model/product_model.dart';
import '../model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> cartItems = [];

  // add to cart
  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartModel(product: product));
    }

    notifyListeners();
  }

  // increase quantity
  void increaseQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      cartItems[index].quantity++;

      notifyListeners();
    }
  }

  // decrease quantity
  void decreaseQuantity(int productId) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  // remove item from cart
  void removeItem(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);

    notifyListeners();
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // subtotal
  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // discount
  double get totalDiscount {
    return cartItems.fold(0, (sum, item) {
      return sum +
          ((item.product.price * item.product.discountPercentage) / 100) *
              item.quantity;
    });
  }

  // total final amount
  double get finalAmount {
    return subtotal - totalDiscount;
  }
}
