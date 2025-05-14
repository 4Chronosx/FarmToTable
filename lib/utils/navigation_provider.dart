import 'package:farm2you/commons.dart';



class NavigationProvider with ChangeNotifier {
  int currentIndexVar = 0;
  int get currentIndex => currentIndexVar;

  void changePage(int index) {
    currentIndexVar = index;
    notifyListeners();
  }
}