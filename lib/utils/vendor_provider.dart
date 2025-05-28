import 'package:flutter/material.dart';

class VendorProvider extends ChangeNotifier {
  // Start with no vendor logged in
  String _currentVendorId = "";
  String _currentVendorName = "";
  String _currentVendorEmail = "";
  String _currentVendorPhone = "";
  String _currentVendorLocation = "";
  List<String> _currentVendorCategories = [];
  bool _isLoggedIn = false;

  // Existing vendors from product data
  static final Map<String, Map<String, dynamic>> _existingVendors = {
    "mango_farm_123": {
      "name": "The Mango Farm",
      "category": "Fruits",
      "email": "contact@mangofarm.com",
      "phone": "+63912345678",
    },
    "dragon_farm_456": {
      "name": "The DragonFruit Farm",
      "category": "Fruits",
      "email": "info@dragonfarm.com",
      "phone": "+63923456789",
    },
    "veg_farm_789": {
      "name": "The Vegetable Farm",
      "category": "Vegetables",
      "email": "orders@vegfarm.com",
      "phone": "+63934567890",
    },
    "meat_farm_012": {
      "name": "The Meat Farm",
      "category": "Meat",
      "email": "sales@meatfarm.com",
      "phone": "+63945678901",
    },
    "poultry_farm_345": {
      "name": "The Poultry Farm",
      "category": "Poultry",
      "email": "hello@poultryfarm.com",
      "phone": "+63956789012",
    },
    "banana_plant_678": {
      "name": "The Banana Plantation",
      "category": "Fruits",
      "email": "contact@bananaplant.com",
      "phone": "+63967890123",
    },
    "tomato_patch_901": {
      "name": "The Tomato Patch",
      "category": "Vegetables",
      "email": "info@tomatopatch.com",
      "phone": "+63978901234",
    },
    "herb_garden_234": {
      "name": "The Herb Garden",
      "category": "Herbs",
      "email": "orders@herbgarden.com",
      "phone": "+63989012345",
    },
    "grain_mill_567": {
      "name": "The Grain Mill",
      "category": "Grains",
      "email": "sales@grainmill.com",
      "phone": "+63990123456",
    },
    "dairy_farm_890": {
      "name": "The Dairy Farm",
      "category": "Dairy",
      "email": "hello@dairyfarm.com",
      "phone": "+63901234567",
    },
    "egg_farm_112": {
      "name": "The Egg Farm",
      "category": "Eggs",
      "email": "contact@eggfarm.com",
      "phone": "+63912345670",
    },
    "organic_farm_445": {
      "name": "The Organic Farm",
      "category": "Organic Packs",
      "email": "info@organicfarm.com",
      "phone": "+63923456701",
    },
    "pine_plant_778": {
      "name": "The Pineapple Plantation",
      "category": "Fruits",
      "email": "orders@pineappleplant.com",
      "phone": "+63934567012",
    },
    "pepper_farm_009": {
      "name": "The Pepper Farm",
      "category": "Vegetables",
      "email": "sales@pepperfarm.com",
      "phone": "+63945670123",
    },
  };

  // Getters
  String get currentVendorId => _currentVendorId;
  String get currentVendorName => _currentVendorName;
  String get currentVendorEmail => _currentVendorEmail;
  String get currentVendorPhone => _currentVendorPhone;
  String get currentVendorLocation => _currentVendorLocation;
  List<String> get currentVendorCategories =>
      List.unmodifiable(_currentVendorCategories);
  bool get isVendorLoggedIn => _isLoggedIn;

  // Login existing vendor by vendor ID
  void loginExistingVendor(String vendorId) {
    if (_existingVendors.containsKey(vendorId)) {
      final vendorData = _existingVendors[vendorId]!;
      _currentVendorId = vendorId;
      _currentVendorName = vendorData['name'] ?? vendorData['businessName'];
      _currentVendorEmail = vendorData['email'] ?? '';
      _currentVendorPhone = vendorData['phone'] ?? '';
      _currentVendorLocation = vendorData['location'] ?? '';
      _currentVendorCategories = List<String>.from(
          vendorData['categories'] ?? [vendorData['category'] ?? []]);
      _isLoggedIn = true;

      debugPrint(
          'Existing vendor logged in: $vendorId - ${vendorData['name'] ?? vendorData['businessName']}');
      notifyListeners();
    } else {
      debugPrint('Vendor ID $vendorId not found in existing vendors');
    }
  }

