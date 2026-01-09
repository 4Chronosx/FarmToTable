import 'package:farm2you/commons.dart';
import 'package:farm2you/models/checkout_model.dart';
import 'package:farm2you/models/orders_model.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/services/authentication/inventory_service.dart';
import 'package:farm2you/utils/cart_provider.dart';
import 'package:farm2you/utils/checkout_provider.dart';
import 'package:farm2you/utils/navigation_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final product = widget.product;

    final cartOrdersProvider =
        Provider.of<CartProvider>(context, listen: false);

    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    final navProvider = Provider.of<NavigationProvider>(context);
    final productService = ProductService();
    final SupabaseClient supabase = Supabase.instance.client;
    final userID = supabase.auth.currentUser!.id;

    void addToCart(int cartOrderQuant) async {
      final cartID = await productService.fetchCartID(userID);
      if (cartOrderQuant <= 0) return;

      if (cartID == null) {
        // Handle null cartID properly (e.g. show error, create cart, etc)
        print('Cart ID not found for user');
        return;
      }

      await productService.addToCart(
          cartID: cartID,
          productID: product.pid,
          quantity: cartOrderQuant,
          isSelected: true);
      /*
      final newCartOrder = OrderModel(
          prodName: product.pname,
          vendorName: '${product.storeID}',
          price: product.price,
          unit: product.unit,
          quantity: cartOrderQuant,
          prodId: product.pid,
          vendorId: 0,
          imgPath: product.imgPath,
          selectedInCart: true); */

      //cartOrdersProvider.addOrder(newCartOrder);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(FontAwesomeIcons.arrowLeft)),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: screenWidth,
                            height: 350,
                            child: CachedNetworkImage(
                              imageUrl: product.imgPath,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              right: 20,
                              top: 10,
                              child: GestureDetector(
                                onTap: () {
                                  navProvider.changePage(3);
                                  context.go('/mainhomescreen');
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF0D003),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Icon(
                                      FontAwesomeIcons.cartShopping,
                                      color: Color(0xFFFFFFFF),
                                      size: 20,
                                    ))),
                              ))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.pname,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${product.price}/${product.unit}',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      detailsAccordion(product),
                    ],
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addToCartButton(context, screenWidth, product, addToCart),
                  buyNowButton(context, screenWidth, product,
                      cartOrdersProvider, checkoutProvider),
                ]),
          )
        ]),
      ),
    );
  }

  Accordion detailsAccordion(ProductModel product) {
    return Accordion(
        headerBorderColor: Colors.transparent,
        headerBorderWidth: 1,
        headerBackgroundColorOpened: Color(0xFF77905B),
        headerBackgroundColor: Color(0xFF77905B),
        contentBackgroundColor: Color(0xFFFAE526),
        contentBorderColor: Colors.transparent,
        contentVerticalPadding: 10,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        rightIcon: Icon(FontAwesomeIcons.caretDown, size: 20),
        children: [
          AccordionSection(
              isOpen: false,
              contentVerticalPadding: 20,
              header: Text(
                'Description',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFEE8C)),
              ),
              content: Text(
                product.details,
                textAlign: TextAlign.justify,
              )),
          AccordionSection(
              isOpen: false,
              contentVerticalPadding: 20,
              header: Text(
                'Source',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFEE8C)),
              ),
              content: Text(
                product.source,
                textAlign: TextAlign.justify,
              )),
          AccordionSection(
              isOpen: false,
              contentVerticalPadding: 20,
              header: Text(
                'Abour Vendor',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFEE8C)),
              ),
              content: Text(
                '${product.storeID}',
                textAlign: TextAlign.justify,
              )),
        ]);
  }

  ElevatedButton addToCartButton(BuildContext context, double screenWidth,
      ProductModel product, void Function(int orderQuant) addToCart) {
    return ElevatedButton(
      onPressed: () {
        bottomSheet(context, screenWidth, product, () {
          addToCart(quantity);
          context.pop();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Added to Cart Successfully!',
            autoCloseDuration: const Duration(seconds: 3),
            showConfirmBtn: false,
          );
        }, 'Add to cart');
        setState(() {
          quantity = 1;
        });
      },
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFFF0D003)),
          iconColor: WidgetStatePropertyAll(Colors.black),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          fixedSize: WidgetStatePropertyAll(Size(screenWidth * 0.5, 70))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add to cart  ',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          Icon(FontAwesomeIcons.cartPlus)
        ],
      ),
    );
  }

  ElevatedButton buyNowButton(
      BuildContext context,
      double screenWidth,
      ProductModel product,
      CartProvider cartProvider,
      CheckoutProvider checkoutProvider) {
    return ElevatedButton(
      onPressed: () {
        bottomSheet(context, screenWidth, product, () {
          final buyNowOrder = OrderModel(
              prodName: product.pname,
              vendorName: '${product.storeID}',
              price: product.price,
              unit: product.unit,
              quantity: quantity,
              prodId: product.pid,
              vendorId: 0,
              imgPath: product.imgPath,
              selectedInCart: true);

          final newCheckoutItem = CheckoutModel(
              vendorName: buyNowOrder.vendorName,
              vendorId: buyNowOrder.vendorId,
              orders: [buyNowOrder],
              totalPayment: buyNowOrder.price * buyNowOrder.quantity);

          checkoutProvider.addToCheckOutList(newCheckoutItem);
          context.pop();
          Future.delayed(const Duration(seconds: 1), () {
            context.push('/checkout', extra: true);
          });
        }, 'Buy Now');
        setState(() {
          quantity = 1;
        });
      },
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF394E2C)),
          iconColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          fixedSize: WidgetStatePropertyAll(Size(screenWidth * 0.5, 70))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Buy now  ',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Icon(FontAwesomeIcons.moneyBillTransfer)
        ],
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context, double screenWidth,
      ProductModel product, void Function() onTap, String buttonName) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            void increaseQuant() {
              if (quantity >= 100) {
                return;
              }
              setModalState(() {
                quantity++;
              });
            }

            void decreaseQuant() {
              if (quantity <= 1) {
                return;
              }
              setModalState(() {
                quantity--;
              });
            }

            return SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: screenWidth,
                      height: 30,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Item: ${product.pname}'),
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: 30,
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('price: ${product.price}/${product.unit}'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Quantity'),
                          quantityAdderSubtractorBtn(
                              decreaseQuant, increaseQuant)
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xFFF0D003)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                          minimumSize: WidgetStatePropertyAll(
                              Size(screenWidth * 0.75, 30))),
                      child: Text(buttonName,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black)),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Row quantityAdderSubtractorBtn(void decreaseQuant(), void increaseQuant()) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: decreaseQuant,
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(20, 20)),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          child: Icon(
            FontAwesomeIcons.minus,
            size: 10,
          ),
        ),
        Text('$quantity'),
        ElevatedButton(
          onPressed: increaseQuant,
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(20, 20)),
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
      ],
    );
  }
}
