import 'package:farm2you/commons.dart';
import 'package:farm2you/screens/login/login_screen.dart';
import 'package:farm2you/screens/user_side/main_home_screen/main_home_screen.dart';
import 'package:farm2you/screens/vendor_side/dashboard/dashboard_screen.dart';
import 'package:farm2you/utils/role_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);
    final role = roleProvider.currentIndex;
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange, 
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),)
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          if (role == 0) {
            return MainHomeScreen();
          } else {
            return DashboardScreen();
          }
            
        } else {
          return LoginScreen();
        }
      }
    );
  }
}