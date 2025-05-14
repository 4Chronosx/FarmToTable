import 'package:farm2you/commons.dart';
import 'package:farm2you/screens/user_side/cart/cart_screen.dart';
import 'package:farm2you/screens/user_side/explore/explore_screen.dart';
import 'package:farm2you/screens/user_side/marketplace/marketplace_screen.dart';
import 'package:farm2you/screens/user_side/orders/orders_screen.dart';
import 'package:farm2you/utils/navigation_provider.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedIndex = 0;

  final List<Widget> widgetOptions = const [
    ExploreScreen(),
    MarketplaceScreen(),
    OrdersScreen(),
    CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: widgetOptions.elementAt(navProvider.currentIndexVar),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.locationDot), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.store), label: 'Marketplace'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cartShopping), label: 'Cart'),
        ],
        currentIndex: navProvider.currentIndex,
        onTap: (int index) {
          setState(() {
            navProvider.changePage(index);
          });
        },
      ),
    );
  }
}
