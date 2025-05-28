// ignore_for_file: sized_box_for_whitespace

import 'package:farm2you/utils/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farm2you/commons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  int selectedIndex = 0;
  String? _selectedImagePath;
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _showUploadDialog(
      BuildContext context, ProfileProvider profileProvider, String type) {
    _selectedImagePath = null;
    _imageUrlController.clear();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Upload ${type == 'logo' ? 'Store Logo' : 'Cover Image'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_selectedImagePath != null)
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE7EAE5)),
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(File(_selectedImagePath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _pickImage();
                        setState(() {}); // Update dialog state to show preview
                      },
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Choose from Device'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA9BC8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF91958E),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE7EAE5)),
                      ),
                      child: TextField(
                        controller: _imageUrlController,
                        decoration: const InputDecoration(
                          hintText: 'Enter image URL',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF91958E),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_selectedImagePath == null &&
                        _imageUrlController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please select an image or enter a URL')),
                      );
                      return;
                    }

                    String? uploadedUrl;
                    if (_selectedImagePath != null) {
                      uploadedUrl = await profileProvider.uploadFile(
                          _selectedImagePath!, type);
                    } else if (_imageUrlController.text.isNotEmpty) {
                      uploadedUrl = _imageUrlController.text;
                    }

                    if (uploadedUrl != null) {
                      if (type == 'logo') {
                        profileProvider.storeLogoController.text = uploadedUrl;
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0D003),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FA),
          body: Column(
            children: [
              _buildHeader(context),

              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  physics:
                      const AlwaysScrollableScrollPhysics(), // Ensure it's always scrollable
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Full name field
                        _buildInputField(profileProvider.fullNameController,
                            'Full name', profileProvider),
                        const SizedBox(height: 20),

                        // Business name field
                        _buildInputField(profileProvider.businessNameController,
                            'Business Name', profileProvider),
                        const SizedBox(height: 20),

                        // Email field
                        _buildInputField(profileProvider.emailController,
                            'e-mail', profileProvider),
                        const SizedBox(height: 20),

                        // Phone fields - now placed after email
                        _buildPhoneFields(profileProvider),
                        const SizedBox(height: 20),

                        // Store Logo field with upload button
                        _buildInputFieldWithButton(
                            profileProvider.storeLogoController,
                            'Store Logo',
                            profileProvider),
                        const SizedBox(height: 20),

                        // Location field with location button
                        _buildLocationField(profileProvider),
                        const SizedBox(height: 20),

                        // Categories section
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Categories',
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
                        _buildCategoriesGrid(profileProvider),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              _buildRegisterButton(context, profileProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 20,
                  offset: Offset(0, 4))
            ],
          ),
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

  Widget _buildInputField(TextEditingController controller, String hint,
      ProfileProvider profileProvider) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _inputDecoration,
      child: TextField(
        controller: controller,
        onChanged: (_) => profileProvider.updateValidation(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInputFieldWithButton(TextEditingController controller,
      String hint, ProfileProvider profileProvider) {
    return Container(
      height: 48,
      decoration: _inputDecoration,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                controller: controller,
                onChanged: (_) => profileProvider.updateValidation(),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: _hintStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Upload button
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                String type = hint.contains('Logo') ? 'logo' : 'cover';
                _showUploadDialog(context, profileProvider, type);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA9BC8E),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('UPLOAD'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField(ProfileProvider profileProvider) {
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
                controller: profileProvider.locationController,
                onChanged: (_) => profileProvider.updateValidation(),
                decoration: InputDecoration(
                  hintText: 'Location',
                  hintStyle: _hintStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Location button
          GestureDetector(
            onTap: () {
              context.push('/storelocation');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF91958E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFields(ProfileProvider profileProvider) {
    return Row(
      children: [
        Container(
          width: 68,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: _inputDecoration,
          child: TextField(
            controller: profileProvider.areaCodeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty && !value.startsWith('+')) {
                profileProvider.updateValidation();
              }
            },
            decoration: InputDecoration(
              prefixText: '+',
              hintText: '00',
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
              controller: profileProvider.phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => profileProvider.updateValidation(),
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

  Widget _buildCategoriesGrid(ProfileProvider profileProvider) {
    final items = profileProvider.categories.entries.toList();

    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2) ...[
          if (i < items.length)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSelectionButton(
                    items[i].key, items[i].value, profileProvider),
                if (i + 1 < items.length)
                  _buildSelectionButton(
                      items[i + 1].key, items[i + 1].value, profileProvider)
                else
                  Container(width: 179),
              ],
            ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildSelectionButton(
      String key, String text, ProfileProvider profileProvider) {
    final isSelected = profileProvider.getSelectionState(key);

    return TextButton(
      onPressed: () => profileProvider.toggleSelection(key),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(179, 48),
        backgroundColor:
            isSelected ? const Color(0xFFDDEAD2) : const Color(0xFFECF1E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(width: 1, color: Color(0xFFE7EAE5)),
        ),
      ),
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
    );
  }

  Widget _buildRegisterButton(
      BuildContext context, ProfileProvider profileProvider) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton(
        onPressed: profileProvider.isFormValid && !profileProvider.isLoading
            ? () async {
                bool success = await profileProvider.saveProfile();
                if (success) {
                  context.push('/registeredsplash');
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: profileProvider.isFormValid
              ? const Color(0xFFF0D003)
              : const Color(0xFFFFEE84),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFFFEE84),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.zero,
        ),
        child: profileProvider.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
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