  // Login existing vendor by business name
  void loginExistingVendorByName(String businessName) {
    String? foundVendorId;

    _existingVendors.forEach((vendorId, vendorData) {
      if (vendorData['name'].toString().toLowerCase() ==
          businessName.toLowerCase()) {
        foundVendorId = vendorId;
      }
    });

    if (foundVendorId != null) {
      loginExistingVendor(foundVendorId!);
    } else {
      debugPrint('Existing vendor with name "$businessName" not found');
    }
  }

  // Check if vendor ID exists in existing vendors
  bool isExistingVendor(String vendorId) {
    return _existingVendors.containsKey(vendorId);
  }

  // Check if business name matches existing vendor
  bool isExistingVendorName(String businessName) {
    return _existingVendors.values.any((vendorData) =>
        vendorData['name'].toString().toLowerCase() ==
        businessName.toLowerCase());
  }

  // Get all existing vendor options (for selection screen if needed)
  List<Map<String, String>> getAllExistingVendors() {
    return _existingVendors.entries
        .map((entry) => {
              'vendorId': entry.key,
              'name': entry.value['name'].toString(),
              'category': entry.value['category'].toString(),
            })
        .toList();
  }

  // Smart login - checks if existing vendor first, then creates new
  void smartLogin(String businessName, {Map<String, dynamic>? profileData}) {
    // First check if this matches an existing vendor
    if (isExistingVendorName(businessName)) {
      loginExistingVendorByName(businessName);
    } else {
      // Create new vendor profile
      if (profileData != null) {
        setVendorFromProfile(profileData);
      } else {
        // Create minimal profile for new vendor
        setVendorFromProfile({'businessName': businessName});
      }
    }
  }

  // Set vendor from profile data - handles both existing and new vendors
  void setVendorFromProfile(Map<String, dynamic> profileData) {
    String businessName = profileData['businessName'] ?? '';

    if (businessName.isEmpty) {
      debugPrint(
          'Warning: Business name is empty, cannot create vendor profile');
      return;
    }

    // Check if this matches an existing vendor first
    if (isExistingVendorName(businessName)) {
      debugPrint('Found existing vendor: $businessName');
      loginExistingVendorByName(businessName);
      return;
    }

    // Generate new vendorId for new vendor
    String vendorId = _generateVendorId(businessName);

    // Store the new vendor in _existingVendors
    _existingVendors[vendorId] = {
      'businessName': businessName,
      'name': businessName,
      'email': profileData['email'] ?? '',
      'phone': profileData['phone'] ?? '',
      'location': profileData['location'] ?? '',
      'categories': profileData['categories'] ?? [],
    };

    // Set current vendor data
    _currentVendorId = vendorId;
    _currentVendorName = businessName;
    _currentVendorEmail = profileData['email'] ?? '';
    _currentVendorPhone = profileData['phone'] ?? '';
    _currentVendorLocation = profileData['location'] ?? '';
    _currentVendorCategories =
        List<String>.from(profileData['categories'] ?? []);
    _isLoggedIn = true;

    debugPrint('New vendor profile created: $vendorId - $businessName');
    notifyListeners();
  }

  // Generate vendor ID from business name
  String _generateVendorId(String businessName) {
    if (businessName.isEmpty) return '';

    // Convert to lowercase, remove spaces and special characters
    String cleanName = businessName
        .toLowerCase()
        .trim()
        .replaceAll(
            RegExp(r'[^a-z0-9\s]'), '') // Remove special chars except spaces
        .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscores
        .replaceAll(
            RegExp(r'_+'), '_') // Replace multiple underscores with single
        .replaceAll(
            RegExp(r'^_|_$'), ''); // Remove leading/trailing underscores

    // Limit length to avoid very long IDs
    if (cleanName.length > 20) {
      cleanName = cleanName.substring(0, 20);
    }

    // Add timestamp to make it unique (last 6 digits)
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String shortTimestamp = timestamp.substring(timestamp.length - 6);

    return '${cleanName}_$shortTimestamp';
  }

