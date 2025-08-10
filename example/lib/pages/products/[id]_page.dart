import 'package:flutter/material.dart';

/// Product detail page - Shows details for a specific product
class ProductPage extends StatelessWidget {
  final String id;
  
  const ProductPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final products = {
      '1': 'iPhone 15',
      '2': 'MacBook Pro', 
      '3': 'AirPods Pro'
    };

    final productName = products[id] ?? 'Unknown Product';

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Product ID: $id',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This demonstrates dynamic routing with parameters. The ID is extracted from the URL and passed to the page constructor.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
