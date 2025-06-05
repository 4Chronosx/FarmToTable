import 'package:farm2you/commons.dart';
import 'package:farm2you/screens/login/login_screen.dart';
import 'package:farm2you/screens/signup/user_create_profile.dart';
import 'package:farm2you/screens/user_side/main_home_screen/main_home_screen.dart';
import 'package:farm2you/screens/vendor_side/dashboard/dashboard_screen.dart';
import 'package:farm2you/screens/vendor_side/profile/create_profile_screen.dart';
import 'package:farm2you/services/authentication/auth_service.dart';
import 'package:farm2you/utils/role_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);
    final role = roleProvider.currentIndex;
    final authService = AuthService();

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If not logged in
        if (session == null) {
          return const LoginScreen();
        }

        // If logged in → check if profile exists
        return FutureBuilder<bool>(
          future: authService.needsProfile(),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final needsProfile = profileSnapshot.data ?? false;

            if (needsProfile) {
              if (role == 0) {
                return const UserCreateProfileScreen();
              } else {
                return const CreateProfileScreen(); // <- You must create this screen
              }
              
            }

            print('Profile exists');

            // Profile exists → redirect based on role
            if (role == 0) {
              return const MainHomeScreen();
            } else {
              return const DashboardScreen();
            }
          },
        );
      },
    );
  }
}
