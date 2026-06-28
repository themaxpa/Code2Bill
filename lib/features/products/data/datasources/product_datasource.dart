import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import '../models/product_model.dart';

class ProductDatasource {
  final SupabaseClient _client = SupabaseConfig.client;

  Future<List<ProductModel>> getProducts() async {
    final response = await _client
        .from('products')
        .select();

    return (response as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }

  Future<ProductModel?> getByBarcode(String barcode) async {
    final response = await _client
        .from('products')
        .select()
        .eq('barcode', barcode)
        .maybeSingle();

    if (response == null) return null;

    return ProductModel.fromJson(response);
  }
}