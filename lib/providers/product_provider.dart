import 'package:flutter/material.dart';
import 'package:flex_yemen/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  ProductProvider() {
    _generateMockProducts();
  }

  List<Product> get products => _products;

  void _generateMockProducts() {
    for (int i = 1; i <= 135; i++) {
      _products.add(
        Product(
          id: i.toString(),
          name: 'منتج يمني رقم $i',
          description: 'هذا وصف تجريبي لمنتج Flex Yemen رقم $i. يتميز هذا المنتج بجودة عالية وتصميم فريد يناسب السوق اليمني.',
          price: (i * 1500).toDouble(),
          imageUrl: 'https://picsum.photos/seed/$i/400/400',
          category: _getCategory(i),
          rating: (3 + (i % 3)).toDouble(),
          location: 'صنعاء، اليمن',
          isFavorite: i % 5 == 0,
        ),
      );
    }
  }

  String _getCategory(int index) {
    if (index % 5 == 0) return 'إلكترونيات';
    if (index % 5 == 1) return 'عقارات';
    if (index % 5 == 2) return 'أزياء';
    if (index % 5 == 3) return 'سيارات';
    return 'خدمات';
  }
}
