import 'package:farm2you/commons.dart';
import 'package:farm2you/models/recommended_model.dart';
import 'package:farm2you/widgets/searchbar.dart';
import '../../../models/category_model.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<CategoryModel> categories = [];
  List<RecommendedModel> recommendations = [];

  void _getCategories() {
    setState(() {
      categories = CategoryModel.getCategories();
    });
  }

  void _getRecommendations() {
    setState(() {
      recommendations = RecommendedModel.getRecommendations();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
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
      ),
    );
  }

  Container recommendationsBuilder() {
    return Container(
      height: 225,
      child: ListView.separated(
          itemCount: recommendations.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => SizedBox(width: 20),
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              decoration: BoxDecoration(
                  color: recommendations[index].bgColor,
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
                      child: Image.asset(recommendations[index].imagePath),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(recommendations[index].name,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: recommendations[index].textColor)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(recommendations[index].vendor,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: recommendations[index].textColor)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(recommendations[index].price,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: recommendations[index].textColor))
                ],
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
              return Container(
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
                          child: SvgPicture.asset(categories[index].iconPath)),
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
              );
            }));
  }
}
