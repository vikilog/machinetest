import 'package:flutter/material.dart';
import 'package:machinetest/pages/auth/login.dart';
import 'package:machinetest/pages/bottombar.dart';
import 'package:machinetest/pages/category.dart';
import 'package:machinetest/pages/home.dart';
import 'package:machinetest/pages/profile.dart';
import 'package:machinetest/pages/splash.dart';

import './const/routes.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.home:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePage(),
      );
    case routes.category:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProductCategory(),
      );
    case routes.profile:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const Profile(),
      );
    case routes.splash:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashScreen(),
      );
    case routes.bottomBar:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BottomBar(),
      );

    case routes.login:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const Login(),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePage(),
      );
  }
}
