import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';
import 'package:farm2you/utils/orders_provider.dart';
import 'package:farm2you/utils/profile_provider.dart';
import 'package:farm2you/utils/vendor_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<String> months = const [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JULY',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // Header Section
            _buildHeader(context),
            const SizedBox(height: 40),

            // Stats Cards
            _buildStatsCards(context),
            const SizedBox(height: 30),

            // Revenue Section
            _buildRevenueSection(context),
            const SizedBox(height: 30),

            // Popular Items Section
            _buildPopularItemsSection(context),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: VendorNavigationBar(selectedIndex: 0),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final vendorProvider = Provider.of<VendorProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi ${profileProvider.fullNameController.text.isNotEmpty ? profileProvider.fullNameController.text : vendorProvider.currentVendorName},',
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              profileProvider.businessNameController.text.isNotEmpty
                  ? profileProvider.businessNameController.text
                  : vendorProvider.currentVendorName,
              style: const TextStyle(
                color: Color(0xFF838383),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final vendorProvider = Provider.of<VendorProvider>(context);

    // Get current vendor ID
    final vendorId = vendorProvider.currentVendorId;

    // Get actual order counts from provider
    final pendingOrders = vendorId.isNotEmpty
        ? ordersProvider.getPendingVendorOrders(vendorId)
        : 0;
    final completedOrders = vendorId.isNotEmpty
        ? ordersProvider.getCompletedVendorOrders(vendorId)
        : 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(pendingOrders.toString(), 'PENDING ORDERS'),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildStatCard(completedOrders.toString(), 'COMPLETED ORDERS'),
        ),
      ],
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF32343E),
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF838699),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueSection(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final vendorProvider = Provider.of<VendorProvider>(context);
    final vendorId = vendorProvider.currentVendorId;

    // Get real revenue data
    final totalRevenue = vendorId.isNotEmpty
        ? ordersProvider.getTotalVendorRevenue(vendorId)
        : 0.0;
    final monthlyRevenue = vendorId.isNotEmpty
        ? ordersProvider.getCurrentYearMonthlyRevenue(vendorId)
        : List.filled(12, 0.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Revenue',
                    style: TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'P${totalRevenue.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8E9EC)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: Color(0xFF9B9BA5),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xFF9B9BA5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Simple Chart Placeholder - Replace with actual chart
          _buildSimpleChart(monthlyRevenue),

          const SizedBox(height: 10),
          // Month labels (first 7 months)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: months
                .take(7)
                .map((month) => Text(
                      month,
                      style: const TextStyle(
                        color: Color(0xFF9B9BA5),
                        fontSize: 9,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleChart(List<double> monthlyRevenue) {
    final maxRevenue = monthlyRevenue.isNotEmpty
        ? monthlyRevenue.reduce((a, b) => a > b ? a : b)
        : 600.0;
    final normalizeBase = maxRevenue > 0 ? maxRevenue : 600.0;

    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          // Show first 7 months
          double height = monthlyRevenue.length > index
              ? (monthlyRevenue[index] / normalizeBase) * 100
              : 0.0;
          bool isHighlighted = index == 2 &&
              monthlyRevenue.length > index &&
              monthlyRevenue[index] > 0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isHighlighted) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF32343E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '₱${monthlyRevenue[index].toInt()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Color(0xFFFAE526), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
              ],
              Container(
                width: 4,
                height:
                    height > 0 ? height : 2, // Minimum height for visibility
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFAE526), Color(0x00FFEE84)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPopularItemsSection(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final vendorProvider = Provider.of<VendorProvider>(context);
    final vendorId = vendorProvider.currentVendorId;

    // Get real popular items data
    final popularItems = vendorId.isNotEmpty
        ? ordersProvider.getTopPopularItems(vendorId, limit: 4)
        : <Map<String, dynamic>>[];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Items This Week',
                style: TextStyle(
                  color: Color(0xFF32343E),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Table Headers
          const Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text('Product',
                      style: TextStyle(fontWeight: FontWeight.w500))),
              Expanded(
                  child: Text('Price',
                      style: TextStyle(fontWeight: FontWeight.w500))),
              Expanded(
                  child: Text('Total Sales',
                      style: TextStyle(fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 16),

          // Real Data from OrdersProvider
          if (popularItems.isNotEmpty)
            ...popularItems.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(item['productName'],
                              style: const TextStyle(fontSize: 12))),
                      Expanded(
                          child: Text('P${item['price'].toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 12))),
                      Expanded(
                          child: Text(
                              '₱${item['totalSales'].toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 12))),
                    ],
                  ),
                ))
          else
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'No sales data available yet',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF838699),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
