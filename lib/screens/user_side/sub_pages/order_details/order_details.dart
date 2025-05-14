import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:farm2you/utils/checkout_provider.dart';
import 'package:farm2you/utils/orders_provider.dart';

class OrderDetails extends StatefulWidget {
  final OrdersetModel orderSet;
  const OrderDetails({super.key, required this.orderSet});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final orderSet = widget.orderSet;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(99, 99, 99, 0.2),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          2,
                        ),
                      ),
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)

                              )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.orderSet.status,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 253, 228, 65)
                                )
                              ),
                            ),
                          ),
                        ),
                        etaInfo(screenWidth),
                        sellerInfo(screenWidth),
                        customerDetailsAndAddress(screenWidth),
                      ],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: detailItemWidget(screenWidth, orderSet),
              ),
              orderDetails(screenWidth, widget.orderSet)
            ],
          ),
        ));
  }
}

Container etaInfo(double screenWidth) {
  return Container(
    width: screenWidth *0.9,
    padding: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.truckMoving, color: Colors.red, size: 20),
            SizedBox(width: 20,),
            Text(
                  'ETA: May 13 2025 - May 15 2025',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
          ],
        ),
  );
}

Container sellerInfo(double screenWidth) {
  return Container(
    width: screenWidth *0.9,
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.phone, color: Colors.red, size: 20),
            SizedBox(width: 20,),
            Text(
                  '+639611855867 (Seller)',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
          ],
        ),
  );
}

Container customerDetailsAndAddress(double screenWidth) {
  return Container(
    width: screenWidth * 0.9,
    padding: const EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // better alignment for long text
      children: [
        Icon(
          FontAwesomeIcons.locationDot,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(width: 10), // spacing between icon and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mary Purhiz Airen L. Dela Raya, +639432438909',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'Lot 3 Blk 33 House, Deca Homes, Brgy. NorthCommunity, Cebu City, Cebu, Philippines, 6000',
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container orderDetails(double screenWidth,
    OrdersetModel orderSet) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    padding: EdgeInsets.all(20),
    width: screenWidth * 0.9,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(99, 99, 99, 0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(
              0,
              2,
            ),
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Details',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order ID: ${orderSet.orderId}',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.normal),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ordered on: ${orderSet.orderDateTime}',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.normal),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Payment method: ${orderSet.paymentMethod}',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.normal),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order total: P${orderSet.orderTotal}',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    ),
  );
}



Center detailItemWidget(double screenWidth, OrdersetModel orderSet) {
  return Center(
    child: Container(
        width: screenWidth * 0.9,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(99, 99, 99, 0.2),
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(
                  0,
                  2,
                ),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0D003),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Store',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  orderSet.storeOrders.vendorName,
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(orderSet.storeOrders.orders.length, (index) {
                final order = orderSet.storeOrders.orders[index];
                return orderDetailsList(order);
              }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Total ${orderSet.storeOrders.orders.length} item(s)'),
                Text(
                  'P ${orderSet.orderTotal}',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        )),
  );
}

FractionallySizedBox orderDetailsList(order) {
  return FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        padding: EdgeInsets.all(5),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      imageUrl: order.imgPath),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.prodName,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      'in ${order.unit}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'P ${order.price}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text('${order.quantity}x'))),
                            )
                          ],
                        ),
                      ),
                    );
}
