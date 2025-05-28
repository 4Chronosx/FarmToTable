import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:intl/intl.dart';

class OrdersProvider extends ChangeNotifier {
  final List<OrdersetModel> _allOrders = [];

  // Getter for all orders (user side)
  List<OrdersetModel> get ordersetList => List.unmodifiable(_allOrders);

  // USER SIDE METHODS
  // Add new orders from checkout
  void initializeList(List<CheckoutModel> checkoutList) {
    for (CheckoutModel orderSet in checkoutList) {
      final newOrder = OrdersetModel(
          storeOrders: orderSet,
          orderDateTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
          orderId:
              '#${DateTime.now().millisecondsSinceEpoch}${orderSet.vendorId}',
          paymentMethod: 'Cash on Delivery',
          orderTotal: orderSet.totalPayment,
          status: 'Pending');
      _allOrders.insert(0, newOrder);
    }
    notifyListeners();
  }

  // Get user orders by status
  List<OrdersetModel> getUserOrdersByStatus(String status) {
    return _allOrders.where((order) => order.status == status).toList();
  }

  // VENDOR SIDE METHODS
  // Get orders for specific vendor
  List<OrdersetModel> getOrdersForVendor(String vendorId) {
    return _allOrders
        .where((order) => order.storeOrders.vendorId == vendorId)
        .toList();
  }

  // Get vendor orders by status (only Pending and Completed)
  List<OrdersetModel> getVendorOrdersByStatus(String vendorId, String status) {
    return _allOrders
        .where((order) =>
            order.storeOrders.vendorId == vendorId && order.status == status)
        .toList();
  }

  // Update order status (vendor side) - only Pending and Completed
  void updateOrderStatus(String orderId, String newStatus) {
    // Only allow Pending and Completed transitions
    if (!['Pending', 'Completed'].contains(newStatus)) {
      return;
    }

    final orderIndex =
        _allOrders.indexWhere((order) => order.orderId == orderId);
    if (orderIndex != -1) {
      final oldOrder = _allOrders[orderIndex];
      _allOrders[orderIndex] = OrdersetModel(
        storeOrders: oldOrder.storeOrders,
        orderId: oldOrder.orderId,
        orderDateTime: oldOrder.orderDateTime,
        paymentMethod: oldOrder.paymentMethod,
        orderTotal: oldOrder.orderTotal,
        status: newStatus,
      );
      notifyListeners();
    }
  }

  // VENDOR STATISTICS METHODS
  // Get total orders count for vendor
  int getTotalVendorOrders(String vendorId) =>
      getOrdersForVendor(vendorId).length;

  // Get pending orders count for vendor
  int getPendingVendorOrders(String vendorId) =>
      getVendorOrdersByStatus(vendorId, 'Pending').length;

  // Get completed orders count for vendor
  int getCompletedVendorOrders(String vendorId) =>
      getVendorOrdersByStatus(vendorId, 'Completed').length;

  // VENDOR ORDER LISTS BY STATUS (Only Pending and Completed)
  List<OrdersetModel> getPendingVendorOrdersList(String vendorId) =>
      getVendorOrdersByStatus(vendorId, 'Pending');

  List<OrdersetModel> getCompletedVendorOrdersList(String vendorId) =>
      getVendorOrdersByStatus(vendorId, 'Completed');

  // UTILITY METHODS
  // Get order by ID
  OrdersetModel? getOrderById(String orderId) {
    try {
      return _allOrders.firstWhere((order) => order.orderId == orderId);
    } catch (e) {
      return null;
    }
  }

  // Get total revenue for vendor (only from completed orders)
  double getTotalVendorRevenue(String vendorId) {
    return getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .fold(0.0, (sum, order) => sum + order.orderTotal);
  }

  // Get orders for a date range (useful for reports)
  List<OrdersetModel> getOrdersForDateRange(
      String vendorId, DateTime startDate, DateTime endDate) {
    return getOrdersForVendor(vendorId).where((order) {
      final orderDate =
          DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
      return orderDate.isAfter(startDate) && orderDate.isBefore(endDate);
    }).toList();
  }

  // Get orders count by status for analytics
  Map<String, int> getOrdersAnalytics(String vendorId) {
    final vendorOrders = getOrdersForVendor(vendorId);
    return {
      'total': vendorOrders.length,
      'pending':
          vendorOrders.where((order) => order.status == 'Pending').length,
      'completed':
          vendorOrders.where((order) => order.status == 'Completed').length,
    };
  }

