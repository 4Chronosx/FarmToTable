import 'package:farm2you/commons.dart';



class RoleProvider with ChangeNotifier {
  int currentIndexVar = 0;
  String currentRoleVar = '';
  int get currentIndex => currentIndexVar;
  String get currentRole => currentRoleVar;
  bool readyToLogin = false;
  bool get ready => readyToLogin;

  void selectRole(int index) {
    currentIndexVar = index;
    notifyListeners();
  }

  void setRole() {
    currentIndexVar == 0 ? currentRoleVar = "customer" : currentRoleVar = "farmer";
  }

  void setReady(bool value) {
    readyToLogin = value;
  }
}