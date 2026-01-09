import 'package:farm2you/services/authentication/create_user_profile_service.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _areaCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // User location specific controllers
  final TextEditingController _userAddressController = TextEditingController();
  String _latitude = '';
  String _longitude = '';

  // Location search suggestions
  List<Map<String, dynamic>> _locationSuggestions = [];

  // Loading states
  bool _isLoading = false;
  bool _isUploading = false;

  // Getters for controllers
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get ageController => _ageController;
  TextEditingController get birthdateController => _birthdateController;
  TextEditingController get areaCodeController => _areaCodeController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get profilePictureController =>
      _profilePictureController;
  TextEditingController get locationController => _locationController;
  TextEditingController get userAddressController => _userAddressController;

  // Getters for user location
  String get latitude => _latitude;
  String get longitude => _longitude;
  List<Map<String, dynamic>> get locationSuggestions => _locationSuggestions;

  // Getters for loading states
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  // Field configurations
  final Map<String, String> _inputFields = {
    'fullName': 'Full name',
    'age': 'Age',
    'birthdate': 'Birthdate',
    'email': 'e-mail',
    'profilePicture': 'Profile Picture',
    'location': 'Location',
  };

  // Getters for configurations
  Map<String, String> get inputFields => _inputFields;

  // Form validation
  bool get isFormValid =>
      _fullNameController.text.isNotEmpty &&
      _ageController.text.isNotEmpty &&
      _birthdateController.text.isNotEmpty &&
      _areaCodeController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _areaCodeController.text.length == 2 &&
      _phoneNumberController.text.length == 10;

  // Set user location data
  void setUserLocation({
    required String address,
    required String latitude,
    required String longitude,
  }) {
    _userAddressController.text = address;
    _latitude = latitude;
    _longitude = longitude;
    _locationController.text = address; // Update the main location field
    notifyListeners();
  }

  // Set location suggestions from search
  void setLocationSuggestions(List<dynamic> suggestions) {
    _locationSuggestions = suggestions.cast<Map<String, dynamic>>();
    notifyListeners();
  }

  // Clear location suggestions
  void clearLocationSuggestions() {
    _locationSuggestions.clear();
    notifyListeners();
  }

  // Get controller by field key
  TextEditingController getController(String key) {
    switch (key) {
      case 'fullName':
        return _fullNameController;
      case 'age':
        return _ageController;
      case 'birthdate':
        return _birthdateController;
      case 'email':
        return _emailController;
      case 'profilePicture':
        return _profilePictureController;
      case 'location':
        return _locationController;
      default:
        return TextEditingController();
    }
  }

  // Update field value
  void updateField(String key, String value) {
    getController(key).text = value;
    notifyListeners();
  }

  // Clear all fields
  void clearAllFields() {
    _fullNameController.clear();
    _ageController.clear();
    _birthdateController.clear();
    _areaCodeController.clear();
    _phoneNumberController.clear();
    _emailController.clear();
    _profilePictureController.clear();
    _locationController.clear();
    _userAddressController.clear();
    _latitude = '';
    _longitude = '';
    _locationSuggestions.clear();

    notifyListeners();
  }

  // Load profile data (for editing existing profile)
  void loadProfileData(Map<String, dynamic> profileData) {
    _fullNameController.text = profileData['fullName'] ?? '';
    _ageController.text = profileData['age'] ?? '';
    _birthdateController.text = profileData['birthdate'] ?? '';
    _areaCodeController.text = profileData['areaCode'] ?? '';
    _phoneNumberController.text = profileData['phoneNumber'] ?? '';
    _emailController.text = profileData['email'] ?? '';
    _profilePictureController.text = profileData['profilePicture'] ?? '';
    _locationController.text = profileData['location'] ?? '';
    _userAddressController.text = profileData['userAddress'] ?? '';
    _latitude = profileData['latitude'] ?? '';
    _longitude = profileData['longitude'] ?? '';

    notifyListeners();
  }

  // Get profile data as Map
  Map<String, dynamic> getProfileData() {
    return {
      'fullName': _fullNameController.text,
      'age': _ageController.text,
      'birthdate': _birthdateController.text,
      'areaCode': _areaCodeController.text,
      'phoneNumber': _phoneNumberController.text,
      'phone': '+${_areaCodeController.text}${_phoneNumberController.text}',
      'email': _emailController.text,
      'profilePicture': _profilePictureController.text,
      'location': _locationController.text,
      'userAddress': _userAddressController.text,
      'latitude': _latitude,
      'longitude': _longitude,
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
        _profilePictureController.text = uploadedUrl;
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
  Future<bool> saveUserProfile() async {
    if (!isFormValid) return false;

    setLoading(true);
    try {
      final profileData = getProfileData();
      final service = CreateUserProfileService();

      // Simulate API call for profile save
      await service.submitProfile(profileData);

      

      debugPrint('User profile saved: $profileData');
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
    _ageController.dispose();
    _birthdateController.dispose();
    _areaCodeController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _profilePictureController.dispose();
    _locationController.dispose();
    _userAddressController.dispose();
    super.dispose();
  }
}
