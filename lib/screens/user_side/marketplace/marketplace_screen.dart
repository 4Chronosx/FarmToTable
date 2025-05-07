import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/widgets/searchbar.dart';
import '../../../models/category_model.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  void _getCategories() {
    setState(() {
      categories = CategoryModel.getCategories(context);
    });
  }

  void _getProducts() {
    setState(() {
      products = ProductModel.getProducts(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              ReusableSearchBar(width: screenWidth * 0.8),
              SizedBox(
                height: 50,
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Categories',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 20),
              categoriesBuilder(),
              SizedBox(height: 50),
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Recommendations',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 15,
                      )
                    ],
                  )),
              SizedBox(height: 20),
              recommendationsBuilder(),
              SizedBox(height: 50),
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Popular Vendors',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 15,
                      )
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.24),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          3,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.24),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          3,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.24),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          3,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Container recommendationsBuilder() {
    return Container(
      height: 225,
      child: ListView.separated(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(width: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: products[index].onTap,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Color(0xFF77905B) : Color(0xFFFAE526),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 115,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CachedNetworkImage(
                          imageUrl: '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(products[index].name,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                                index % 2 == 0 ? Colors.white : Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(products[index].vendor,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color:
                                index % 2 == 0 ? Colors.white : Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${products[index].price}/${products[index].unit}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color:
                                index % 2 == 0 ? Colors.white : Colors.black))
                  ],
                ),
              ),
            );
          }),
    );
  }

  Container categoriesBuilder() {
    return Container(
        height: 120,
        child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: categories[index].onTap,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: categories[index].boxColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child:
                                SvgPicture.asset(categories[index].iconPath)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        categories[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: categories[index].textColor,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
