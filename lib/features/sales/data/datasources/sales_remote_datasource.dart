import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import '../../../cart/data/models/cart_item_model.dart';

class SalesRemoteDatasource {
  final SupabaseClient _client = SupabaseConfig.client;

  // CREATE SALE + ITEMS
  Future<String> createSale({
    required List<CartItem> cart,
    required double total,
  }) async {
    final user = _client.auth.currentUser;

    final invoiceNumber =
        "INV-${DateTime.now().millisecondsSinceEpoch}";

    // 1. Insert SALE
    final sale = await _client
        .from('sales')
        .insert({
      'invoice_number': invoiceNumber,
      'subtotal': total,
      'total': total,
      'payment_status': 'paid',
      'payment_method': 'cash',
      'created_by': user?.id,
    })
        .select()
        .single();

    final saleId = sale['id'];

    // 2. Insert SALE ITEMS
    for (final item in cart) {
      await _client.from('sale_items').insert({
        'sale_id': saleId,
        'product_id': item.product.id,
        'quantity': item.quantity,
        'unit_price': item.product.sellingPrice,
        'total': item.total,
      });

      // 3. Reduce stock
      await _client.rpc('decrease_stock', params: {
        'pid': item.product.id,
        'qty': item.quantity,
      });
    }

    return invoiceNumber;
  }

  // GET ALL SALES (for history screen later)
  Future<List<Map<String, dynamic>>> getSales() async {
    final response = await _client
        .from('sales')
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // GET SINGLE SALE DETAILS (invoice view)
  Future<Map<String, dynamic>> getSaleDetails(String saleId) async {
    final sale = await _client
        .from('sales')
        .select()
        .eq('id', saleId)
        .single();

    final items = await _client
        .from('sale_items')
        .select()
        .eq('sale_id', saleId);

    return {
      'sale': sale,
      'items': items,
    };
  }
}