import 'package:farm2you/models/category_model.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/screens/login/login_screen.dart';
import 'package:farm2you/screens/signup/signup_screen.dart';
import 'package:farm2you/screens/user_side/cart/cart_screen.dart';
import 'package:farm2you/screens/user_side/explore/explore_screen.dart';
import 'package:farm2you/screens/user_side/main_home_screen/main_home_screen.dart';
import 'package:farm2you/screens/user_side/marketplace/marketplace_screen.dart';
import 'package:farm2you/screens/user_side/orders/orders_screen.dart';
import 'package:farm2you/screens/user_side/sub_pages/category/category_page.dart';
import 'package:farm2you/screens/user_side/sub_pages/product_details/product_details_page.dart';
import 'package:flutter/services.dart';
import 'package:farm2you/screens/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}


/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splashscreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/category',
          builder: (BuildContext context, GoRouterState state) {
            final category = state.extra as CategoryModel;
            return CategoryPage(category: category);
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupScreen();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: '/mainhomescreen',
          builder: (BuildContext context, GoRouterState state) {
            return const MainHomeScreen();
          },
        ),
        GoRoute(
          path: '/explore',
          builder: (BuildContext context, GoRouterState state) {
            return const ExploreScreen();
          },
        ),
        GoRoute(
          path: '/marketplace',
          builder: (BuildContext context, GoRouterState state) {
            return const MarketplaceScreen();
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (BuildContext context, GoRouterState state) {
            return const CartScreen();
          },
        ),
        GoRoute(
          path: '/orders',
          builder: (BuildContext context, GoRouterState state) {
            return const OrdersScreen();
          },
        ),
        GoRoute(
          path: '/product_details',
          builder: (BuildContext context, GoRouterState state) {
             final product = state.extra as ProductModel;
            return ProductDetailsPage(product : product);
          },
        ),

      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white
        )
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
