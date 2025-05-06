import 'package:farm2you/commons.dart';
import 'package:farm2you/models/category_model.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/widgets/product_widget.dart';
import 'package:farm2you/widgets/searchbar.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ProductModel> products = [];

  void _getProducts() {
    products = ProductModel.getProducts(context);
  }

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final screenWidth = MediaQuery.of(context).size.width;
    final List<ProductModel> thisCategoryProducts =
        products.where((item) => item.category == category.name).toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(FontAwesomeIcons.arrowLeft)),
        title: Title(color: Colors.black, child: Text(category.name)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              ReusableSearchBar(width: screenWidth * 0.8),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: thisCategoryProducts.map((item) {
                    return GestureDetector(
                      onTap: item.onTap,
                      child: productWidget(screenWidth, item));
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
