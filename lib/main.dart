import 'package:farm2you/models/category_model.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/screens/login/login_screen.dart';
import 'package:farm2you/screens/signup/signup_screen.dart';
import 'package:farm2you/screens/user_side/cart/cart_screen.dart';
import 'package:farm2you/screens/user_side/explore/explore_screen.dart';
import 'package:farm2you/screens/user_side/main_home_screen/main_home_screen.dart';
import 'package:farm2you/screens/user_side/marketplace/marketplace_screen.dart';
import 'package:farm2you/screens/user_side/orders/orders_screen.dart';
import 'package:farm2you/screens/user_side/sub_pages/category/category_page.dart';
import 'package:farm2you/screens/user_side/sub_pages/checkout/checkout_page.dart';
import 'package:farm2you/screens/user_side/sub_pages/order_details/order_details.dart';
import 'package:farm2you/screens/user_side/sub_pages/product_details/product_details_page.dart';
import 'package:farm2you/screens/vendor_side/create_profile_screen.dart';
import 'package:farm2you/services/authentication/auth_gate.dart';
import 'package:farm2you/utils/cart_provider.dart';
import 'package:farm2you/utils/checkout_provider.dart';
import 'package:farm2you/utils/navigation_provider.dart';
import 'package:farm2you/utils/orders_provider.dart';
import 'package:flutter/services.dart';
import 'package:farm2you/screens/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(url: "https://zhvosnfvtoqalhjfpjfm.supabase.co", anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpodm9zbmZ2dG9xYWxoamZwamZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDczNTgzMjIsImV4cCI6MjA2MjkzNDMyMn0.cVRsslf1HRPG92Tuc45Q4cr0CxjmWjCzDe12hnZ4Esg");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider())
      ],
      child: MyApp(),
    ),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splashscreen();
      },
    ),
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
        return ProductDetailsPage(product: product);
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (BuildContext context, GoRouterState state) {
        final fromBuyNow = state.extra as bool;
        return CheckoutPage(fromBuyNow: fromBuyNow);
      },
    ),
    GoRoute(
      path: '/orderdetails',
      builder: (BuildContext context, GoRouterState state) {
        final orderSet = state.extra as OrdersetModel;
        return OrderDetails(orderSet: orderSet);
      },
    ),
    GoRoute(
      path: '/createprofilevendor',
      builder: (BuildContext context, GoRouterState state) {
        return CreateProfileScreen();
      },
    ),
    GoRoute(
      path: '/authgate',
      builder: (BuildContext context, GoRouterState state) {
        return AuthGate();
      },
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
          scaffoldBackgroundColor: Color(0xFFf8f7f9),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
          navigationBarTheme:
              NavigationBarThemeData(backgroundColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
