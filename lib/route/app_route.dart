import 'package:get/get.dart';
import 'package:packaging_machinery/screen/home_screen.dart';
import 'package:packaging_machinery/screen/login_screen.dart';

import 'route_constant.dart';

class AppRoute {
  static final all = [
    GetPage(name: RouteConstant.home, page: () => const HomeScreen()),
    GetPage(name: RouteConstant.login, page: () => const LoginScreen()),
  ];
}
