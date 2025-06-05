// ignore_for_file: sized_box_for_whitespace


import 'package:farm2you/utils/user_profile_provider.dart';

import 'package:flutter/services.dart';
import 'package:farm2you/commons.dart';
import 'package:image_picker/image_picker.dart';

import 'package:latlong2/latlong.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class UserCreateProfileScreen extends StatefulWidget {
  const UserCreateProfileScreen({super.key});

  @override
  State<UserCreateProfileScreen> createState() =>
      _UserCreateProfileScreenState();
}

class _UserCreateProfileScreenState extends State<UserCreateProfileScreen> {
  int selectedIndex = 0;
  String? _selectedImagePath;
  final TextEditingController _imageUrlController = TextEditingController();
  Timer? _searchTimer;

  @override
  void dispose() {
    _imageUrlController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  // Search for locations using Nominatim API
  Future<void> _onLocationSearch(
      String query, UserProfileProvider userProfileProvider) async {
    if (query.isEmpty) {
      userProfileProvider.clearLocationSuggestions();
      return;
    }

    // Cancel previous timer
    _searchTimer?.cancel();

    // Debounce search - wait 500ms after user stops typing
    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        print('Searching for: $query'); // Debug print
        final encodedQuery = Uri.encodeComponent(query);
        final url =
            'https://nominatim.openstreetmap.org/search?format=json&q=$encodedQuery&limit=5&countrycodes=ph&addressdetails=1';
        print('Request URL: $url'); // Debug print

        final response = await http.get(
          Uri.parse(url),
          headers: {
            'User-Agent': 'Farm2You/1.0 (Flutter App)', // Add user agent
          },
        );

        print('Response status: ${response.statusCode}'); // Debug print
        print('Response body: ${response.body}'); // Debug print

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          print('Found ${data.length} results'); // Debug print
          userProfileProvider.setLocationSuggestions(data);
        } else {
          print('Error: HTTP ${response.statusCode}');
          userProfileProvider.clearLocationSuggestions();
        }
      } catch (e) {
        print('Search error: $e'); // Debug print
        userProfileProvider.clearLocationSuggestions();
      }
    });
  }

  // Handle selection of a location suggestion
  void _selectLocationSuggestion(Map<String, dynamic> suggestion,
      UserProfileProvider userProfileProvider) {
    final displayName = suggestion['display_name'] ?? '';
    final lat = suggestion['lat'] ?? '';
    final lon = suggestion['lon'] ?? '';

    userProfileProvider.setUserLocation(
      address: displayName,
      latitude: lat,
      longitude: lon,
    );

    // Clear suggestions after selection
    userProfileProvider.clearLocationSuggestions();
  }

  // Reverse geocode to get address from coordinates
  Future<void> _reverseGeocode(
      LatLng point, TextEditingController addressController) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${point.latitude}&lon=${point.longitude}&addressdetails=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final displayName = data['display_name'] ?? '';
        if (displayName.isNotEmpty) {
          addressController.text = displayName;
        }
      }
    } catch (e) {
      debugPrint('Reverse geocoding error: $e');
    }
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

  Future<void> _showUploadDialog(BuildContext context,
      UserProfileProvider userProfileProvider, String type) {
    _selectedImagePath = null;
    _imageUrlController.clear();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Upload ${type == 'profile picture' ? 'Profile Picture' : 'Cover Image'}',
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
                      uploadedUrl = await userProfileProvider.uploadFile(
                          _selectedImagePath!, type);
                    } else if (_imageUrlController.text.isNotEmpty) {
                      uploadedUrl = _imageUrlController.text;
                    }

                    if (uploadedUrl != null) {
                      if (type == 'profile picture') {
                        userProfileProvider.profilePictureController.text =
                            uploadedUrl;
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

  Future<void> _showLocationDialog(
      BuildContext context, UserProfileProvider userProfileProvider) {
    final TextEditingController addressController = TextEditingController();
    final MapController mapController = MapController();
    LatLng selectedLocation =
        const LatLng(10.322467560222893, 123.89885172891246);

    // Local state for dialog suggestions
    List<Map<String, dynamic>> dialogSuggestions = [];
    Timer? dialogSearchTimer;

    // Initialize with existing data if available
    if (userProfileProvider.userAddressController.text.isNotEmpty) {
      addressController.text = userProfileProvider.userAddressController.text;
    }

    if (userProfileProvider.latitude.isNotEmpty &&
        userProfileProvider.longitude.isNotEmpty) {
      selectedLocation = LatLng(
        double.parse(userProfileProvider.latitude),
        double.parse(userProfileProvider.longitude),
      );
    }

    // Function to move map to coordinates
    void moveMapToLocation(double lat, double lon) {
      selectedLocation = LatLng(lat, lon);
      mapController.move(selectedLocation, 15);
    }

    // Function to search for suggestions
    Future<void> searchForSuggestions(
        String query, StateSetter dialogSetState) async {
      if (query.isEmpty) {
        dialogSetState(() {
          dialogSuggestions = [];
        });
        return;
      }

      // Cancel previous timer
      dialogSearchTimer?.cancel();

      // Debounce search - wait 500ms after user stops typing
      dialogSearchTimer = Timer(const Duration(milliseconds: 500), () async {
        try {
          print('Dialog searching for: $query'); // Debug print
          final encodedQuery = Uri.encodeComponent(query);
          final url =
              'https://nominatim.openstreetmap.org/search?format=json&q=$encodedQuery&limit=5&countrycodes=ph&addressdetails=1';

          final response = await http.get(
            Uri.parse(url),
            headers: {
              'User-Agent': 'Farm2You/1.0 (Flutter App)',
            },
          );

          print(
              'Dialog response status: ${response.statusCode}'); // Debug print

          if (response.statusCode == 200) {
            final List<dynamic> data = json.decode(response.body);
            print('Dialog found ${data.length} results'); // Debug print

            dialogSetState(() {
              dialogSuggestions = data.cast<Map<String, dynamic>>();
            });
          } else {
            print('Dialog error: HTTP ${response.statusCode}');
            dialogSetState(() {
              dialogSuggestions = [];
            });
          }
        } catch (e) {
          print('Dialog search error: $e'); // Debug print
          dialogSetState(() {
            dialogSuggestions = [];
          });
        }
      });
    }

    // Function to search and move map based on typed address
    void searchAndMoveMap(String query) async {
      if (query.isEmpty) return;

      try {
        print('Auto-moving map for: $query'); // Debug print
        final encodedQuery = Uri.encodeComponent(query);
        final response = await http.get(
          Uri.parse(
              'https://nominatim.openstreetmap.org/search?format=json&q=$encodedQuery&limit=1&countrycodes=ph&addressdetails=1'),
          headers: {
            'User-Agent': 'Farm2You/1.0 (Flutter App)',
          },
        );

        print('Auto-move response: ${response.statusCode}'); // Debug print

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            final firstResult = data[0];
            final lat = double.tryParse(firstResult['lat'] ?? '');
            final lon = double.tryParse(firstResult['lon'] ?? '');

            print('Moving to: $lat, $lon'); // Debug print

            if (lat != null && lon != null) {
              moveMapToLocation(lat, lon);
            }
          }
        }
      } catch (e) {
        print('Error moving map: $e'); // Debug print
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Set User Location',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Address input field with search functionality
                    Column(
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE7EAE5)),
                          ),
                          child: TextField(
                            controller: addressController,
                            onChanged: (value) {
                              print('User typed: $value'); // Debug print
                              // Show suggestions for dialog
                              searchForSuggestions(value, setState);

                              // Auto-move map after user stops typing (debounced)
                              Timer(const Duration(milliseconds: 1000), () {
                                if (addressController.text == value &&
                                    value.isNotEmpty) {
                                  searchAndMoveMap(value);
                                  setState(() {});
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search user address',
                              hintStyle: TextStyle(
                                color: Color(0xFF91958E),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF91958E),
                              ),
                            ),
                          ),
                        ),

                        // Search suggestions dropdown - using local dialog suggestions
                        if (dialogSuggestions.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            constraints: const BoxConstraints(maxHeight: 150),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: const Color(0xFFE7EAE5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: dialogSuggestions.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                height: 1,
                                color: Color(0xFFE7EAE5),
                              ),
                              itemBuilder: (context, index) {
                                final suggestion = dialogSuggestions[index];
                                return ListTile(
                                  dense: true,
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF91958E),
                                    size: 20,
                                  ),
                                  title: Text(
                                    suggestion['display_name'] ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    print(
                                        'Selected suggestion: ${suggestion['display_name']}'); // Debug print

                                    // Update address controller
                                    addressController.text =
                                        suggestion['display_name'] ?? '';

                                    // Update map location
                                    final lat = double.tryParse(
                                            suggestion['lat'] ?? '') ??
                                        selectedLocation.latitude;
                                    final lon = double.tryParse(
                                            suggestion['lon'] ?? '') ??
                                        selectedLocation.longitude;

                                    moveMapToLocation(lat, lon);

                                    // Clear local suggestions
                                    setState(() {
                                      dialogSuggestions = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Map container
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE7EAE5)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: selectedLocation,
                              initialZoom: 15,
                              minZoom: 0,
                              maxZoom: 100,
                              onTap: (tapPosition, point) {
                                setState(() {
                                  selectedLocation = point;
                                });
                                // Clear local suggestions when user taps on map
                                setState(() {
                                  dialogSuggestions = [];
                                });

                                // Optionally reverse geocode to update address field
                                _reverseGeocode(point, addressController);
                              },
                              cameraConstraint: CameraConstraint.contain(
                                bounds: LatLngBounds(
                                  const LatLng(-85.0, -180.0),
                                  const LatLng(85.0, 180.0),
                                ),
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: selectedLocation,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Location info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Location:',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Lat: ${selectedLocation.latitude.toStringAsFixed(6)}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF91958E),
                            ),
                          ),
                          Text(
                            'Lng: ${selectedLocation.longitude.toStringAsFixed(6)}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF91958E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    dialogSearchTimer?.cancel();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF91958E),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a user address'),
                        ),
                      );
                      return;
                    }

                    // Save the location data to the provider
                    userProfileProvider.setUserLocation(
                      address: addressController.text,
                      latitude: selectedLocation.latitude.toString(),
                      longitude: selectedLocation.longitude.toString(),
                    );

                    dialogSearchTimer?.cancel();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0D003),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Save Location',
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
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
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
                        // Full name field
                        _buildInputField(userProfileProvider.fullNameController,
                            'Full name', userProfileProvider),
                        const SizedBox(height: 20),

                        // Age and Birthdate fields in a row
                        _buildAgeAndBirthdateFields(userProfileProvider),
                        const SizedBox(height: 20),

                        // Email field
                        _buildInputField(userProfileProvider.emailController,
                            'e-mail', userProfileProvider),
                        const SizedBox(height: 20),

                        // Phone fields - now placed after email
                        _buildPhoneFields(userProfileProvider),
                        const SizedBox(height: 20),

                        // Profile Picture field with upload button
                        _buildInputFieldWithButton(
                            userProfileProvider.profilePictureController,
                            'Profile Picture',
                            userProfileProvider),
                        const SizedBox(height: 20),

                        // Location field with location button
                        _buildLocationField(userProfileProvider),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              _buildRegisterButton(context, userProfileProvider),
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
      UserProfileProvider userProfileProvider) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _inputDecoration,
      child: TextField(
        controller: controller,
        onChanged: (_) => userProfileProvider.updateValidation(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildAgeAndBirthdateFields(UserProfileProvider userProfileProvider) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: _inputDecoration,
            child: TextField(
              controller: userProfileProvider.ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => userProfileProvider.updateValidation(),
              decoration: InputDecoration(
                hintText: 'Age',
                hintStyle: _hintStyle,
                border: InputBorder.none,
              ),
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
              controller: userProfileProvider.birthdateController,
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFFF0D003),
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  userProfileProvider.birthdateController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                  userProfileProvider.updateValidation();
                }
              },
              decoration: InputDecoration(
                hintText: 'Birthdate',
                hintStyle: _hintStyle,
                border: InputBorder.none,
                suffixIcon: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF91958E),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputFieldWithButton(TextEditingController controller,
      String hint, UserProfileProvider userProfileProvider) {
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
                onChanged: (_) => userProfileProvider.updateValidation(),
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
                String type =
                    hint.contains('Picture') ? 'profile picture' : 'cover';
                _showUploadDialog(context, userProfileProvider, type);
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

  Widget _buildLocationField(UserProfileProvider userProfileProvider) {
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
                controller: userProfileProvider.locationController,
                readOnly: true,
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
              _showLocationDialog(context, userProfileProvider);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.location_on,
                color: Color(0xFF91958E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFields(UserProfileProvider userProfileProvider) {
    return Row(
      children: [
        Container(
          width: 68,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: _inputDecoration,
          child: TextField(
            controller: userProfileProvider.areaCodeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty && !value.startsWith('+')) {
                userProfileProvider.updateValidation();
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
              controller: userProfileProvider.phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => userProfileProvider.updateValidation(),
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

  Widget _buildRegisterButton(
      BuildContext context, UserProfileProvider userProfileProvider) {
    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ElevatedButton(
        onPressed:
            userProfileProvider.isFormValid && !userProfileProvider.isLoading
                ? () async {
                    bool success = await userProfileProvider.saveUserProfile();
                    if (success) {
                      // Navigate to success screen or handle success
                      context.go('/splashscreen');
                    }
                  }
                : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: userProfileProvider.isFormValid
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
        child: userProfileProvider.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                'Register',
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
