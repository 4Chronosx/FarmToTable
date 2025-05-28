import 'package:flutter/material.dart';
import 'vendor_provider.dart';

class ProfileProvider extends ChangeNotifier {
  // Add VendorProvider reference
  final VendorProvider _vendorProvider;

  ProfileProvider(this._vendorProvider);

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _areaCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _storeLogoController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Category selection states
  bool _isFruitSelected = false;
  bool _isVegetableSelected = false;
  bool _isHerbsSelected = false;
  bool _isDairySelected = false;
  bool _isMeatSelected = false;
  bool _isPoultrySelected = false;
  bool _isEggsSelected = false;
  bool _isGrainsSelected = false;
  bool _isOrganicPacksSelected = false;

  // Loading states
  bool _isLoading = false;
  bool _isUploading = false;

  // Getters for controllers
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get businessNameController => _businessNameController;
  TextEditingController get areaCodeController => _areaCodeController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get storeLogoController => _storeLogoController;
  TextEditingController get locationController => _locationController;

  // Getters for category selections
  bool get isFruitSelected => _isFruitSelected;
  bool get isVegetableSelected => _isVegetableSelected;
  bool get isHerbsSelected => _isHerbsSelected;
  bool get isDairySelected => _isDairySelected;
  bool get isMeatSelected => _isMeatSelected;
  bool get isPoultrySelected => _isPoultrySelected;
  bool get isEggsSelected => _isEggsSelected;
  bool get isGrainsSelected => _isGrainsSelected;
  bool get isOrganicPacksSelected => _isOrganicPacksSelected;

  // Getters for loading states
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  // Field configurations
  final Map<String, String> _inputFields = {
    'fullName': 'Full name',
    'businessName': 'Business Name',
    'email': 'e-mail',
    'storeLogo': 'Store Logo',
    'location': 'Location',
  };

  // Category configurations
  final Map<String, String> _categories = {
    'fruit': 'FRUITS',
    'vegetable': 'VEGETABLES',
    'herbs': 'HERBS',
    'dairy': 'DAIRY',
    'meat': 'MEAT',
    'poultry': 'POULTRY',
    'eggs': 'EGGS',
    'grains': 'GRAINS',
    'organicPacks': 'ORGANIC PACKS',
  };

  // Getters for configurations
  Map<String, String> get inputFields => _inputFields;
  Map<String, String> get categories => _categories;

  // Form validation
  bool get isFormValid =>
      _fullNameController.text.isNotEmpty &&
      _businessNameController.text.isNotEmpty &&
      _areaCodeController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _areaCodeController.text.length == 2 &&
      _phoneNumberController.text.length == 10;

  // Get controller by field key
  TextEditingController getController(String key) {
    switch (key) {
      case 'fullName':
        return _fullNameController;
      case 'businessName':
        return _businessNameController;
      case 'email':
        return _emailController;
      case 'storeLogo':
        return _storeLogoController;
      case 'location':
        return _locationController;
      default:
        return TextEditingController();
    }
  }

  // Get selection state by category key
  bool getSelectionState(String key) {
    switch (key) {
      case 'fruit':
        return _isFruitSelected;
      case 'vegetable':
        return _isVegetableSelected;
      case 'herbs':
        return _isHerbsSelected;
      case 'dairy':
        return _isDairySelected;
      case 'meat':
        return _isMeatSelected;
      case 'poultry':
        return _isPoultrySelected;
      case 'eggs':
        return _isEggsSelected;
      case 'grains':
        return _isGrainsSelected;
      case 'organicPacks':
        return _isOrganicPacksSelected;
      default:
        return false;
    }
  }

  // Toggle selection state by category key
  void toggleSelection(String key) {
    switch (key) {
      case 'fruit':
        _isFruitSelected = !_isFruitSelected;
        break;
      case 'vegetable':
        _isVegetableSelected = !_isVegetableSelected;
        break;
      case 'herbs':
        _isHerbsSelected = !_isHerbsSelected;
        break;
      case 'dairy':
        _isDairySelected = !_isDairySelected;
        break;
      case 'meat':
        _isMeatSelected = !_isMeatSelected;
        break;
      case 'poultry':
        _isPoultrySelected = !_isPoultrySelected;
        break;
      case 'eggs':
        _isEggsSelected = !_isEggsSelected;
        break;
      case 'grains':
        _isGrainsSelected = !_isGrainsSelected;
        break;
      case 'organicPacks':
        _isOrganicPacksSelected = !_isOrganicPacksSelected;
        break;
    }
    notifyListeners();
  }

