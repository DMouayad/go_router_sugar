import 'package:flutter/material.dart';

/// A product page widget that displays details for a specific product.
class ProductPage extends StatelessWidget {
  /// Creates a product page widget with the specified product [id].
  const ProductPage({super.key, required this.id});

  /// The unique identifier of the product to display.
  final String id;

  @override
  Widget build(BuildContext context) {
    // Simulate product data lookup
    final productData = _getProductData(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product: $id'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productData['name']!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Product ID: $id',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              productData['description']!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Price: ${productData['price']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Added ${productData['name']} to cart!')),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _getProductData(String productId) {
    // Simulate a data lookup
    final products = {
      'product-1': {
        'name': 'Flutter T-Shirt',
        'description': 'Comfortable cotton t-shirt with Flutter logo.',
        'price': '\$29.99',
      },
      'product-2': {
        'name': 'Dart Hoodie',
        'description': 'Warm hoodie perfect for coding sessions.',
        'price': '\$59.99',
      },
      'product-3': {
        'name': 'Firebase Mug',
        'description': 'Keep your coffee hot while building apps.',
        'price': '\$19.99',
      },
      'demo-product': {
        'name': 'Demo Product',
        'description':
            'This is a demonstration product to show dynamic routing.',
        'price': '\$0.00',
      },
    };

    return products[productId] ??
        {
          'name': 'Unknown Product',
          'description': 'Product not found.',
          'price': '\$0.00',
        };
  }
}
