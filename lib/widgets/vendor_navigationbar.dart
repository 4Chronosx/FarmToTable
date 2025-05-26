import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VendorNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const VendorNavigationBar({
    Key? key,
    required this.selectedIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.only(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            icon: _buildDashboardIcon(),
            label: 'Dashboard',
            isSelected: selectedIndex == 0,
            context: context,
          ),
          _buildNavItem(
            index: 1,
            icon: const Icon(FontAwesomeIcons.cartShopping, size: 24),
            label: 'Orders',
            isSelected: selectedIndex == 1,
            context: context,
          ),
          _buildNavItem(
            index: 2,
            icon: const Icon(FontAwesomeIcons.list, size: 24),
            label: 'Inventory',
            isSelected: selectedIndex == 2,
            context: context,
          ),
          _buildNavItem(
            index: 3,
            icon: _buildProfileIcon(),
            label: 'Profile',
            isSelected: selectedIndex == 3,
            context: context,
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    String routeName;
    switch (index) {
      case 0:
        routeName = '/dashboard';
        break;
      case 1:
        routeName = '/vendororders';
        break;
      case 2:
        routeName = '/inventory';
        break;
      case 3:
        routeName = '/vendorprofile';
        break;
      default:
        routeName = '/dashboard';
    }

    context.push(routeName);
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    required bool isSelected,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(index);
        } else {
          _navigateToScreen(context, index);
        }
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container with selection indicator
            Container(
              width: 40,
              height: 32,
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFFFAE526) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? const Color(0xFF1C2414)
                        : const Color(0xFF647A4C),
                    BlendMode.srcIn,
                  ),
                  child: icon,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1C2414),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.23,
                letterSpacing: 0.50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardIcon() {
    return Container(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Positioned(
            left: 7,
            top: 2,
            child: Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 1,
            bottom: 2,
            child: Container(
              width: 22,
              height: 12,
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
