import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/product_provider.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';
import 'package:flex_yemen/widgets/cards/product_card.dart';
import 'package:flex_yemen/screens/other/garden_screen.dart';
import 'package:flex_yemen/screens/product/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'FLEX YEMEN'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Slider Section
              _buildSlider(),

              // 2. Garden Entry (New Feature)
              _buildGardenEntry(context),

              // 3. Categories Grid
              _buildCategoryGrid(),

              // 4. Featured Section (Auction)
              _buildFeaturedSection('مزاد الجنابي الأسبوعي'),

              // 5. Real Estate Section
              _buildRealEstateSection(),

              // 6. Tech Section
              _buildTechSection(),

              // 7. Recommended Products (130+ products)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'منتجات مقترحة لك',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                    ),
                    child: ProductCard(product: product)
                        .animate()
                        .fadeIn(duration: 500.ms, delay: (index % 10 * 50).ms)
                        .slideY(begin: 0.1, end: 0),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/seed/banner$i/800/400'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        'عرض ترويجي $i',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildGardenEntry(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GardenScreen())),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.green, Colors.teal]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: const Row(
          children: [
            Icon(Icons.local_florist, color: Colors.white, size: 40),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('حديقة فلكس (Flex Garden)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('ازرع نقاطك واحصد خصومات مذهلة!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ).animate().shimmer(delay: 2.seconds, duration: 2.seconds),
    );
  }

  Widget _buildCategoryGrid() {
    final categories = [
      {'name': 'عقارات', 'icon': Icons.home},
      {'name': 'سيارات', 'icon': Icons.directions_car},
      {'name': 'إلكترونيات', 'icon': Icons.laptop},
      {'name': 'أزياء', 'icon': Icons.checkroom},
      {'name': 'خدمات', 'icon': Icons.build},
    ];

    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.goldPrimary.withOpacity(0.1),
                  child: Icon(categories[index]['icon'] as IconData, color: AppColors.goldPrimary),
                ),
                const SizedBox(height: 5),
                Text(categories[index]['name'] as String, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network('https://picsum.photos/seed/featured$index/200/200', fit: BoxFit.cover),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('جنابي يمنية فاخرة', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRealEstateSection() {
    final types = ['شقق', 'فلل', 'أراضي', 'محلات', 'مكاتب'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('العقارات والاستثمارات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: types.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 10),
                child: ActionChip(
                  label: Text(types[index]),
                  onPressed: () {},
                  backgroundColor: AppColors.goldPrimary.withOpacity(0.1),
                  labelStyle: const TextStyle(color: AppColors.goldPrimary),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTechSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('عالم الإلكترونيات والتقنية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTechIcon(Icons.phone_iphone, 'هواتف'),
            _buildTechIcon(Icons.laptop, 'لابتوب'),
            _buildTechIcon(Icons.satellite_alt, 'ستارلينك'),
            _buildTechIcon(Icons.camera_alt, 'كاميرات'),
          ],
        ),
      ],
    );
  }

  Widget _buildTechIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
          ),
          child: Icon(icon, color: AppColors.goldPrimary),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
