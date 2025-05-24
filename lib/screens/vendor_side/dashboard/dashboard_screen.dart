import 'package:flutter/material.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Center(
          child: Text('Dashboard Content'),
        ),
      ),
      bottomNavigationBar: VendorNavigationBar(selectedIndex: 0),
    );
  }
}
