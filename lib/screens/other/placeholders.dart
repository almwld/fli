import 'package:flutter/material.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'المتجر'), body: const Center(child: Text('شاشة المتجر قيد التطوير')));
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'الخريطة'), body: const Center(child: Text('شاشة الخريطة قيد التطوير')));
}

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'إضافة منتج'), body: const Center(child: Text('شاشة إضافة منتج قيد التطوير')));
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'الدردشة'), body: const Center(child: Text('شاشة الدردشة قيد التطوير')));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'حسابي'), body: const Center(child: Text('شاشة حسابي قيد التطوير')));
}
