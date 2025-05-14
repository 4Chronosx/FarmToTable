// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:farm2you/commons.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _areaCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _storeLogoController = TextEditingController();
  final TextEditingController _storeCoverController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Selection states
  bool isFruitSelected = false;
  bool isVegetableSelected = false;
  bool isHerbsSelected = false;
  bool isDairySelected = false;
  bool isMeatSelected = false;
  bool isPoultrySelected = false;
  bool isEggsSelected = false;
  int selectedIndex = 0;

  // Field configurations - reordered to match desired order
  final _inputFields = <String, String>{
    'fullName': 'Full name',
    'businessName': 'Business Name',
    'email': 'e-mail',
    // Phone fields will be inserted separately in the build method
    'storeLogo': 'Store Logo',
    'storeCover': 'Store Cover',
    'address': 'Address',
  };

  // Category configurations
  final _categories = <String, String>{
    'fruit': 'FRUITS',
    'vegetable': 'VEGETABLES',
    'herbs': 'HERBS',
    'dairy': 'DAIRY',
    'meat': 'MEAT',
    'poultry': 'POULTRY',
    'eggs': 'EGGS',
  };

  // Get controller by field key
  TextEditingController _getController(String key) {
    switch (key) {
      case 'fullName': return _fullNameController;
      case 'businessName': return _businessNameController;
      case 'email': return _emailController;
      case 'storeLogo': return _storeLogoController;
      case 'storeCover': return _storeCoverController;
      case 'address': return _addressController;
      default: return TextEditingController();
    }
  }

  // Get selection state by category key
  bool _getSelectionState(String key) {
    switch (key) {
      case 'fruit': return isFruitSelected;
      case 'vegetable': return isVegetableSelected;
      case 'herbs': return isHerbsSelected;
      case 'dairy': return isDairySelected;
      case 'meat': return isMeatSelected;
      case 'poultry': return isPoultrySelected;
      case 'eggs': return isEggsSelected;
      default: return false;
    }
  }

  // Toggle selection state by category key
  void _toggleSelection(String key) {
    setState(() {
      switch (key) {
        case 'fruit': isFruitSelected = !isFruitSelected; break;
        case 'vegetable': isVegetableSelected = !isVegetableSelected; break;
        case 'herbs': isHerbsSelected = !isHerbsSelected; break;
        case 'dairy': isDairySelected = !isDairySelected; break;
        case 'meat': isMeatSelected = !isMeatSelected; break;
        case 'poultry': isPoultrySelected = !isPoultrySelected; break;
        case 'eggs': isEggsSelected = !isEggsSelected; break;
      }
    });
  }

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

  bool get isFormValid => _fullNameController.text.isNotEmpty &&
      _businessNameController.text.isNotEmpty &&
      _areaCodeController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: Column(
        children: [
          // Header
          _buildHeader(),

          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Ensure it's always scrollable
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full name field
                    _buildInputField(_fullNameController, 'Full name'),
                    const SizedBox(height: 20),

                    // Business name field
                    _buildInputField(_businessNameController, 'Business Name'),
                    const SizedBox(height: 20),

                    // Email field
                    _buildInputField(_emailController, 'e-mail'),
                    const SizedBox(height: 20),

                    // Phone fields - now placed after email
                    _buildPhoneFields(),
                    const SizedBox(height: 20),

                    // Store Logo field with upload button
                    _buildInputFieldWithButton(_storeLogoController, 'Store Logo'),
                    const SizedBox(height: 20),

                    // Store Cover field with upload button
                    _buildInputFieldWithButton(_storeCoverController, 'Store Cover Page'),
                    const SizedBox(height: 20),

                    // Address field
                    _buildInputField(_addressController, 'Address'),
                    const SizedBox(height: 20),

                    // Type of Goods section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Type of Goods',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.71,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category selection grid
                    _buildCategoriesGrid(),
                    const SizedBox(height: 40), // Added extra padding at the bottom
                  ],
                ),
              ),
            ),
          ),

          // Register Button - now outside the scroll view so it's always visible
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0x0C000000), blurRadius: 20, offset: Offset(0, 4))],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Colors.white),
                child: const Center(child: Icon(Icons.arrow_back)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Create your profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF363A33),
            fontSize: 32,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.64,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _inputDecoration,
      child: TextField(
        controller: controller,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInputFieldWithButton(TextEditingController controller, String hint) {
    return Container(
      height: 48,
      decoration: _inputDecoration,
      child: Row(
        children: [
          // Text field
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                controller: controller,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: _hintStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Upload button
          GestureDetector(
            onTap: () {
              // Handle upload action
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFA9BC8E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'UPLOAD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFields() {
    return Row(
      children: [
        Container(
          width: 68,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: _inputDecoration,
          child: TextField(
            controller: _areaCodeController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '+00',
              hintStyle: _hintStyle,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: _inputDecoration,
            child: TextField(
              controller: _phoneNumberController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: _hintStyle,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    final items = _categories.entries.toList();

    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2) ...[
          if (i < items.length)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectionButton(
                    items[i].key,
                    items[i].value
                ),
                if (i + 1 < items.length)
                  _buildSelectionButton(
                      items[i + 1].key,
                      items[i + 1].value
                  )
                else
                  Container(width: 179), // Empty container for alignment
              ],
            ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildSelectionButton(String key, String text) {
    final isSelected = _getSelectionState(key);

    return GestureDetector(
      onTap: () => _toggleSelection(key),
      child: Container(
        width: 179,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDDEAD2) : const Color(0xFFECF1E8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: const Color(0xFFE7EAE5)),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF394E2C) : const Color(0xFF91958E),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              height: 1.70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        if (isFormValid) {
          // Action: navigate or submit
        }
      },
      child: Container(
        width: double.infinity,
        height: 90,
        alignment: Alignment.center,
        color: isFormValid ? const Color(0xFFF0D003) : const Color(0xFFFFEE84),
        child: const Text(
          'Register as Farmer',
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
}