import 'package:cloud_kitchen/pages/cart/cart_page.dart';
import 'package:cloud_kitchen/pages/food/food_page.dart';
import 'package:cloud_kitchen/pages/menu_by_restaurant/menu_by_restaurant_page.dart';
import 'package:cloud_kitchen/pages/order/order_page.dart';
import 'package:cloud_kitchen/pages/orders/orders_page.dart';
import 'package:cloud_kitchen/pages/payment_details/payment_details_page.dart';
import 'package:cloud_kitchen/pages/profilepage/main_profile_page.dart';
import 'package:cloud_kitchen/pages/profilepage/updateProfilePage.dart';
import 'package:cloud_kitchen/pages/restauraunt_menu_food/restaurant_menu_food_page.dart';
import 'package:cloud_kitchen/pages/search_food/search_food_page.dart';
import 'package:get/get.dart';

import '../pages/homepage/homepage.dart';
import '../pages/homepage/navigation.dart';

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
  static const String restaurantMenuFood = '/restaurantMenu/food';

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
  static String getRestaurantMenuFoodDetail(int foodId) =>
      '$restaurantMenuFood?foodId=$foodId';
  static String getCart() => cart;
  static String getUpdaTeProfile() => updateProfile;
  static String getPayments() => payments;
  static String getKhaltiPayment() => khaltiPayment;
  static List<GetPage> routes = [
    GetPage(name: homepage, page: () => const Homepage()),
    GetPage(
      name: navigation,
      page: () => const Navigation(),
      transition: Transition.noTransition,
    ),
    GetPage(name: searchFoods, page: () => const SearchFoodPage()),
    GetPage(name: orders, page: () => const OrdersPage()),
    GetPage(name: viewProfile, page: () => const ProfilePage()),
    GetPage(name: updateProfile, page: () => const UpdateProfilePage()),

    GetPage(name: payments, page: () => const PaymentDetailsPage()),
    GetPage(name: cart, page: () => const CartPage()),
    GetPage(name: restaurantMenu, page: () => const RestaurantMenu()),
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
    GetPage(
        name: restaurantMenuFood,
        page: () {
          var foodId = Get.parameters['foodId'];
          return RestaurantMenuFoodPage(
            foodId: int.parse(foodId!),
          );
    }),
  ];
}
