class AppConstant {
  static const String appName = "Cloud Kitchen";
  static const String baseURL = "http://127.0.0.1:8080/cloudKitchen";
  static String apiVersion = "/api/v1";

  static String userId = "1";
  static String orderId = "";
  static String menuFoodId = "";
  static String category = "";
  static String meal = "";
  static double rating = 0.0;
  static String restaurantName = "";
  static int page = 1;
  static int size = 5;
  static String period = "";
  static String startDate = "";
  static String endDate = "";
  static String paymentMethod = "";
  static String paymentPartner = "";
  static String sortBy = "";
  static String foodName = "";
  static String restaurantId = "";
  static String username = "niranjan";
  static String latitude = "";
  static String longitude = "";
  static String userURI = "/user";
  static String searchFoodsURI = "";
  static String restaurantURI = "";
  static String restaurantMenuURI = "";
  static String paymentsURI = "";
  static String ordersURI = "";
  static String categoryURI = "$apiVersion/category";
  static String mealURI = "$apiVersion/meal";
  static String paypalPaymentURI = "$apiVersion/payment/paypal";
  static String loginURI = "$apiVersion/user/login";
  static String registrationURI = "$apiVersion/user/registration";
  static String stripePaymentURI = "$apiVersion/payment/stripe";
  static String profileURI = "$apiVersion/user/$userId";
  static String saveOrderURI = "$apiVersion/order";

  static String searchFoodsURi() {
    searchFoodsURI =
        "$apiVersion/menu?restaurantId=$restaurantId&foodName=$foodName&sortBy=$sortBy&page=$page&size=$size&category=$category&meal=$meal&rating=$rating&restaurantName=$restaurantName";
    ;
    return searchFoodsURI;
  }

  static String ordersURi() {
    ordersURI =
        "$apiVersion/order/customer/$userId?size=$size&page=$page&period=$period&startDate=$startDate&endDate=$endDate&sortBy=$sortBy";
    ;
    return ordersURI;
  }

  static String paymentsURi() {
    paymentsURI =
        "$apiVersion/payment?page=$page&startDate=$startDate&endDate=$endDate&username=$username&period=$period&paymentPartner=$paymentPartner&paymentMethod=$paymentMethod&size=$size";
    return paymentsURI;
  }

  static String restaurantMenuURi() {
    restaurantMenuURI =
        "$apiVersion/menu/restaurant?sortBy=$sortBy&size=$size&category=$category&page=$page&restaurantId=$restaurantId&foodName=$foodName&rating=$rating";
    return restaurantMenuURI;
  }

  static String restaurantURi() {
    restaurantURI =
      "$apiVersion/restaurant?restaurantName=$restaurantName&page=$page&size=$size&latittude=$latitude&longitude=$longitude&rating=$rating";
    return restaurantURI;
  }
}
