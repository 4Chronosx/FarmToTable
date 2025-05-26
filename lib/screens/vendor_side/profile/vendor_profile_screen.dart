import 'package:flutter/material.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';

class VendorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Container(
              // Your existing dashboard content goes here
              child: Center(
                child: Text('Profile Content'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: VendorNavigationBar(selectedIndex: 3),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 20),
            child: Center(
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1D1B20),
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.27,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
