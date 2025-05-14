

import 'package:farm2you/models/checkout_model.dart';

class OrdersetModel {
    CheckoutModel storeOrders;
    String orderId;
    String orderDateTime;
    String paymentMethod;
    double orderTotal;
    String status;

    OrdersetModel({
      required this.storeOrders,
      required this.orderId,
      required this.orderDateTime,
      required this.status,
      required this.paymentMethod,
      required this.orderTotal
    });
    
}