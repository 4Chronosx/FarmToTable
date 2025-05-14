import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orders_model.dart';
import 'package:farm2you/models/orderset_model.dart';
import 'package:farm2you/utils/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ScrollController _scrollController = ScrollController(); 
  @override
  void dispose() {
    _scrollController.dispose(); // Always dispose the controller
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Orders', style: TextStyle(
          fontFamily: 'Poppins',
        ),),

      ),
      body: ordersProvider.ordersetList.isNotEmpty ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...ordersBuilder(ordersProvider, screenWidth, _scrollController, context)
          ],
          
        ),
      ) : Center(
        child: Text('No orders yet!', style: TextStyle(fontFamily: 'Poppins', fontSize: 16),),
      )
      
    );
  }
}

List<Widget> ordersBuilder(
      OrdersProvider ordersProvider, double screenWidth, ScrollController _scrollController, BuildContext context) {
    return List.generate(ordersProvider.ordersetList.length, (index) {
      final orderSet = ordersProvider.ordersetList[index];
      return Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: ordersItemWidget(screenWidth, orderSet, _scrollController, context));
    });
  }

  Center ordersItemWidget(double screenWidth, OrdersetModel orderSet, ScrollController _scrollController, BuildContext context) {
    final ordersItem = orderSet.storeOrders;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgetHeader(ordersItem),
                  Text(orderSet.status,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(ordersItem.orders.length, (index) {
                    final order = ordersItem.orders[index];
                    return orderDetailsItemWidget(order);
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total ${ordersItem.orders.length} item(s)'),
                  Text(
                    'P ${ordersItem.totalPayment}',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  context.push('/orderdetails', extra: orderSet);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('See details', style: TextStyle(fontFamily: 'Poppins')),
                    Icon(FontAwesomeIcons.caretRight, size: 15,),
                  ],
                ),
              )
            ],
          )),
    );
  }

  FractionallySizedBox orderDetailsItemWidget(OrderModel order) {
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

  Row widgetHeader(CheckoutModel ordersItem) {
    return Row(
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
                  ordersItem.vendorName,
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                )
              ],
            );
  }

