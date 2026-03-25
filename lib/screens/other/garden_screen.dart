import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  int _points = 1250;
  int _streak = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'حديقة فلكس (Flex Garden)'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Garden Header (Points & Streak)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeaderStat(Icons.stars, 'نقاطي', '$_points'),
                      _buildHeaderStat(Icons.local_fire_department, 'سلسلة', '$_streak أيام'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ازرع، شارك، واربح!',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5, end: 0),
                  const Text(
                    'حول نقاطك إلى خصومات حقيقية',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 2. Daily Tasks
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('مهام اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildTaskCard('سجل دخولك اليوم', '+10 نقاط', true),
                  _buildTaskCard('شارك منتجاً مع صديق', '+25 نقطة', false),
                  _buildTaskCard('أضف تقييماً لمنتج اشتريته', '+50 نقطة', false),
                  _buildTaskCard('دعوة صديق للتطبيق', '+200 نقطة', false),
                ],
              ),
            ),

            // 3. Mini Games / Interactive Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('ألعاب وفعاليات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildGameCard('عجلة الحظ', Icons.settings_backup_restore, Colors.orange),
                  _buildGameCard('خمن السعر', Icons.monetization_on, Colors.blue),
                  _buildGameCard('الكنز اليمني', Icons.explore, Colors.purple),
                ],
              ),
            ),

            // 4. Rewards Store
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('متجر الجوائز', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final rewards = [
                        {'name': 'كوبون 5000 ر.ي', 'cost': '1000 نقطة'},
                        {'name': 'توصيل مجاني', 'cost': '500 نقطة'},
                        {'name': 'خصم 10%', 'cost': '800 نقطة'},
                        {'name': 'باقة إنترنت 1GB', 'cost': '1200 نقطة'},
                      ];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(rewards[index]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Text(rewards[index]['cost']!, style: const TextStyle(color: Colors.green, fontSize: 12)),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: const Size(80, 30),
                              ),
                              child: const Text('استبدال', style: TextStyle(fontSize: 10)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTaskCard(String title, String reward, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, decoration: isDone ? TextDecoration.lineThrough : null)),
                Text(reward, style: const TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
          if (!isDone)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.goldPrimary, foregroundColor: Colors.white),
              child: const Text('انطلق'),
            ),
        ],
      ),
    );
  }

  Widget _buildGameCard(String name, IconData icon, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
