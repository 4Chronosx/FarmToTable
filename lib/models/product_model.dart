

import 'package:farm2you/commons.dart';

class ProductModel {
  String name;
  String description;
  String source;
  String category;
  String vendor;
  String imgPath;
  double price;
  String unit;
  void Function()? onTap;

  ProductModel({
    required this.name,
    required this.description,
    required this.source,
    required this.category,
    required this.vendor,
    required this.imgPath,
    required this.price,
    required this.unit,
    this.onTap

  });


  static List<ProductModel> getProducts(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        'name' : 'Mangoes',
        'description' : 'A fruit that is yellow',
        'source' : 'Harvested from the municipality of Barili, Cebu',
        'category' : 'Fruits',
        'vendor' : 'The Mango Farm',
        'imgPath' : 'somepath/',
        'price' : 100.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Dragon fruit',
        'description' : 'A fruit that is purple',
        'source' : 'Harvested from the municipality of Minglanilla, Cebu',
        'category' : 'Fruits',
        'vendor' : 'The DragonFruit Farm',
        'imgPath' : 'somepath/',
        'price' : 120.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Brocolli',
        'description' : 'A vegetable that is green and tree like',
        'source' : 'Harvested from the municipality of Carvar, Cebu',
        'category' : 'Vegetables',
        'vendor' : 'The Vegetable Farm',
        'imgPath' : 'somepath/',
        'price' : 90.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Carrots',
        'description' : 'A vegetable that is orange and pointy',
        'source' : 'Harvested from the municipality of Consolacion, Cebu',
        'category' : 'Vegetables',
        'vendor' : 'The Vegetable Farm',
        'imgPath' : 'somepath/',
        'price' : 90.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Pork Meat',
        'description' : 'A meat that is from pigs',
        'source' : 'Breed from the municipality of Cebu City, Cebu',
        'category' : 'Meat',
        'vendor' : 'The Meat Farm',
        'imgPath' : 'somepath/',
        'price' : 300.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Beef Meat',
        'description' : 'A meat that is from cows',
        'source' : 'Breed from the municipality of Mandaue City, Cebu',
        'category' : 'Meat',
        'vendor' : 'The Meat Farm',
        'imgPath' : 'somepath/',
        'price' : 300.00,
        'unit' : 'kg'
      },
      {
        'name' : 'Black Chicken',
        'description' : 'A chicken that is black',
        'source' : 'Breed from the municipality of Lapu-Lapu City, Cebu',
        'category' : 'Poultry',
        'vendor' : 'The Poultry Farm',
        'imgPath' : 'somepath/',
        'price' : 300.00,
        'unit' : 'kg'
      },

    ];

    return items.map((item) {
      final product = ProductModel(
        name: item['name'], 
        description: item['description'], 
        source: item['source'], 
        category: item['category'], 
        vendor: item['vendor'], 
        imgPath: item['imgPath'], 
        price: item['price'], 
        unit: item['unit']);

        return ProductModel(
        name: product.name, 
        description: product.name, 
        source: product.source, 
        category: product.category, 
        vendor: product.vendor, 
        imgPath: product.imgPath, 
        price: product.price, 
        unit: product.unit,
        onTap: () {
          context.push('/product_details');
        });
    }).toList();
  }
  


}