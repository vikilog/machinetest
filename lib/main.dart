import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/provider/category.dart';
import 'package:machinetest/provider/product.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/navigation.dart';
import 'package:provider/provider.dart';
import './router.dart' as router;
import './const/routes.dart' as routes;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Machine Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: routes.login,
      ),
    );
  }
}