  // Get selected categories as a list
  List<String> getSelectedCategories() {
    List<String> selected = [];
    _categories.forEach((key, value) {
      if (getSelectionState(key)) {
        selected.add(value);
      }
    });
    return selected;
  }

  // Get selected category keys
  List<String> getSelectedCategoryKeys() {
    List<String> selected = [];
    _categories.forEach((key, value) {
      if (getSelectionState(key)) {
        selected.add(key);
      }
    });
    return selected;
  }

  // Update field value
  void updateField(String key, String value) {
    getController(key).text = value;
    notifyListeners();
  }

  // Clear all fields
  void clearAllFields() {
    _fullNameController.clear();
    _businessNameController.clear();
    _areaCodeController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    _storeLogoController.clear();
    _locationController.clear();

    // Reset all categories
    _isFruitSelected = false;
    _isVegetableSelected = false;
    _isHerbsSelected = false;
    _isDairySelected = false;
    _isMeatSelected = false;
    _isPoultrySelected = false;
    _isEggsSelected = false;
    _isGrainsSelected = false;
    _isOrganicPacksSelected = false;

    notifyListeners();
  }

  // Load profile data (for editing existing profile)
  void loadProfileData(Map<String, dynamic> profileData) {
    _fullNameController.text = profileData['fullName'] ?? '';
    _businessNameController.text = profileData['businessName'] ?? '';
    _areaCodeController.text = profileData['areaCode'] ?? '';
    _phoneNumberController.text = profileData['phoneNumber'] ?? '';
    _emailController.text = profileData['email'] ?? '';
    _storeLogoController.text = profileData['storeLogo'] ?? '';
    _locationController.text = profileData['location'] ?? '';

    // Load categories
    List<String> selectedCategories =
        List<String>.from(profileData['categories'] ?? []);
    _isFruitSelected = selectedCategories.contains('fruit');
    _isVegetableSelected = selectedCategories.contains('vegetable');
    _isHerbsSelected = selectedCategories.contains('herbs');
    _isDairySelected = selectedCategories.contains('dairy');
    _isMeatSelected = selectedCategories.contains('meat');
    _isPoultrySelected = selectedCategories.contains('poultry');
    _isEggsSelected = selectedCategories.contains('eggs');
    _isGrainsSelected = selectedCategories.contains('grains');
    _isOrganicPacksSelected = selectedCategories.contains('organicPacks');

    notifyListeners();
  }

  // Get profile data as Map
  Map<String, dynamic> getProfileData() {
    return {
      'fullName': _fullNameController.text,
      'businessName': _businessNameController.text,
      'areaCode': _areaCodeController.text,
      'phoneNumber': _phoneNumberController.text,
      'phone': '+${_areaCodeController.text}${_phoneNumberController.text}',
      'email': _emailController.text,
      'storeLogo': _storeLogoController.text,
      'location': _locationController.text,
      'categories': getSelectedCategoryKeys(),
      'categoryLabels': getSelectedCategories(),
    };
  }

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set uploading state
  void setUploading(bool uploading) {
    _isUploading = uploading;
    notifyListeners();
  }

  // Upload file method (placeholder - implement based on your file upload logic)
  Future<String?> uploadFile(String filePath, String type) async {
    setUploading(true);
    try {
      // Implement your file upload logic here
      // This is a placeholder implementation
      await Future.delayed(const Duration(seconds: 2)); // Simulate upload

      // Return the uploaded file URL or path
      String uploadedUrl =
          'https://example.com/uploads/$type/${DateTime.now().millisecondsSinceEpoch}';

      // Update the appropriate controller
      if (type == 'logo') {
        _storeLogoController.text = uploadedUrl;
      }

      return uploadedUrl;
    } catch (e) {
      // Handle upload error
      debugPrint('Upload error: $e');
      return null;
    } finally {
      setUploading(false);
    }
  }

  // Save profile method
  Future<bool> saveProfile() async {
    if (!isFormValid) return false;

    setLoading(true);
    try {
      final profileData = getProfileData();

      // Create vendor profile with generated ID
      _vendorProvider.setVendorFromProfile(profileData);

      // Simulate API call for profile save
      await Future.delayed(const Duration(seconds: 2));

      debugPrint('Profile saved: $profileData');
      debugPrint('Vendor ID generated: ${_vendorProvider.currentVendorId}');
      return true;
    } catch (e) {
      debugPrint('Save error: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Trigger form validation update
  void updateValidation() {
    notifyListeners();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _areaCodeController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _storeLogoController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
