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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.foods != null) {
      data['restaurants'] = this.foods.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = this.totalItems;
    data['totalPrice'] = this.totalPrice;
    data['paymentPartner'] = this.paymentPartner;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}

class OrderFoodRequest {
  String menuFoodId;

  int quantity;

  OrderFoodRequest({required this.menuFoodId, required this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuFoodId'] = this.menuFoodId;
    data['quantity'] = this.quantity;
    return data;
  }
}
