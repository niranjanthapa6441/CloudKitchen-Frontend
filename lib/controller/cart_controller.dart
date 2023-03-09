import 'package:cloud_kitchen/model/cart.dart';
import 'package:get/get.dart';

import '../Response/foods.dart';

class CartController extends GetxController implements GetxService {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  bool hasValue = false;
  void add(Foods food, int quantity, double price) {
    CartItem cartItem = CartItem(food: food, quantity: quantity, price: price);
    for (var item in cartItems) {
      if (item.food.menuFoodId == food.menuFoodId) {
        item.quantity += quantity;
        item.price = item.quantity * food.price!;
        return;
      }
    }
    bool hasValue = true;
    cartItems.add(cartItem);
  }

  void addQuantity(Foods food, int quantity, double price) {
    for (var item in cartItems) {
      if (item.food.menuFoodId == food.menuFoodId) {
        item.quantity += 1;
        item.price = item.quantity * food.price!;
        return;
      }
    }
  }

  void subractQuantity(Foods food, int quantity, double price) {
    for (var item in cartItems) {
      if (item.food.menuFoodId == food.menuFoodId && item.quantity > 1) {
        item.quantity -= 1;
        item.price = item.quantity * food.price!;
        return;
      }
    }
  }

  void remove(Foods food, int quantity, double price) {
    if (cartItems.length < 2) {
      hasValue = false;
    }
    for (var item in cartItems) {
      if (item.food.menuFoodId == food.menuFoodId) {
        cartItems.remove(item);
        return;
      }
    }
  }
  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _cartItems.clear();
  }
}
