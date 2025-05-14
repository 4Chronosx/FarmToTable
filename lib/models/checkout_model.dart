

import 'package:farm2you/models/orders_model.dart';

class CheckoutModel {
  String vendorName;
  String vendorId;
  List<OrderModel> orders;
  double totalPayment;

  CheckoutModel({
    required this.vendorName,
    required this.vendorId,
    required this.orders,
    required this.totalPayment
  });




}