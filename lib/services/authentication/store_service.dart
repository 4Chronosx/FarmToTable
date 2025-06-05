import 'package:supabase_flutter/supabase_flutter.dart';

class StoreService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> getStoreNameByStoreID(int storeID) async {
    final data = await supabase
        .from('Store')
        .select('storeName')
        .eq('storeID', storeID)
        .maybeSingle();

    if (data == null) {
      return null;
    }

    return data['storeName'] as String?;
  }

  Future<int?> getStoreIdByUserId(String userId) async {
  try {
    final response = await supabase
        .from('Farmer')           // Assuming Store table stores storeID and userID
        .select('storeID')
        .eq('userID', userId)
        .single()
        .maybeSingle();

    if (response!['storeID'] != null) {
      print("Succesfully added");
    }

    // response.data is a map with the selected fields
    return response['storeID'] as int?;
  } catch (e) {
    print('Exception fetching storeID: $e');
    return null;
  }
}

}

