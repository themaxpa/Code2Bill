class ProductModel {
  final String id;
  final String name;
  final String barcode;
  final double sellingPrice;
  final int stock;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.barcode,
    required this.sellingPrice,
    required this.stock,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      barcode: json['barcode'],
      sellingPrice: (json['selling_price'] as num).toDouble(),
      stock: json['stock'],
      imageUrl: json['image_url'],
    );
  }
}