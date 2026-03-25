'''import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'حسابي'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Profile Header
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.goldPrimary, AppColors.goldDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://picsum.photos/seed/profile/200/200'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Text('محمد اليماني', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('m.yamani@example.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            // 2. Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('إعلاناتي', '12'),
                _buildStatItem('المتابعون', '450'),
                _buildStatItem('المتابعون', '120'),
              ],
            ),
            const SizedBox(height: 30),

            // 3. Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildOptionItem(Icons.person_outline, 'معلومات الحساب', () {}),
                  _buildOptionItem(Icons.favorite_border, 'المفضلة', () {}),
                  _buildOptionItem(Icons.shopping_bag_outlined, 'طلباتي', () {}),
                  _buildOptionItem(Icons.account_balance_wallet_outlined, 'محفظتي', () {}),
                  _buildOptionItem(Icons.notifications_none, 'الإشعارات', () {}),
                  _buildOptionItem(Icons.language, 'اللغة', () {}),
                  _buildOptionItem(Icons.security, 'الأمان والخصوصية', () {}),
                  _buildOptionItem(Icons.help_outline, 'المساعدة والدعم', () {}),
                  const Divider(height: 40),
                  _buildOptionItem(Icons.logout, 'تسجيل الخروج', () {}, isDestructive: true),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.goldPrimary)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.goldPrimary),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : Colors.black, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      contentPadding: EdgeInsets.zero,
    );
  }
}
'''
