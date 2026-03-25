import 'package:flutter/material.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: const CustomAppBar(title: 'الخريطة'), body: const Center(child: Text('شاشة الخريطة قيد التطوير')));
}
