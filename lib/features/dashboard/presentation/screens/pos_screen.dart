import 'package:flutter/material.dart';
import '../../../products/data/datasources/product_datasource.dart';
import '../../../products/data/models/product_model.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../sales/data/datasources/sales_remote_datasource.dart';

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  final ProductDatasource datasource = ProductDatasource();
  final SalesRemoteDatasource salesService = SalesRemoteDatasource();

  List<ProductModel> products = [];
  List<CartItem> cart = [];

  void increaseQty(int index) {
    setState(() {
      cart[index].quantity++;
    });
  }

  void decreaseQty(int index) {
    setState(() {
      if (cart[index].quantity > 1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final data = await datasource.getProducts();
    setState(() {
      products = data;
    });
  }

  void addToCart(ProductModel product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    setState(() {
      if (index >= 0) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(product: product));
      }
    });
  }

  double get total {
    return cart.fold(0, (sum, item) => sum + item.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POS Billing"),
      ),
      body: Column(
        children: [

          // 🔥 BARCODE SCANNER (TOP BAR)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Scan / Enter Barcode",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                final product = await datasource.getByBarcode(value);

                if (product != null) {
                  addToCart(product);
                }
              },
            ),
          ),

          // 🔥 MAIN POS AREA
          Expanded(
            child: Row(
              children: [

                // PRODUCTS
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text("₹${p.sellingPrice}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => addToCart(p),
                        ),
                      );
                    },
                  ),
                ),

                // CART
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Cart",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final item = cart[index];

                              return ListTile(
                                title: Text(item.product.name),
                                subtitle: Text("Qty: ${item.quantity}"),
                                trailing: Text("₹${item.total}"),
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "Total: ₹$total",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}