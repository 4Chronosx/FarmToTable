import 'package:farm2you/commons.dart';
import 'package:farm2you/models/orders_model.dart';
import 'package:farm2you/utils/cart_provider.dart';
import 'package:farm2you/utils/checkout_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
            style: TextStyle(
              fontFamily: 'Poppins',
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: cartProvider.cartOrders.isEmpty
          ? Center(
              child: Text(
                'Cart is empty!',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
            )
          : Stack(
              children: [
                cartListBuilder(screenWidth),
                summaryBar(screenWidth, cartProvider, checkoutProvider)
              ],
            ),
    );
  }

  Align summaryBar(double screenWidth, CartProvider cartProvider,
      CheckoutProvider checkoutProvider) {
    final selectedOrders =
        cartProvider.cartOrders.where((o) => o.selectedInCart).toList();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        width: screenWidth * 0.9,
        margin: EdgeInsets.only(bottom: 10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 12,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  4,
                ),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('All',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
                Checkbox(
                    value: cartProvider.isSelectAllInCartValueTrue(),
                    checkColor: Colors.white,
                    fillColor: WidgetStatePropertyAll(
                        cartProvider.isSelectAllInCartValueTrue() == true
                            ? Color(0xFF77905B)
                            : Colors.white),
                    onChanged: (bool? newValue) {
                      setState(() {
                        if (cartProvider.isSelectAllInCartValueTrue() ==
                            false) {
                          cartProvider.selectAllTrueInCart();
                        } else {
                          cartProvider.selectAllFalseInCart();
                        }
                      });
                    }),
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                SizedBox(width: 5),
                Text(
                  cartProvider.getTotalPayment().toString(),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFF0D003),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              width: 110,
              height: 40,
              child: ElevatedButton(
                onPressed: selectedOrders.isNotEmpty ? () {
                  checkoutProvider.initializeList(selectedOrders);
                  context.push('/checkout', extra: false);
                } : null,
                style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: WidgetStatePropertyAll(selectedOrders.isNotEmpty ?Color(0xFFFAE526) : Color.fromARGB(255, 197, 197, 193)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
                child: Text(
                  'Check Out (${selectedOrders.length})',
                  style: TextStyle(fontFamily: 'Lato', color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container cartListBuilder(double screenWidth) {
    return Container(
        width: screenWidth,
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: cartProvider.cartOrders.length,
              itemBuilder: (context, index) {
                final order = cartProvider.cartOrders[index];
                return Dismissible(
                  key: ValueKey(cartProvider.cartOrders[index]),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      cartProvider.cartOrders.removeAt(index);
                    });
                    
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Tooltip(
                    message: 'Slide left to delete',
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                blurRadius: 12,
                                spreadRadius: 0,
                                offset: Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                    value: order.selectedInCart,
                                    side: BorderSide.none,
                                    checkColor: Colors.white,
                                    fillColor: WidgetStatePropertyAll(
                                        order.selectedInCart == true
                                            ? Color(0xFF77905B)
                                            : Colors.white),
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        cartProvider.toggleSelection(order);
                                      });
                                    }),
                                SizedBox(width: 20),
                                Container(
                                    height: 100,
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.prodName,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${order.price}/${order.unit}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        addrSbtrBtn(order, cartProvider),
                                      ],
                                    ))
                              ],
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  CachedNetworkImage(imageUrl: order.imgPath),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }

  Container addrSbtrBtn(OrderModel order, CartProvider cartProvider) {
    return Container(
        height: 25,
        width: 80,
        color: Color(0xFFFAE526),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartProvider.decreaseQuant(order);
                  });
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFFAE526)),
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)))),
                child: Icon(
                  FontAwesomeIcons.minus,
                  size: 10,
                ),
              ),
            ),
            Text('${order.quantity}'),
            SizedBox(
              width: 20,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartProvider.increaseQuant(order);
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFFAE526)),
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 10,
                ),
              ),
            ),
          ],
        ));
  }
}
