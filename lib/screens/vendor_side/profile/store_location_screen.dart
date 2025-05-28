// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StoreLocationScreen extends StatefulWidget {
  const StoreLocationScreen({super.key});

  @override
  State<StoreLocationScreen> createState() => _StoreLocationScreenState();
}

class _StoreLocationScreenState extends State<StoreLocationScreen> {
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  // Map controller
  final MapController _mapController = MapController();

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
  void dispose() {
    _streetAddressController.dispose();
    _barangayController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildMapSection(),
                  _buildFormSection(),
                ],
              ),
            ),
          ),

          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0x0C000000), blurRadius: 20, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.push('/createprofilevendor');
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(child: Icon(Icons.arrow_back)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
            initialCenter: LatLng(10.322467560222893, 123.89885172891246),
            initialZoom: 18,
            minZoom: 0,
            maxZoom: 100,
            cameraConstraint: CameraConstraint.contain(
                bounds: LatLngBounds(
                    const LatLng(-85.0, -180.0), const LatLng(85.0, 180.0)))),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        children: [
          _buildInputField(_streetAddressController, 'Street Address'),
          const SizedBox(height: 14),
          _buildInputField(_barangayController, 'Barangay'),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(_cityController, 'City', width: 180),
              const SizedBox(width: 10),
              _buildInputField(_provinceController, 'Province', width: 180),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(_countryController, 'Country', width: 180),
              const SizedBox(width: 10),
              _buildInputField(_postalCodeController, 'ZIP / Postal code',
                  width: 180),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint,
      {double width = 370}) {
    return Container(
      width: width,
      height: 48,
      decoration: _inputDecoration,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: _hintStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      height: 90,
      alignment: Alignment.center,
      color: const Color(0xFFFFEE84),
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
    );
  }
}
