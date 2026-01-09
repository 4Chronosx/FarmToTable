import 'package:supabase_flutter/supabase_flutter.dart';

int? calculateAge(String birthdateStr) {
  try {
    final birthdate = DateTime.parse(birthdateStr);
    final now = DateTime.now();

    int age = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }
    return age;
  } catch (_) {
    return null; // Invalid date format
  }
}

class CreateProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> submitProfile(Map<String, dynamic> profileData) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("No logged-in user");

    final String address = profileData['storeAddress'] ?? '';
    final String birthdate = profileData['birthdate'] ?? '';
    final int? age = calculateAge(birthdate);

    try {
      // --- Update Users table ---
      final userUpdateData = {
        'FName': profileData['fullName'],
        'address': address,
        'birthdate': birthdate,
        'age': age,
        'phone': profileData['phoneNumber'],
      };

      await _supabase
          .from('Users')
          .update(userUpdateData)
          .eq('userID', user.id);

      // --- Get latest storeID ---
      final latestStore = await _supabase
          .from('Store')
          .select('storeID')
          .order('storeID', ascending: false)
          .limit(1)
          .maybeSingle();

      int newStoreID = 1;
      if (latestStore != null && latestStore['storeID'] != null) {
        final latestID = latestStore['storeID'];
        if (latestID is int) {
          newStoreID = latestID + 1;
        } else if (latestID is String) {
          newStoreID = int.tryParse(latestID) != null ? int.parse(latestID) + 1 : 1;
        }
      }

      // --- Insert into Store table ---
      final storeInsertData = {
        'storeID': newStoreID,
        'storeName': profileData['businessName'],
        'storeAddress': address,
        'latitude': profileData['latitude'],
        'longitude': profileData['longitude'],
        'logo': profileData['storeLogo'],
        'description': profileData['description']
      };

      await _supabase.from('Store').insert(storeInsertData);

      // --- Update Farmer table ---
      await _supabase
          .from('Farmer')
          .update({'storeID': newStoreID})
          .eq('userID', user.id);
    } catch (e) {
      print('Save error: $e');
      rethrow;
    }
  }
}



