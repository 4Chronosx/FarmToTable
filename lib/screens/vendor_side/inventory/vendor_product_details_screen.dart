import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';
import 'package:farm2you/utils/inventory_provider.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';

class VendorProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const VendorProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<VendorProductDetailsScreen> createState() =>
      _VendorProductDetailsScreenState();
}

class _VendorProductDetailsScreenState
    extends State<VendorProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(FontAwesomeIcons.arrowLeft),
        ),
        actions: [
          IconButton(
            onPressed: () => _editProduct(widget.product),
            icon: Icon(FontAwesomeIcons.penToSquare),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.trash),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Image
                      Container(
                        width: screenWidth,
                        height: 350,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.imgPath,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Product Name
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.product.pname,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Price and Unit
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 8),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${widget.product.price.toStringAsFixed(2)}/${widget.product.unit}',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      // Product ID
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 8),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Product ID: ${widget.product.pid}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF77905B),
                            ),
                          ),
                        ),
                      ),
                      // Stock Information
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 8),
                        width: screenWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'In Stock: ${widget.product.stockQuant}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF0D003),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Product Details Accordion
                      _buildDetailsAccordion(widget.product),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const VendorNavigationBar(selectedIndex: 2),
    );
  }

  Accordion _buildDetailsAccordion(ProductModel product) {
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
                'Category',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFEE8C)),
              ),
              content: Text(
                product.category,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              )),
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
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
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
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              )),
        ]);
  }

  void _editProduct(ProductModel product) {
    // Navigate to edit product screen using go_router
    context.push('/editproduct', extra: product.pid);
  }

  Future<void> _deleteProduct(int productId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Product',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: const Text(
          'Are you sure you want to delete this product? This action cannot be undone.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    /*
    if (confirmed == true) {
      final inventoryProvider = context.read<InventoryProvider>();
      // final success = await inventoryProvider.deleteProduct(productId);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Product deleted successfully',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Color(0xFF77905B),
          ),
        );
        context.pop(); // Return to inventory screen
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to delete product',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.red,
          ),
        );
        
      } 
    } */
  }
}
