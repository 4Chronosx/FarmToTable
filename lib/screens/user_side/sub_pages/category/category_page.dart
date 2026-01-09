import 'package:farm2you/commons.dart';
import 'package:farm2you/models/category_model.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/services/authentication/inventory_service.dart';
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
  final productService = ProductService();

  Future<void> _getProducts() async {
  final fetchedProducts = await productService.getProductsByCategory(widget.category.name);
  print("printing list");
  print(fetchedProducts);
  setState(() {
    products = fetchedProducts;
    //_isLoading = false;
  });
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
        products;
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
              ProductSearchBar(screenWidth: screenWidth, products: thisCategoryProducts),
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
                      onTap: () {
                        context.push('/product_details', extra: item);
                      },
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
