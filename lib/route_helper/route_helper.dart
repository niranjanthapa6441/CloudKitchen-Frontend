import 'package:cloud_kitchen/pages/food/food_page.dart';
import 'package:cloud_kitchen/pages/order/order_page.dart';
import 'package:cloud_kitchen/pages/orders/orders_page.dart';
import 'package:cloud_kitchen/pages/payment_details/payment_details_page.dart';
import 'package:cloud_kitchen/pages/search_food/search_food_page.dart';
import 'package:get/get.dart';

import '../pages/homepage/homepage.dart';
import '../pages/homepage/navigation.dart';
import '../pages/profile/profile_page.dart';

class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/signIn';
  static const String navigation = '/navigation';
  static const String signUp = '/signUp';
  static const String homepage = '/homepage';
  static const String searchFoods = '/searchFoods';
  static const String orders = '/orders';
  static const String viewProfile = '/viewProfile';
  static const String viewNotifications = '/viewNotifications';
  static const String foodDetail = '/foodDetail';
  static const String payments = '/payments';
  static const String restaurantMenu = '/menu';
  static const String orderDetail = '/orderDetail';
  static const String cart = '/cart';
  static const String confirmOrder = '/confirmOrder';
  static const String availablePaymentMethods = '/availablePaymentMethods';
  static const String updateProfile = '/updateProfile';
  static const String khaltiPayment = '/khaltiPayment';

  static String getInitial() => initial;
  static String getNavigation() => navigation;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getHomepage() => homepage;
  static String getSearchFoods() => searchFoods;
  static String getOrders() => orders;
  static String getViewProfile() => viewProfile;
  static String getViewNotiifcations() => viewNotifications;
  static String getRestaurantMenu() => restaurantMenu;
  static String getOrderDetail(int orderId) => '$orderDetail?orderId=$orderId';
  static String getAvailablePaymentMethods() => availablePaymentMethods;
  static String getConfirmOrder() => confirmOrder;
  static String getFoodDetail(int foodId) => '$foodDetail?foodId=$foodId';
  static String getCart() => cart;
  static String getUpdTeProfile() => updateProfile;
  static String getPayments() => payments;
  static String getKhaltiPayment() => khaltiPayment;
  static List<GetPage> routes = [
    GetPage(name: homepage, page: () => const Homepage()),
    GetPage(name: navigation, page: () => const Navigation()),
    GetPage(name: searchFoods, page: () => const SearchFoodPage()),
    GetPage(name: orders, page: () => const OrdersPage()),
    GetPage(name: viewProfile, page: () => const ProfilePage()),
    GetPage(name: payments, page: () => const PaymentDetailsPage()),
    GetPage(
        name: orderDetail,
        page: () {
          var orderId = Get.parameters['orderId'];
          return OrderPage(
            orderId: int.parse(orderId!),
          );
        }),
    GetPage(
        name: foodDetail,
        page: () {
          var foodId = Get.parameters['foodId'];
          return FoodPage(
            foodId: int.parse(foodId!),
          );
        }),
  ];
}