  // Update vendor profile info (for profile editing)
  void updateVendorProfile(Map<String, dynamic> profileData) {
    if (!_isLoggedIn) return;

    // Update all fields except vendorId (that stays the same)
    _currentVendorName = profileData['businessName'] ?? _currentVendorName;
    _currentVendorEmail = profileData['email'] ?? _currentVendorEmail;
    _currentVendorPhone = profileData['phone'] ?? _currentVendorPhone;
    _currentVendorLocation = profileData['location'] ?? _currentVendorLocation;
    _currentVendorCategories = List<String>.from(
        profileData['categories'] ?? _currentVendorCategories);

    debugPrint(
        'Vendor profile updated: $_currentVendorId - $_currentVendorName');
    notifyListeners();
  }

  // Get complete vendor profile data
  Map<String, dynamic> getVendorProfileData() {
    return {
      'vendorId': _currentVendorId,
      'businessName': _currentVendorName,
      'email': _currentVendorEmail,
      'phone': _currentVendorPhone,
      'location': _currentVendorLocation,
      'categories': _currentVendorCategories,
      'isLoggedIn': _isLoggedIn,
    };
  }

  // Check if vendor has specific category
  bool hasCategory(String category) {
    return _currentVendorCategories.contains(category);
  }

  // Add category to vendor
  void addCategory(String category) {
    if (!_currentVendorCategories.contains(category)) {
      _currentVendorCategories.add(category);
      notifyListeners();
    }
  }

  // Remove category from vendor
  void removeCategory(String category) {
    if (_currentVendorCategories.contains(category)) {
      _currentVendorCategories.remove(category);
      notifyListeners();
    }
  }

  // Logout vendor
  void logoutVendor() {
    _currentVendorId = "";
    _currentVendorName = "";
    _currentVendorEmail = "";
    _currentVendorPhone = "";
    _currentVendorLocation = "";
    _currentVendorCategories.clear();
    _isLoggedIn = false;

    debugPrint('Vendor logged out');
    notifyListeners();
  }

  // Check if current vendor owns a specific product/order
  bool ownsVendorId(String vendorId) {
    return _isLoggedIn && _currentVendorId == vendorId;
  }

  // Validate vendor session
  bool get hasValidSession {
    return _isLoggedIn &&
        _currentVendorId.isNotEmpty &&
        _currentVendorName.isNotEmpty;
  }

  // Get vendor display info (for UI)
  String get vendorDisplayName {
    if (!_isLoggedIn || _currentVendorName.isEmpty) {
      return 'Guest Vendor';
    }
    return _currentVendorName;
  }

  // Get short vendor ID (for display purposes)
  String get shortVendorId {
    if (_currentVendorId.isEmpty) return '';
    return _currentVendorId.length > 15
        ? '${_currentVendorId.substring(0, 12)}...'
        : _currentVendorId;
  }

  // Debug method to print current vendor state
  void debugPrintVendorState() {
    debugPrint('=== Vendor State ===');
    debugPrint('Logged In: $_isLoggedIn');
    debugPrint('Vendor ID: $_currentVendorId');
    debugPrint('Business Name: $_currentVendorName');
    debugPrint('Email: $_currentVendorEmail');
    debugPrint('Phone: $_currentVendorPhone');
    debugPrint('Location: $_currentVendorLocation');
    debugPrint('Categories: $_currentVendorCategories');
    debugPrint('==================');
  }

  // Find vendor by email
  Map<String, dynamic>? findVendorByEmail(String email) {
    String? foundVendorId;

    // Check all vendors (both existing and newly registered)
    _existingVendors.forEach((vendorId, vendorData) {
      String vendorEmail = vendorData['email']?.toString().toLowerCase() ?? '';
      if (vendorEmail == email.toLowerCase()) {
        foundVendorId = vendorId;
      }
    });

    if (foundVendorId != null) {
      return {'vendorId': foundVendorId!, ..._existingVendors[foundVendorId!]!};
    }

    return null;
  }
}
