import 'package:cloud_kitchen/pages/homepage/homepage.dart';
import 'package:cloud_kitchen/pages/homepage/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_kitchen/utils/helper/dependencies.dart' as dep;
import 'package:cloud_kitchen/route_helper/route_helper.dart';

import 'controller/food_controller.dart';
import 'controller/order_controller.dart';
import 'controller/payment_controller.dart';
import 'controller/restaurant_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
    
  @override
  Widget build(BuildContext context) {
    Get.find<FoodController>().onClose();
    Get.find<RestaurantController>().onClose();
    Get.find<OrderController>().onClose();
    Get.find<PaymentController>().onClose();
    Get.find<FoodController>().get();
    Get.find<RestaurantController>().get();
    Get.find<OrderController>().get();
    Get.find<PaymentController>().get();
    return GetMaterialApp(
      title: 'Cloud Kitchen',
      theme: ThemeData(
          primaryColor: const Color(0xFF56328c),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF56328c),
          )),
      debugShowCheckedModeBanner: false,
      getPages: RouteHelper.routes,
      home: Navigation(),
    );
  }
}
