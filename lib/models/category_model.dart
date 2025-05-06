import 'package:farm2you/commons.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;
  Color textColor;
  void Function()? onTap;

  CategoryModel(
      {required this.name,
      required this.iconPath,
      required this.boxColor,
      required this.textColor,
      this.onTap});

  static List<CategoryModel> getCategories(BuildContext context) {
    List<Map<String, dynamic>> rawData = [
      {
        'name': 'Fruits',
        'icon': 'assets/icons/fruits.svg',
        'boxColor': Color(0xFFFAE526),
        'textColor': Colors.black,
      },
      {
        'name': 'Vegetables',
        'icon': 'assets/icons/vegetables.svg',
        'boxColor': Color(0xFF77905B),
        'textColor': Colors.white,
      },
      {
        'name': 'Herbs',
        'icon': 'assets/icons/herb.svg',
        'boxColor': Color(0xFFFAE526),
        'textColor': Colors.black,
      },
      {
        'name': 'Grains',
        'icon': 'assets/icons/grains.svg',
        'boxColor': Color(0xFF77905B),
        'textColor': Colors.white,
      },
      {
        'name': 'Dairy',
        'icon': 'assets/icons/dairy.svg',
        'boxColor': Color(0xFFFAE526),
        'textColor': Colors.black,
      },
      {
        'name': 'Meat',
        'icon': 'assets/icons/meat.svg',
        'boxColor': Color(0xFF77905B),
        'textColor': Colors.white,
      },
      {
        'name': 'Poultry',
        'icon': 'assets/icons/poultry.svg',
        'boxColor': Color(0xFFFAE526),
        'textColor': Colors.black,
      },
      {
        'name': 'Eggs',
        'icon': 'assets/icons/eggs.svg',
        'boxColor': Color(0xFF77905B),
        'textColor': Colors.white,
      },
      {
        'name': 'Organic Packs',
        'icon': 'assets/icons/packed.svg',
        'boxColor': Color(0xFFFAE526),
        'textColor': Colors.black,
      },
    ];

    return rawData.map((item) {
      final category = CategoryModel(
        name: item['name'],
        iconPath: item['icon'],
        boxColor: item['boxColor'],
        textColor: item['textColor'],
      );

      return CategoryModel(
        name: category.name,
        iconPath: category.iconPath,
        boxColor: category.boxColor,
        textColor: category.textColor,
        onTap: () {
          context.push('/category', extra: category);
        },
      );
    }).toList();
  }
}
