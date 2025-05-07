import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    height: 350,
                    child: CachedNetworkImage(
                      imageUrl: '',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: screenWidth,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.name,
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
                  Accordion(
                      headerBorderColor: Colors.transparent,
                      headerBorderWidth: 1,
                      headerBackgroundColorOpened: Color(0xFF77905B),
                      headerBackgroundColor: Color(0xFF77905B),
                      contentBackgroundColor: Color(0xFFFAE526),
                      contentBorderColor: Colors.transparent,
                      contentVerticalPadding: 10,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
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
                              product.description,
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
                              product.vendor,
                              textAlign: TextAlign.justify,
                            )),
                      ]),
                ],
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFF0D003)),
                      iconColor: WidgetStatePropertyAll(Colors.black),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                      fixedSize:
                          WidgetStatePropertyAll(Size(screenWidth * 0.5, 70))),
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
                      Icon(FontAwesomeIcons.cartShopping)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter setModalState) {
                            void increaseQuant() {
                              if (quantity >= 100) {
                                return;
                              }
                              setModalState(() {
                                quantity++;
                              });
                            }

                            void decreaseQuant() {
                              if (quantity <= 0) {
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
                                        child: Text('Item: ${product.name}'),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth,
                                      height: 30,
                                      padding: EdgeInsets.only(left: 20),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'price: ${product.price}/${product.unit}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Quantity'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: decreaseQuant,
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      WidgetStatePropertyAll(
                                                          Size(20, 20)),
                                                  padding:
                                                      WidgetStatePropertyAll(
                                                          EdgeInsets.zero),
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
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
                                                  minimumSize:
                                                      WidgetStatePropertyAll(
                                                          Size(20, 20)),
                                                  padding:
                                                      WidgetStatePropertyAll(
                                                          EdgeInsets.zero),
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  FontAwesomeIcons.plus,
                                                  size: 10,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                    setState(() {
                      quantity = 0;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFF394E2C)),
                      iconColor: WidgetStatePropertyAll(Colors.white),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                      fixedSize:
                          WidgetStatePropertyAll(Size(screenWidth * 0.5, 70))),
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
                ),
              ]),
        )
      ]),
    );
  }
}
