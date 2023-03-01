class AppConstant {
  static const String appName = "Cloud Kitchen";
  static const String baseURL = "http://100.64.218.31:8080/cloudKitchen/";
  static const String apiVersion = "/api/v1";

  static const String userId = "";
  static const String orderId = "";
  static const String menuFoodId = "";
  static const String category = "";
  static const String meal = "";
  static const double rating = 0.0;
  static const String restaurantName = "";
  static const int page = 0;
  static const int size = 5;
  static const String period = "";
  static const String startDate = "";
  static const String endDate = "";
  static const String paymentMethod = "";
  static const String paymentPartner = "";
  static const String sortBy = "";
  static const String foodName = "";
  static const String restaurantId = "";
  static const String username = "";

  static const String userURI = "/user";
  static const String searchFoodsURI =
      "/menu?foodName=$foodName&sortBy=$sortBy&page=$page&size=$size&category=$category&meal=$meal&rating=$rating&restaurantName=$restaurantName";
  static const String restaurantURI = "/restaurant";
  static const String restaurantMenuURI =
      "menu/restaurant/$restaurantId?foodName=$foodName&sortBy=$sortBy&page=$page&size=$size&category=$category&meal=$meal&rating=$rating&";
  static const String paymentsURI =
      "/payment?page=$page&startDate=$startDate&endDate=$endDate&username=$username&period=$period&paymentPartner=$paymentPartner&paymentMethod=$paymentMethod&size=$size";
  static const String ordersURI = "/customer/$userId?page=$page&size=$size";
  static const String categoryURI = "/category";
  static const String mealURI = "/meal";
  static const String paypalPaymentURI = "/payment/paypal";
  static const String loginURI = "/user/login";
  static const String registrationURI = "/user/registration";
  static const String stripePaymentURI = "/payment/stripe";
  static const String profileURI = "/user/$userId";
}
