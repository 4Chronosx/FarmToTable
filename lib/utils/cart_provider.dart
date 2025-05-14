import 'package:flutter/material.dart';
import 'package:farm2you/models/orders_model.dart';



class CartProvider extends ChangeNotifier {
  final List<OrderModel> _cart = [];
  List<OrderModel> toRemove = [];

  List<OrderModel> get cartOrders => _cart;

  void addOrder(OrderModel order) {
    int index = _cart.indexWhere((item) => item.prodId == order.prodId);
    if (index != -1) {
      updateQuantity(order.quantity, _cart[index]);
      _cart[index].selectedInCart = true;
    } else {
      _cart.add(order);
    }
    
    notifyListeners();
  }

  double getTotalPayment() {
  return _cart.fold(0.0, (sum, item) {
    if (item.selectedInCart) {
      return sum + item.price * item.quantity;
    }
    return sum;
  });
}


  bool isSelectAllInCartValueTrue() {
    return _cart.every((item) => item.selectedInCart == true);
  }

  void selectAllTrueInCart() {
    for (OrderModel item in _cart) {
      item.selectedInCart = true;

    }
  }

  void selectAllFalseInCart() {
    for (OrderModel item in _cart) {
      item.selectedInCart = false;

    }
  }

void toggleSelection(OrderModel order) {
  final index = cartOrders.indexOf(order);
  if (index != -1) {
    cartOrders[index].selectedInCart = !cartOrders[index].selectedInCart;
    notifyListeners();
  }
}

void increaseQuant(OrderModel order) {
    if (order.quantity < 100) {
      order.quantity++;
    }
    notifyListeners();
  }

  void decreaseQuant(OrderModel order) {
    if (order.quantity > 0) {
      order.quantity--;
    }
    notifyListeners();
  }
  
void updateQuantity(int newQuantity, OrderModel order) {
    if (newQuantity >= 0) {
      order.quantity = newQuantity;
    } else {
      throw ArgumentError('Quantity cannot be negative');
    }
  }

void getRemove() {
  for (OrderModel item in _cart) {
    if (item.selectedInCart == true) {
      toRemove.add(item);
    }
  }
}

void filterOutSelected() {
  for (OrderModel item in toRemove) {
    if (item.selectedInCart == true) {
      _cart.remove(item);
    }
  }
}
  
}

