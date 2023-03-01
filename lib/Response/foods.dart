class FoodResponse {
  late String _code;
  late String _message;
  late Data _data;

  String get code => _code;
  String get message => _message;
  Data get data => _data;

  FoodResponse({required code, required message, required data}) {
    _code = code;
    _message = message;
    _data = data;
  }

  FoodResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late List<Foods> _foods;
  late int _currentPage;
  late int _totalElements;
  late int _totalPages;
  List<Foods> get foods => _foods;
  int get currentPage => _currentPage;
  int get totalElements => _totalElements;
  int get totalPages => _totalPages;

  Data(
      {required foods,
      required currentPage,
      required totalElements,
      required totalPages}) {
    _foods = foods;
    _totalElements = totalElements;
    _currentPage = currentPage;
    _totalPages = totalPages;
  }
  Data.fromJson(Map<String, dynamic> json) {
    if (json['menuFoods'] != null) {
      json['menuFoods'].forEach((v) {
        _foods.add(Foods.fromJson(v));
      });
    }
    _currentPage = json['currentPage'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }
}

class Foods {
  String? menuFoodId;
  String? name;
  String? description;
  double? rating;
  String? deliveryTime;
  String? restaurantName;
  String? restaurantAddress;
  String? category;
  int? price;
  int? discountPrice;
  String? imagePath;
  String? meal;

  Foods(
      {this.menuFoodId,
      this.name,
      this.description,
      this.rating,
      this.deliveryTime,
      this.restaurantName,
      this.restaurantAddress,
      this.category,
      this.price,
      this.discountPrice,
      this.imagePath,
      this.meal});

  Foods.fromJson(Map<String, dynamic> json) {
    menuFoodId = json['menuFoodId'];
    name = json['name'];
    description = json['description'];
    rating = json['rating'];
    deliveryTime = json['deliveryTime'];
    restaurantName = json['restaurantName'];
    restaurantAddress = json['restaurantAddress'];
    category = json['category'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    imagePath = json['imagePath'];
    meal = json['meal'];
  }
}