  // Get recent orders (last 30 days)
  List<OrdersetModel> getRecentVendorOrders(String vendorId, {int days = 30}) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return getOrdersForVendor(vendorId).where((order) {
      final orderDate =
          DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
      return orderDate.isAfter(cutoffDate);
    }).toList();
  }

  // DASHBOARD SPECIFIC METHODS
  // Get monthly revenue for current year (for dashboard chart)
  List<double> getCurrentYearMonthlyRevenue(String vendorId) {
    final currentYear = DateTime.now().year;
    List<double> monthlyRevenue = List.filled(12, 0.0);

    final vendorOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    for (var order in vendorOrders) {
      try {
        final orderDate =
            DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
        if (orderDate.year == currentYear) {
          final monthIndex = orderDate.month - 1; // 0-based index
          monthlyRevenue[monthIndex] += order.orderTotal;
        }
      } catch (e) {
        print('Error parsing date: ${order.orderDateTime}');
      }
    }

    return monthlyRevenue;
  }

  // Get monthly revenue for any year
  List<double> getMonthlyRevenue(String vendorId, {int? year}) {
    final targetYear = year ?? DateTime.now().year;
    List<double> monthlyRevenue = List.filled(12, 0.0);

    final vendorOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    for (var order in vendorOrders) {
      try {
        final orderDate =
            DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
        if (orderDate.year == targetYear) {
          final monthIndex = orderDate.month - 1;
          monthlyRevenue[monthIndex] += order.orderTotal;
        }
      } catch (e) {
        print('Error parsing date: ${order.orderDateTime}');
      }
    }

    return monthlyRevenue;
  }

  // Get popular items statistics
  Map<String, Map<String, dynamic>> getPopularItems(String vendorId) {
    Map<String, Map<String, dynamic>> itemStats = {};

    final vendorOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    for (var order in vendorOrders) {
      for (var item in order.storeOrders.orders) {
        final productName = item.prodName;

        if (itemStats.containsKey(productName)) {
          // Update existing item
          itemStats[productName]!['totalSales'] += (item.price * item.quantity);
          itemStats[productName]!['quantitySold'] += item.quantity;
        } else {
          // Add new item
          itemStats[productName] = {
            'price': item.price,
            'totalSales': item.price * item.quantity,
            'quantitySold': item.quantity,
          };
        }
      }
    }

    return itemStats;
  }

  // Get top popular items (sorted by total sales)
  List<Map<String, dynamic>> getTopPopularItems(String vendorId,
      {int limit = 5}) {
    final itemStats = getPopularItems(vendorId);

    var sortedItems = itemStats.entries
        .map((entry) => {
              'productName': entry.key,
              'price': entry.value['price'],
              'totalSales': entry.value['totalSales'],
              'quantitySold': entry.value['quantitySold'],
            })
        .toList();

    // Sort by total sales (descending)
    sortedItems.sort((a, b) => b['totalSales'].compareTo(a['totalSales']));

    return sortedItems.take(limit).toList();
  }

  // Get top popular items by quantity sold
  List<Map<String, dynamic>> getTopPopularItemsByQuantity(String vendorId,
      {int limit = 5}) {
    final itemStats = getPopularItems(vendorId);

    var sortedItems = itemStats.entries
        .map((entry) => {
              'productName': entry.key,
              'price': entry.value['price'],
              'totalSales': entry.value['totalSales'],
              'quantitySold': entry.value['quantitySold'],
            })
        .toList();

    // Sort by quantity sold (descending)
    sortedItems.sort((a, b) => b['quantitySold'].compareTo(a['quantitySold']));

    return sortedItems.take(limit).toList();
  }

  // Get weekly revenue (last 7 days)
  double getWeeklyRevenue(String vendorId) {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final weeklyOrders = getOrdersForVendor(vendorId).where((order) {
      if (order.status != 'Completed') return false;
      try {
        final orderDate =
            DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
        return orderDate.isAfter(weekAgo);
      } catch (e) {
        return false;
      }
    });

    return weeklyOrders.fold(0.0, (sum, order) => sum + order.orderTotal);
  }

  // Get daily revenue for current month
  List<double> getCurrentMonthDailyRevenue(String vendorId) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<double> dailyRevenue = List.filled(daysInMonth, 0.0);

    final vendorOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    for (var order in vendorOrders) {
      try {
        final orderDate =
            DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);
        if (orderDate.year == now.year && orderDate.month == now.month) {
          final dayIndex = orderDate.day - 1; // 0-based index
          if (dayIndex >= 0 && dayIndex < daysInMonth) {
            dailyRevenue[dayIndex] += order.orderTotal;
          }
        }
      } catch (e) {
        print('Error parsing date: ${order.orderDateTime}');
      }
    }

    return dailyRevenue;
  }

  // Get average order value for vendor
  double getAverageOrderValue(String vendorId) {
    final completedOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    if (completedOrders.isEmpty) return 0.0;

    final totalRevenue =
        completedOrders.fold(0.0, (sum, order) => sum + order.orderTotal);
    return totalRevenue / completedOrders.length;
  }

  // Get revenue growth percentage (current month vs last month)
  double getRevenueGrowthPercentage(String vendorId) {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    final lastMonth = currentMonth == 1 ? 12 : currentMonth - 1;
    final lastMonthYear = currentMonth == 1 ? currentYear - 1 : currentYear;

    double currentMonthRevenue = 0.0;
    double lastMonthRevenue = 0.0;

    final vendorOrders = getOrdersForVendor(vendorId)
        .where((order) => order.status == 'Completed')
        .toList();

    for (var order in vendorOrders) {
      try {
        final orderDate =
            DateFormat('yyyy-MM-dd HH:mm').parse(order.orderDateTime);

        if (orderDate.year == currentYear && orderDate.month == currentMonth) {
          currentMonthRevenue += order.orderTotal;
        } else if (orderDate.year == lastMonthYear &&
            orderDate.month == lastMonth) {
          lastMonthRevenue += order.orderTotal;
        }
      } catch (e) {
        print('Error parsing date: ${order.orderDateTime}');
      }
    }

    if (lastMonthRevenue == 0) return currentMonthRevenue > 0 ? 100.0 : 0.0;

    return ((currentMonthRevenue - lastMonthRevenue) / lastMonthRevenue) * 100;
  }

  // Debug method to print all orders
  void debugPrintAllOrders() {
    print("=== ALL ORDERS DEBUG ===");
    print("Total orders: ${_allOrders.length}");
    for (var order in _allOrders) {
      print("Order: ${order.orderId}");
      print(
          "  Vendor: ${order.storeOrders.vendorName} (${order.storeOrders.vendorId})");
      print("  Status: ${order.status}");
      print("  Total: P${order.orderTotal}");
      print("  Items: ${order.storeOrders.orders.length}");
      print("  Date: ${order.orderDateTime}");
      print("---");
    }
    print("========================");
  }

  // Debug method to print vendor-specific orders
  void debugPrintVendorOrders(String vendorId) {
    final vendorOrders = getOrdersForVendor(vendorId);
    print("=== VENDOR ORDERS DEBUG ===");
    print("Vendor ID: $vendorId");
    print("Orders for this vendor: ${vendorOrders.length}");
    for (var order in vendorOrders) {
      print(
          "Order: ${order.orderId} - Status: ${order.status} - Total: P${order.orderTotal}");
    }
    print("===========================");
  }

  // Debug method to print dashboard analytics
  void debugPrintDashboardAnalytics(String vendorId) {
    print("=== DASHBOARD ANALYTICS DEBUG ===");
    print("Vendor ID: $vendorId");
    print("Total Revenue: P${getTotalVendorRevenue(vendorId)}");
    print("Pending Orders: ${getPendingVendorOrders(vendorId)}");
    print("Completed Orders: ${getCompletedVendorOrders(vendorId)}");
    print(
        "Average Order Value: P${getAverageOrderValue(vendorId).toStringAsFixed(2)}");
    print("Weekly Revenue: P${getWeeklyRevenue(vendorId)}");
    print(
        "Revenue Growth: ${getRevenueGrowthPercentage(vendorId).toStringAsFixed(1)}%");

    final monthlyRevenue = getCurrentYearMonthlyRevenue(vendorId);
    print(
        "Monthly Revenue: ${monthlyRevenue.map((r) => 'P${r.toStringAsFixed(0)}').join(', ')}");

    final popularItems = getTopPopularItems(vendorId, limit: 3);
    print("Top 3 Popular Items:");
    for (var item in popularItems) {
      print(
          "  ${item['productName']}: P${item['price']} - Total Sales: P${item['totalSales']}");
    }
    print("=================================");
  }
}
