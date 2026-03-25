import 'package:flutter/material.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'المتجر'), body: const Center(child: Text('شاشة المتجر قيد التطوير')));
}
