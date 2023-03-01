class OrderRequest {
  String username;

  List<OrderFoodRequest> foods;

  int totalItems;

  double totalPrice;

  String paymentPartner;

  String paymentMethod;

  String paymentStatus;

  OrderRequest(
      {required this.username,
      required this.foods,
      required this.totalItems,
      required this.totalPrice,
      required this.paymentPartner,
      required this.paymentMethod,
      required this.paymentStatus});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['foods'] = foods.map((v) => v.toJson()).toList();
    data['totalItems'] = totalItems;
    data['totalPrice'] = totalPrice;
    data['paymentPartner'] = paymentPartner;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    return data;
  }
}

class OrderFoodRequest {
  String menuFoodId;

  int quantity;

  OrderFoodRequest({required this.menuFoodId, required this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuFoodId'] = menuFoodId;
    data['quantity'] = quantity;
    return data;
  }
}
