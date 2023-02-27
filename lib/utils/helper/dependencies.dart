import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
}
