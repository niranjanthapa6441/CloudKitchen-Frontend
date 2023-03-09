import '../Response/foods.dart';

class CartItem {
  Foods food;
  int quantity;
  double price;

  CartItem({required this.food, required this.quantity, required this.price});
}
