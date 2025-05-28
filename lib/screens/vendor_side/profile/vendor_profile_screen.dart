import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm2you/widgets/vendor_navigationbar.dart';
import 'package:farm2you/utils/profile_provider.dart';
import 'package:farm2you/utils/vendor_provider.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Consumer2<ProfileProvider, VendorProvider>(
              builder: (context, profileProvider, vendorProvider, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
                        child:
                            _buildProfileCard(profileProvider, vendorProvider),
                      ),
                      _buildDividerLine(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                        child: _buildInfoCard(profileProvider),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: VendorNavigationBar(selectedIndex: 3),
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
          child: const Padding(
            padding: EdgeInsets.only(top: 70, left: 24, right: 24, bottom: 20),
            child: Center(
              child: Text(
                'Profile',
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
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(
      ProfileProvider profileProvider, VendorProvider vendorProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 141,
            height: 143,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: const Color(0xFFF0D003),
              ),
              image: DecorationImage(
                image: profileProvider.storeLogoController.text.isNotEmpty
                    ? NetworkImage(profileProvider.storeLogoController.text)
                    : const NetworkImage("https://placehold.co/141x143"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Business Name
          Text(
            profileProvider.businessNameController.text.isNotEmpty
                ? profileProvider.businessNameController.text
                : 'Business Name',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 1.27,
            ),
          ),

          // Add spacing between Business Name and Vendor ID
          const SizedBox(height: 8),

          // Vendor ID
          Text(
            vendorProvider.currentVendorId.isNotEmpty
                ? 'Vendor ID: ${vendorProvider.currentVendorId}'
                : 'Vendor ID: Not Available',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF647A4C),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerLine() {
    return Container(
      width: double.infinity,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFF77905B),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ProfileProvider profileProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            'FULL NAME',
            profileProvider.fullNameController.text.isNotEmpty
                ? profileProvider.fullNameController.text
                : 'Full Name',
            Icons.person,
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            'PHONE NUMBER',
            profileProvider.areaCodeController.text.isNotEmpty &&
                    profileProvider.phoneNumberController.text.isNotEmpty
                ? '+${profileProvider.areaCodeController.text} ${profileProvider.phoneNumberController.text}'
                : '+63 912345678',
            Icons.phone,
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            'EMAIL',
            profileProvider.emailController.text.isNotEmpty
                ? profileProvider.emailController.text
                : 'email@example.com',
            Icons.email,
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            'ADDRESS',
            profileProvider.locationController.text.isNotEmpty
                ? profileProvider.locationController.text
                : 'Address not provided',
            Icons.location_on,
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            'TYPE OF GOOD/S',
            profileProvider.getSelectedCategories().isNotEmpty
                ? profileProvider.getSelectedCategories().join(', ')
                : 'No categories selected',
            Icons.shopping_basket,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF647A4C),
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF32343E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
