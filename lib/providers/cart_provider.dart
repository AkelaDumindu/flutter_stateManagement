import 'package:flutter/material.dart';
import 'package:flutter_state_management/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
// cart item state
  Map<String, CartItem> _items = {};

// getter so _items is private
  Map<String, CartItem> get items {
    return {..._items};
  }

  //add items
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // allready product add to the cart
      _items.update(
        productId,
        (exitingCartItem) => CartItem(
          id: exitingCartItem.id,
          title: exitingCartItem.title,
          price: exitingCartItem.price,
          quantity: exitingCartItem.quantity + 1, //add 1 to exiting quantity
        ),
      );
      print("add exiting data");
    } else {
      //product not in the cart
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );

      print("add new data");
    }
    notifyListeners();
  }

  // remove item from cart

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //one item remove from cart

  void oneItemRemove(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (exitingCartItem) => CartItem(
          id: exitingCartItem.id,
          title: exitingCartItem.title,
          price: exitingCartItem.price,
          quantity: exitingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
