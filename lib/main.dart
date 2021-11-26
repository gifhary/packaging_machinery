import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/route/app_route.dart';
import 'package:packaging_machinery/route/route_constant.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Packaging Machinery',
      getPages: AppRoute.all,
      initialRoute: RouteConstant.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
