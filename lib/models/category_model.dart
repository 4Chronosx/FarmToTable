import 'package:farm2you/commons.dart';


class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;
  Color textColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
    required this.textColor
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'Fruits', 
        iconPath: 'assets/icons/fruits.svg', 
        boxColor: Color(0xFFFAE526),
        textColor: Colors.black),
        
    );

    categories.add(
      CategoryModel(
        name: 'Vegetables', 
        iconPath: 'assets/icons/vegetables.svg', 
        boxColor: Color(0xFF77905B),
        textColor: Colors.white)
    );

    categories.add(
      CategoryModel(
        name: 'Herbs', 
        iconPath: 'assets/icons/herb.svg', 
        boxColor: Color(0xFFFAE526),
        textColor: Colors.black)
    );

    categories.add(
      CategoryModel(
        name: 'Grains', 
        iconPath: 'assets/icons/grains.svg', 
        boxColor: Color(0xFF77905B),
        textColor: Colors.white)
    );

    categories.add(
      CategoryModel(
        name: 'Dairy', 
        iconPath: 'assets/icons/dairy.svg', 
        boxColor: Color(0xFFFAE526),
        textColor: Colors.black)
    );

    categories.add(
      CategoryModel(
        name: 'Meat', 
        iconPath: 'assets/icons/meat.svg', 
        boxColor: Color(0xFF77905B),
        textColor: Colors.white)
    );

    categories.add(
      CategoryModel(
        name: 'Poultry', 
        iconPath: 'assets/icons/poultry.svg', 
        boxColor: Color(0xFFFAE526),
        textColor: Colors.black)
    );

    categories.add(
      CategoryModel(
        name: 'Eggs', 
        iconPath: 'assets/icons/eggs.svg', 
        boxColor: Color(0xFF77905B),
        textColor: Colors.white)
    );

    categories.add(
      CategoryModel(
        name: 'Organic Packs', 
        iconPath: 'assets/icons/packed.svg', 
        boxColor: Color(0xFFFAE526),
        textColor: Colors.black)
    );

    return categories;
  }
}