import 'package:flutter/material.dart';
import '../../app_router.g.dart';

/// The products list page widget that displays a list of available products.
class ProductsListPage extends StatelessWidget {
  /// Creates a products list page widget.
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'id': 'product-1', 'name': 'Flutter T-Shirt'},
      {'id': 'product-2', 'name': 'Dart Hoodie'},
      {'id': 'product-3', 'name': 'Firebase Mug'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']!),
            subtitle: Text('ID: ${product['id']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Using generated type-safe navigation
              Navigate.pushToProductsid(id: product['id']!);
            },
          );
        },
      ),
    );
  }
}
