import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : null),
      title: Text(label, style: TextStyle(color: isDestructive ? Colors.red : null)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'حسابي'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
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
                const Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://picsum.photos/seed/profile/200/200'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Text('محمد اليماني', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('m.yamani@example.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('إعلاناتي', '12'),
                _buildStatItem('المتابعون', '450'),
                _buildStatItem('المتابَعون', '120'),
              ],
            ),
            const SizedBox(height: 30),
            // Options
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
}
