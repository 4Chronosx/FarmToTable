import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:farm2you/utils/inventory_provider.dart';
import 'package:farm2you/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  // Selection states
  String selectedUnit = 'Unit';
  String selectedCategory = 'Category';
  bool isDropdownOpen = false;
  bool isCategoryDropdownOpen = false;

  final List<Map<String, String>> unitOptions = [
    {'label': 'kilograms (kg)', 'value': 'kg'},
    {'label': 'grams (g)', 'value': 'g'},
    {'label': 'milligrams (mg)', 'value': 'mg'},
    {'label': 'pounds (lb)', 'value': 'lbs'},
    {'label': 'piece', 'value': 'piece'},
    {'label': 'dozen', 'value': 'dozen'},
  ];

  final List<Map<String, String>> categoryOptions = [
    {'label': 'Fruits', 'value': 'Fruits'},
    {'label': 'Vegetables', 'value': 'Vegetables'},
    {'label': 'Herbs', 'value': 'Herbs'},
    {'label': 'Dairy', 'value': 'Dairy'},
    {'label': 'Meat', 'value': 'Meat'},
    {'label': 'Poultry', 'value': 'Poultry'},
    {'label': 'Eggs', 'value': 'Eggs'},
    {'label': 'Organic Packs', 'value': 'Organic Packs'},
  ];

  // Common styles
  final _inputDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(width: 1, color: const Color(0xFFE7EAE5)),
  );

  final _hintStyle = const TextStyle(
    color: Color(0xFF91958E),
    fontSize: 15,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    height: 1.70,
  );

  bool get isFormValid =>
      _productNameController.text.isNotEmpty &&
      _priceController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty &&
      _sourceController.text.isNotEmpty &&
      _stockController.text.isNotEmpty &&
      selectedUnit != 'Unit' &&
      selectedCategory != 'Category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: Column(
        children: [
          _buildHeader(context),

          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), // Added space from header

                    // Product image placeholder with upload button
                    _buildImageUploadSection(),
                    const SizedBox(height: 24),

                    // Product name field
                    _buildInputField(_productNameController, 'Product Name'),
                    const SizedBox(height: 20),

                    // Category field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildCategoryDropdown(),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Price and Unit fields
                    _buildPriceAndUnitFields(),
                    const SizedBox(height: 20),

                    // Description field
                    _buildInputField(_descriptionController, 'Description'),
                    const SizedBox(height: 20),

                    // Source field
                    _buildInputField(_sourceController, 'Source'),
                    const SizedBox(height: 20),

                    // Stock field
                    _buildInputField(
                        _stockController, 'No. of Stocks Available'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          _buildAddProductButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 20,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Add Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.27,
                    ),
                  ),
                ),
                const SizedBox(width: 32), // Balance the back button
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    return Container(
      width: double.infinity,
      height: 270,
      decoration: ShapeDecoration(
        color: const Color(0xFFF0F0F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          // Placeholder image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://placehold.co/390x270"),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Centered upload button overlay
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle image upload
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF77905B),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'UPLOAD',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: _inputDecoration,
          child: TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Add ${hint.toLowerCase()} here',
              hintStyle: _hintStyle,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isCategoryDropdownOpen = !isCategoryDropdownOpen;
              isDropdownOpen = false; // Close unit dropdown if open
            });
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isCategoryDropdownOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(12),
              border: Border.all(
                width: 1.30,
                color: selectedCategory != 'Category'
                    ? const Color(0xFF215AFF)
                    : const Color(0xFFE7EAE5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory,
                  style: TextStyle(
                    color: selectedCategory == 'Category'
                        ? const Color(0xFF91958E)
                        : const Color(0xFF313043),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
                Icon(
                  isCategoryDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF313043),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isCategoryDropdownOpen)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: categoryOptions.map((category) {
                bool isSelected = selectedCategory == category['value'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category['value']!;
                      isCategoryDropdownOpen = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF215AFF).withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: Text(
                      category['label']!,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF215AFF)
                            : const Color(0xFF313043),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.36,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildPriceAndUnitFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600, // Made bold
            height: 2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: _inputDecoration,
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: '0.0',
                    hintStyle: _hintStyle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Custom Unit dropdown
            Expanded(
              flex: 1,
              child: _buildCustomDropdown(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomDropdown() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
              isCategoryDropdownOpen = false; // Close category dropdown if open
            });
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDropdownOpen
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(12),
              border: Border.all(
                width: 1.30,
                color: selectedUnit != 'Unit'
                    ? const Color(0xFF215AFF)
                    : const Color(0xFFE7EAE5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedUnit,
                  style: TextStyle(
                    color: selectedUnit == 'Unit'
                        ? const Color(0xFF91958E)
                        : const Color(0xFF313043),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.36,
                  ),
                ),
                Icon(
                  isDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF313043),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: unitOptions.map((unit) {
                bool isSelected = selectedUnit == unit['value'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUnit = unit['value']!;
                      isDropdownOpen = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF215AFF).withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: Text(
                      unit['label']!,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF215AFF)
                            : const Color(0xFF313043),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.36,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildAddProductButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton(
        onPressed: isFormValid
            ? () async {
                // Create new product
                final newProduct = ProductModel(
                  id: 0, // Provider will assign ID
                  name: _productNameController.text.trim(),
                  description: _descriptionController.text.trim(),
                  price: double.parse(_priceController.text),
                  unit: selectedUnit,
                  stock: int.parse(_stockController.text),
                  source: _sourceController.text.trim(),
                  category: selectedCategory, // Use selected category
                  vendor: 'Default Vendor',
                  vendorId: 'vendor_1',
                  imgPath: '', // You can add image upload later
                );

                // Save product using provider
                final success = await context
                    .read<InventoryProvider>()
                    .addProduct(newProduct);

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Product added successfully!',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      backgroundColor: Color(0xFF77905B),
                    ),
                  );
                  Navigator.pop(context);
                } else if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Failed to add product. Please try again.',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isFormValid ? const Color(0xFFF0D003) : const Color(0xFFFFEE84),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFFFEE84),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.zero,
        ),
        child: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 1.70,
            letterSpacing: 0.01,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _sourceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
