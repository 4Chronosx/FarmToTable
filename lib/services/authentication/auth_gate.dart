import 'package:farm2you/commons.dart';
import 'package:farm2you/screens/login/login_screen.dart';
import 'package:farm2you/screens/user_side/main_home_screen/main_home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
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
          return MainHomeScreen();
        } else {
          return LoginScreen();
        }
      }
    );
  }
}