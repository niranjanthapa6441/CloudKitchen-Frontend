import 'package:cloud_kitchen/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_kitchen/utils/helper/dependencies.dart' as dep;
import 'package:cloud_kitchen/route_helper/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cloud Kitchen',
      theme: ThemeData(
          primaryColor: const Color(0xFF56328c),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF56328c),
          )),
      debugShowCheckedModeBanner: false,
      getPages: RouteHelper.routes,
      home: Homepage(),
    );
  }
}
