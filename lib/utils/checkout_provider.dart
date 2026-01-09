import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orders_model.dart';

class CheckoutProvider extends ChangeNotifier {
  final List<CheckoutModel> checkoutList = [];

  
  Map<String, List<OrderModel>> _sortOrders(List<OrderModel> orders) {
    return orders.fold({}, (map, order) {
      map.putIfAbsent(order.vendorName, () => []).add(order);
      return map;
    });
  }

  void initializeList(List<OrderModel> selectedOrders) {
    checkoutList.clear();
    Map<String, List<OrderModel>> ordersByVendors = _sortOrders(selectedOrders);
    for (var key in ordersByVendors.keys) {
      checkoutList.add(CheckoutModel(
        vendorName: ordersByVendors[key]![0].vendorName, 
        vendorId: ordersByVendors[key]![0].vendorId, 
        orders: ordersByVendors[key]!, 
        totalPayment: ordersByVendors[key]!.fold(0.0, (sum, item) => sum + item.price * item.quantity)));
    }
    notifyListeners();
      
  }

  void addToCheckOutList(CheckoutModel checkoutItem) {
    checkoutList.clear();
    checkoutList.add(checkoutItem);
    notifyListeners();
  }

  double getTotalPayment() {
    return checkoutList.fold(0.0, (sum, item) => sum + item.totalPayment);
  }

  
}
