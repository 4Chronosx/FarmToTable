import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orders_model.dart';
import 'package:farm2you/utils/cart_provider.dart';
import 'package:farm2you/utils/checkout_provider.dart';
import 'package:farm2you/utils/navigation_provider.dart';
import 'package:farm2you/utils/orders_provider.dart';
import 'package:sliding_action_button/sliding_action_button.dart';

class CheckoutPage extends StatefulWidget {
  final bool fromBuyNow;
  const CheckoutPage({super.key, required this.fromBuyNow});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ScrollController _scrollController = ScrollController();
  final SlideToActionController _circleSlideToActionController =
      SlideToActionController();
  @override
  void dispose() {
    _scrollController.dispose(); // Always dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(FontAwesomeIcons.arrowLeft),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            custDetails(screenWidth),
            ...checkOutBuilder(
                checkoutProvider, screenWidth, _scrollController),
            paymentMethod(screenWidth, context),
            paymentDetails(screenWidth, checkoutProvider),
            slideButton(_circleSlideToActionController, context, navProvider,
                checkoutProvider, ordersProvider, cartProvider),
          ],
        ),
      ),
    );
  }

  Container paymentMethod(double screenWidth, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Payment method',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  final snackBar = SnackBar(
                    content: Text('Coming soon!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('View all',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.grey)),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 10,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.moneyBill,
                    size: 15,
                    color: Color(0xFFF0D003),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Cash on Delivery',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                ],
              ),
              Icon(
                FontAwesomeIcons.solidCircleCheck,
                color: Color(0xFFF0D003),
                size: 15,
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding slideButton(
      SlideToActionController _circleSlideToActionController,
      BuildContext context,
      NavigationProvider navProvider,
      CheckoutProvider checkoutProvider,
      OrdersProvider ordersProvider,
      CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: CircleSlideToActionButton(
        slideToActionController: _circleSlideToActionController,
        width: 300,
        parentBoxRadiusValue: 27,
        circleSlidingButtonSize: 47,
        leftEdgeSpacing: 3,
        initialSlidingActionLabel: 'Slide right to Place Order',
        finalSlidingActionLabel: 'Placing Order',
        circleSlidingButtonIcon: const Icon(
          Icons.add_shopping_cart,
          color: Color(0xFFF0D003),
        ),
        parentBoxBackgroundColor: Color(0xFFF0D003),
        parentBoxDisableBackgroundColor: Colors.grey,
        circleSlidingButtonBackgroundColor: Colors.white,
        isEnable: true,
        slideActionButtonType:
            SlideActionButtonType.slideActionWithLoaderButton,
        onSlideActionCompleted: () async {
          _circleSlideToActionController.loading();

          await Future.delayed(const Duration(seconds: 3), () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Order placed Successfully!',
              autoCloseDuration: const Duration(seconds: 3),
              showConfirmBtn: false,
            );

            navProvider.changePage(2);
            final List<CheckoutModel> checkoutList =
                List.from(checkoutProvider.checkoutList);
            ordersProvider.initializeList(checkoutList);

            if (!widget.fromBuyNow) {
              cartProvider.getRemove();
              cartProvider.filterOutSelected();
            }

            Future.delayed(Duration(seconds: 3), () {
              context.go('/mainhomescreen');
            });

            _circleSlideToActionController.reset(3);
          });

          print("Sliding action completed");
        },
        onSlideActionCanceled: () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Order failed to place!',
            autoCloseDuration: const Duration(seconds: 3),
            showConfirmBtn: false,
          );
          navProvider.changePage(3);
          print("Sliding action cancelled");
        },
      ),
    );
  }

  Container custDetails(double screenWidth) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20, bottom: 10),
        width: screenWidth * 0.9,
        height: 125,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(FontAwesomeIcons.locationDot,
                  color: Colors.red, size: 20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mary Purhiz Airen L. Dela Raya, +639432438909',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  ),
                  Text(
                    'Lot 3 Blk 33 House, Deca Homes, Brgy. NorthCommunity, Cebu City, Cebu, Philippines, 6000',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Container paymentDetails(
      double screenWidth, CheckoutProvider checkoutProvider) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.all(20),
      width: screenWidth * 0.9,
      height: 225,
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
                'Payment Details',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Items subtotal', style: TextStyle(fontFamily: 'Poppins')),
              Text('${checkoutProvider.getTotalPayment()}',
                  style: TextStyle(fontFamily: 'Poppins'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Delivery fee subtotal',
                  style: TextStyle(fontFamily: 'Poppins')),
              Text('0.0', style: TextStyle(fontFamily: 'Poppins'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Delivery fee discount subtotal',
                  style: TextStyle(fontFamily: 'Poppins')),
              Text('0.0', style: TextStyle(fontFamily: 'Poppins'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Voucher discount', style: TextStyle(fontFamily: 'Poppins')),
              Text('0.0', style: TextStyle(fontFamily: 'Poppins'))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Total payment',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              Text('P ${checkoutProvider.getTotalPayment()}',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }

  List<Widget> checkOutBuilder(CheckoutProvider checkoutProvider,
      double screenWidth, ScrollController _scrollController) {
    return List.generate(checkoutProvider.checkoutList.length, (index) {
      final checkOutItem = checkoutProvider.checkoutList[index];
      return Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child:
              checkOutItemWidget(screenWidth, checkOutItem, _scrollController));
    });
  }

  Center checkOutItemWidget(double screenWidth, CheckoutModel checkoutItem,
      ScrollController _scrollController) {
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
                    checkoutItem.vendorName,
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(checkoutItem.orders.length, (index) {
                    final order = checkoutItem.orders[index];
                    return checkouItemWidget(order);
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total ${checkoutItem.orders.length} item(s)'),
                  Text(
                    'P ${checkoutItem.totalPayment}',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          )),
    );
  }

  FractionallySizedBox checkouItemWidget(OrderModel order) {
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
                      borderRadius: BorderRadius.circular(10)),
                  child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      imageUrl: order.imgPath),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
}
