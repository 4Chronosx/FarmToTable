import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farm2you/utils/orders_provider.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';

class VendorOrdersScreen extends StatefulWidget {
  final String vendorId;
  final String vendorName;

  const VendorOrdersScreen({
    Key? key,
    required this.vendorId,
    required this.vendorName,
  }) : super(key: key);

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Consumer<OrdersProvider>(
              builder: (context, ordersProvider, child) {
                return Column(
                  children: [
                    // Tab Bar
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Color(0xFFF0D003),
                        unselectedLabelColor: Colors.grey[600],
                        indicatorColor: Color(0xFFF0D003),
                        indicatorWeight: 3,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        tabs: [
                          Tab(text: 'Pending'),
                          Tab(text: 'Completed'),
                        ],
                      ),
                    ),

                    // Statistics Row
                    Container(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            _buildStatCard(
                              'Pending',
                              ordersProvider
                                  .getPendingVendorOrders(widget.vendorId)
                                  .toString(),
                              Colors.orange,
                              FontAwesomeIcons.clock,
                              screenWidth,
                            ),
                            SizedBox(width: 25),
                            _buildStatCard(
                              'Completed',
                              ordersProvider
                                  .getCompletedVendorOrders(widget.vendorId)
                                  .toString(),
                              Colors.green,
                              FontAwesomeIcons.checkCircle,
                              screenWidth,
                            ),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),

                    // Orders TabView
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildOrdersList(
                              ordersProvider
                                  .getPendingVendorOrdersList(widget.vendorId),
                              'Pending',
                              ordersProvider),
                          _buildOrdersList(
                              ordersProvider.getCompletedVendorOrdersList(
                                  widget.vendorId),
                              'Completed',
                              ordersProvider),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: VendorNavigationBar(selectedIndex: 1),
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
          child: Padding(
            padding: EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 20),
            child: Center(
              child: Text(
                'Orders',
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

  Widget _buildStatCard(String title, String value, Color color, IconData icon,
      double screenWidth) {
    return Container(
      width: screenWidth * 0.4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(99, 99, 99, 0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<OrdersetModel> orders, String currentStatus,
      OrdersProvider ordersProvider) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                FontAwesomeIcons.inbox,
                size: 32,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'No $currentStatus Orders',
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              currentStatus == 'Pending'
                  ? 'New orders will appear here'
                  : 'Completed orders will appear here',
              style: TextStyle(
                color: Colors.grey[500],
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order, currentStatus, ordersProvider);
      },
    );
  }

  Widget _buildOrderCard(OrdersetModel order, String currentStatus,
      OrdersProvider ordersProvider) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(99, 99, 99, 0.1),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderId,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendar,
                              size: 12, color: Colors.grey[500]),
                          SizedBox(width: 6),
                          Text(
                            order.orderDateTime,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(order.status).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        order.status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(order.status),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Payment Method
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.moneyBill,
                      size: 14, color: Color(0xFFF0D003)),
                  SizedBox(width: 8),
                  Text(
                    order.paymentMethod,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Order Items Header
            Row(
              children: [
                Icon(FontAwesomeIcons.shoppingCart,
                    size: 14, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  'Items (${order.storeOrders.orders.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Order Items List
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF0D003).withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFF0D003).withOpacity(0.1)),
              ),
              child: Column(
                children: order.storeOrders.orders.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isLast = index == order.storeOrders.orders.length - 1;

                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: !isLast
                          ? Border(
                              bottom: BorderSide(
                                color: Color(0xFFF0D003).withOpacity(0.2),
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: item.imgPath,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  FontAwesomeIcons.image,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  FontAwesomeIcons.imagePortrait,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.prodName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Unit: ${item.unit}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'P ${item.price.toStringAsFixed(2)} × ${item.quantity}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    'P ${(item.price * item.quantity).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFF0D003),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20),

            // Total and Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'P ${order.orderTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Color(0xFFF0D003),
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                if (currentStatus == 'Pending')
                  ElevatedButton(
                    onPressed: () => _updateOrderStatus(
                        order.orderId, 'Completed', ordersProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.check, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Mark Complete',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (currentStatus == 'Completed')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.trophy,
                            size: 12, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Order Fulfilled',
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.yellow;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _updateOrderStatus(
      String orderId, String newStatus, OrdersProvider ordersProvider) {
    ordersProvider.updateOrderStatus(orderId, newStatus);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              FontAwesomeIcons.circleCheck,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              'Order completed successfully!',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ],
        ),
        backgroundColor: _getStatusColor(newStatus),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }
}
