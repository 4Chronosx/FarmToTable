import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<bool> addProduct({
    required String pid,
    required String pname,
    required String details,
    required String source,
    required double price,
    required String unit,
    required String category,
    required int stockQuant,
    required int storeID,
    required String imgPath,
  }) async {
    try {
      final response = await supabase.rpc('add_product', params: {
        'pid': pid,
        'pname': pname,
        'details': details,
        'source': source,
        'price': price,
        'unit': unit,
        'category': category,
        'stockquant': stockQuant,
        'storeid': storeID,
        'imgpath': imgPath,
      });

      print('Product added successfully: $response');
      return true;
    } catch (error) {
      print('Error adding product: $error');
      return false;
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await supabase
          .rpc('products_in_category', params: {'category_name':category});

      List<ProductModel> products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      /*
  // Now you have a List<ProductModel>
  for (var product in products) {
    print('Product: ${product.pname}, Price: ${product.price}');
  } */

      return products;
    } catch (error) {
      print('Error calling function: $error');
      return [];
    }
  }

  Future<bool> updateProductImage({
    required String productID,
    required String newImageUrl,
  }) async {
    try {
      final response = await supabase
          .from('Product')
          .update({'imgPath': newImageUrl})
          .eq('productID', productID)
          .maybeSingle();

      // If no exception, consider it success
      return true;
    } catch (e) {
      print('Update failed: $e');
      return false;
    }
  }

  Future<void> addToCart({
    required String cartID,
    required String productID,
    required int quantity,
    required bool isSelected,
  }) async {
    final response = await supabase.rpc(
      'addtocart',
      params: {
        'cartid': cartID,
        'productid': productID,
        'quantity': quantity,
        'isselected': isSelected,
      },
    ).maybeSingle();

    if (response == null) {
      throw Exception('Failed to add to cart');
    }
  }

  Future<String?> fetchCartID(String userID) async {
    final response = await supabase
        .from('Customer')
        .select('cartID')
        .eq('userID', userID)
        .single(); // we expect exactly one row
    
    /*
    if (response == null) {
      print('Error fetching cartID');
      return null;
    }

    final data = response;
    if (data == null) {
      print('No customer found with userID: $userID');
      return null;
    } */

    // Assuming cartID is a string in your DB
    return response['cartID'] as String?;
  }
}


