import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/widgets/product_widget.dart';

class ProductSearchBar extends StatelessWidget {
  final double screenWidth;
  final List<ProductModel> products;

  const ProductSearchBar({
    Key? key,
    required this.screenWidth,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: screenWidth * 0.9,
      child: SearchAnchor(
        viewBackgroundColor: Colors.white,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            elevation: WidgetStateProperty.all(2.0),
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onTap: controller.openView,
            onChanged: (_) => controller.openView(),
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          final String input = controller.value.text;
          final filteredProducts = products
              .where((item) =>
                  item.pname.toLowerCase().contains(input.toLowerCase()))
              .toList();

          return [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${filteredProducts.length} product(s)',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: filteredProducts.map((item) {
                    return GestureDetector(
                      onTap: () {},
                      child: productWidget(screenWidth, item),
                    );
                  }).toList(),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
