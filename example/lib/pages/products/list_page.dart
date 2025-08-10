import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Product list page - Shows all available products
class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ['iPhone 15', 'MacBook Pro', 'AirPods Pro'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final productId = (index + 1).toString();
          return ListTile(
            title: Text(products[index]),
            subtitle: Text('Product ID: $productId'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.go('/products/$productId'),
          );
        },
      ),
    );
  }
}
