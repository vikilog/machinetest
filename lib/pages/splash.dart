import 'package:flutter/material.dart';
import 'package:machinetest/services/auth.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/widgets/loading.dart';

import '../services/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      var user = await locator<Auth>().currentUser();
      if (user != null) {
        return locator<NavigationService>().navigateToAndRemove('/bottomBar');
      } else {
        return locator<NavigationService>().navigateToAndRemove('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loading(),
      ),
    );
  }
}
