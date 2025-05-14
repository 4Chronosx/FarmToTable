

import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:intl/intl.dart';

class OrdersProvider extends ChangeNotifier {
  final List<OrdersetModel> ordersetList = [];


  void initializeList(List<CheckoutModel> checkoutList) {
    for (CheckoutModel orderSet in checkoutList) {
      ordersetList.insert(0, OrdersetModel(
        storeOrders: orderSet, 
        orderDateTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        orderId: '#${DateTime.now().toString().replaceAll(RegExp(r'[- :.]'), '')}',
        paymentMethod: 'Cash on Delivery',
        orderTotal: orderSet.totalPayment,
        status: 'Pending')
      );
    }
    notifyListeners();
  }

  
}