import 'package:supabase_flutter/supabase_flutter.dart';

int? calculateAge(String birthdateStr) {
  try {
    final birthdate = DateTime.parse(birthdateStr);
    final now = DateTime.now();
    int age = now.year - birthdate.year;
    if (now.month < birthdate.month || (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }
    return age;
  } catch (_) {
    return null;
  }
}

class CreateUserProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> submitProfile(Map<String, dynamic> profileData) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception("No logged-in user");

    final String birthdate = profileData['birthdate'] ?? '';
    final int? age = calculateAge(birthdate);

    try {
      // --- Update Users table ---
      final userUpdateData = {
        'FName': profileData['fullName'],
        'address': profileData['userAddress'],
        'birthdate': birthdate,
        'age': age,
        'phone': profileData['phoneNumber'],
        'avatar_url': profileData['profilePicture'],
      };

      await _supabase
          .from('Users')
          .update(userUpdateData)
          .eq('userID', user.id);

      // --- Get latest cartID from Cart table ---
      final latestCart = await _supabase
          .from('Cart')
          .select('cartID')
          .order('cartID', ascending: false)
          .limit(1)
          .maybeSingle();

      int newCartID = 1;
      if (latestCart != null && latestCart['cartID'] != null) {
        final latestID = latestCart['cartID'];
        if (latestID is int) {
          newCartID = latestID + 1;
        } else if (latestID is String) {
          final parsed = int.tryParse(latestID);
          if (parsed != null) newCartID = parsed + 1;
        }
      }

      final String newCartIDStr = newCartID.toString();

      // --- Insert new Cart ---
      await _supabase.from('Cart').insert({
        'cartID': newCartIDStr,
        'capacity': 100 // Assuming starting capacity is 0
      });

      // --- Update Customer with new cartID ---
      await _supabase
          .from('Customer')
          .update({'cartID': newCartIDStr})
          .eq('userID', user.id);

      print("Customer profile and cart created successfully.");
    } catch (e) {
      print('Error submitting profile: $e');
      rethrow;
    }
  }
}
