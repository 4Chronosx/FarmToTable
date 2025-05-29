import 'package:farm2you/commons.dart';
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
import 'package:farm2you/screens/vendor_side/profile/create_profile_screen.dart';
import 'package:farm2you/screens/vendor_side/profile/store_location_screen.dart';
import 'package:farm2you/screens/vendor_side/profile/registered_screen.dart';
import 'package:farm2you/screens/vendor_side/profile/vendor_profile_screen.dart';
import 'package:farm2you/screens/vendor_side/dashboard/dashboard_screen.dart';
import 'package:farm2you/screens/vendor_side/inventory/addproduct_screen.dart';
import 'package:farm2you/screens/vendor_side/inventory/editproduct_screen.dart';
import 'package:farm2you/screens/vendor_side/inventory/vendor_product_details_screen.dart';
import 'package:farm2you/screens/vendor_side/inventory/inventory_screen.dart';
import 'package:farm2you/screens/vendor_side/orders/vendor_orders_screen.dart';
import 'package:farm2you/screens/vendor_side/orders/completedorders_screen.dart';
import 'package:farm2you/screens/vendor_side/orders/pendingorders_screen.dart';
import 'package:farm2you/utils/cart_provider.dart';
import 'package:farm2you/utils/checkout_provider.dart';
import 'package:farm2you/utils/navigation_provider.dart';
import 'package:farm2you/utils/orders_provider.dart';
import 'package:farm2you/utils/inventory_provider.dart';
import 'package:farm2you/utils/profile_provider.dart';
import 'package:farm2you/utils/vendor_provider.dart';
import 'package:flutter/services.dart';
import 'package:farm2you/screens/splashscreen/splashscreen.dart';
import 'package:farm2you/screens/splashscreen/splashscreen2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => VendorProvider()),
        ChangeNotifierProxyProvider<VendorProvider, ProfileProvider>(
          create: (context) => ProfileProvider(context.read<VendorProvider>()),
          update: (context, vendorProvider, previous) =>
              previous ?? ProfileProvider(vendorProvider),
        ),
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
      path: '/splash2',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen2();
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
    //Vendor Side
    GoRoute(
      path: '/createprofilevendor',
      builder: (BuildContext context, GoRouterState state) {
        return CreateProfileScreen();
      },
    ),
    GoRoute(
      path: '/storelocation',
      builder: (BuildContext context, GoRouterState state) {
        return StoreLocationScreen();
      },
    ),
    GoRoute(
      path: '/registeredsplash',
      builder: (BuildContext context, GoRouterState state) {
        return RegisteredScreen();
      },
    ),
    GoRoute(
      path: '/vendorprofile',
      builder: (BuildContext context, GoRouterState state) {
        return VendorProfileScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardScreen();
      },
    ),
    GoRoute(
      path: '/addproduct',
      builder: (BuildContext context, GoRouterState state) {
        return AddProductScreen();
      },
    ),
    GoRoute(
      path: '/editproduct',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.extra as int;
        return EditProductScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/vendor_product_details',
      builder: (BuildContext context, GoRouterState state) {
        final product = state.extra as ProductModel;
        return VendorProductDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: '/inventory',
      builder: (BuildContext context, GoRouterState state) {
        return InventoryScreen();
      },
    ),
    GoRoute(
      path: '/vendororders',
      builder: (BuildContext context, GoRouterState state) {
        return Consumer<VendorProvider>(
          builder: (context, vendorProvider, child) {
            return VendorOrdersScreen(
              vendorId: vendorProvider.currentVendorId,
              vendorName: vendorProvider.currentVendorName,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/completedorders',
      builder: (BuildContext context, GoRouterState state) {
        return CompletedOrdersScreen();
      },
    ),
    GoRoute(
      path: '/pendingorders',
      builder: (BuildContext context, GoRouterState state) {
        return PendingOrdersScreen();
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
