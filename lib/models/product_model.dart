class ProductModel {
  final String pid;
  final String pname;
  final String details;
  final String source;
  final double price;
  final String unit;
  final String category;
  final int stockQuant;
  final int storeID;
  final String imgPath;

  ProductModel({
    required this.pid,
    required this.pname,
    required this.details,
    required this.source,
    required this.price,
    required this.unit,
    required this.category,
    required this.stockQuant,
    required this.storeID,
    required this.imgPath,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      pid: json['pid']?.toString() ?? '',
      pname: json['pname']?.toString() ?? '',
      details: json['details']?.toString() ?? '',
      source: json['source']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      stockQuant: json['stockquant'] ?? 0,
      storeID: json['storeid'] ?? 0,
      imgPath: json['imgpath']?.toString() ?? '',
    );
  }

  
}



/*


final product = ProductModel(
                    pid: 0, // or however you handle ID
                    pname: _productNameController.text,
                    description: _descriptionController.text,
                    source: _sourceController.text,
                    category: selectedCategory,
                    vendor: storeName,
                    vendorId: storeID,
                    imgPath: _selectedImagePath ?? _imageUrlController.text,
                    price: double.parse(_priceController.text),
                    unit: selectedUnit,
                    stock: int.parse(_stockController.text),
                  );


*/