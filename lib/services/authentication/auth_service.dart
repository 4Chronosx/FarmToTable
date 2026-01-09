import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password
    );
  }

  Future<AuthResponse> signUpWitheEmailPassword(String email, String password, bool isCustomer) async {
    final response = await _supabase.auth.signUp(email: email, password: password);

    final userID = response.user?.id;
    if (userID != null) {
      await _supabase.from('Users').insert({'userID': userID});

      if (isCustomer) {
        await _supabase.from('Customer').insert({'userID': userID});
      } else {
        await _supabase.from('Farmer').insert({'userID': userID});
      }
    }

    return response;


  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }

  Future<String?> getRole() async {
    final user = _supabase.auth.currentUser;
    final userID = user?.id;

    if (userID == null) return null; 
    final roleRow = await _supabase
        .from('user_roles')
        .select('role')
        .eq('userID', userID)
        .maybeSingle(); 

    return roleRow?['role'] as String?;
  }

  
  Future<bool> needsProfile() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return false;
    }

    final response = await _supabase
      .from('Users')
      .select()
      .eq('userID', user.id)
      .maybeSingle();

    if (response == null) return true;
    if (response['FName'] == null) {
      print('FName is null .......................');
      return true;
    }

    return false;
  }

  

  



}