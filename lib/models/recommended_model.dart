import 'package:farm2you/commons.dart';


class RecommendedModel {
  String name;
  String vendor;
  String price; 
  String imagePath;
  Color textColor;
  Color bgColor;

  RecommendedModel({
    required this.name,
    required this.vendor,
    required this.price,
    required this.imagePath,
    required this.textColor,
    required this.bgColor
  });

  static List<RecommendedModel> getRecommendations() {
    List<RecommendedModel> recommendations = [];

    recommendations.add(
      RecommendedModel(
        name: 'Fresh Carrots', 
        vendor: 'The Vegetable Farm', 
        price: 'P100/kg ', 
        imagePath: 'assets/images/carrots.jpg', 
        textColor: Colors.black, 
        bgColor: Color(0xFFFAE526),)
    );

    recommendations.add(
      RecommendedModel(
        name: 'Fresh Carrots', 
        vendor: 'The Vegetable Farm', 
        price: 'P100/kg ', 
        imagePath: 'assets/images/carrots.jpg', 
        textColor: Colors.white, 
        bgColor: Color(0xFF77905B),)
    );

    recommendations.add(
      RecommendedModel(
        name: 'Fresh Carrots', 
        vendor: 'The Vegetable Farm', 
        price: 'P100/kg ', 
        imagePath: 'assets/images/carrots.jpg', 
        textColor: Colors.black, 
        bgColor: Color(0xFFFAE526),)
    );




    return recommendations;
  }
}