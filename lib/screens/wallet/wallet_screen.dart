import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';
import 'package:flex_yemen/screens/wallet/wallet_services.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'name': 'إيداع', 'icon': Icons.add_circle_outline},
      {'name': 'تحويل', 'icon': Icons.swap_horiz},
      {'name': 'سحب', 'icon': Icons.remove_circle_outline},
      {'name': 'دفع فواتير', 'icon': Icons.receipt_long},
      {'name': 'خدمات ترفيه', 'icon': Icons.tv},
      {'name': 'ألعاب', 'icon': Icons.videogame_asset},
      {'name': 'تطبيقات', 'icon': Icons.apps},
      {'name': 'بطائق نت', 'icon': Icons.wifi_tethering},
      {'name': 'أمازون', 'icon': Icons.shopping_bag},
      {'name': 'بنوك ومحافظ', 'icon': Icons.account_balance},
      {'name': 'تحويلات مالية', 'icon': Icons.money},
      {'name': 'مدفوعات حكومية', 'icon': Icons.account_balance_wallet},
      {'name': 'فلكسي', 'icon': Icons.bolt},
      {'name': 'سحب نقدي', 'icon': Icons.atm},
      {'name': 'تعليم عالي', 'icon': Icons.school},
      {'name': 'الشحن والسداد', 'icon': Icons.local_shipping},
      {'name': 'شحن الرصيد', 'icon': Icons.phone_android},
      {'name': 'سداد باقات', 'icon': Icons.inventory_2},
      {'name': 'إنترنت وهاتف', 'icon': Icons.router},
      {'name': 'استلام حوالة', 'icon': Icons.call_received},
      {'name': 'العمليات', 'icon': Icons.history},
      {'name': 'طلب حوالة', 'icon': Icons.send_and_archive},
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'المحفظة الإلكترونية'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Cards
            SizedBox(
              height: 180,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: [
                  _buildBalanceCard('الريال اليمني', '1,250,000', Colors.orange),
                  _buildBalanceCard('الريال السعودي', '5,400', Colors.green),
                  _buildBalanceCard('الدولار الأمريكي', '1,200', Colors.blue),
                ],
              ),
            ),

            // Services Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WalletServiceFactory.getServiceScreen(services[index]['name'] as String),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(services[index]['icon'] as IconData, color: AppColors.goldPrimary),
                          const SizedBox(height: 5),
                          Text(
                            services[index]['name'] as String,
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Recent Transactions
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('آخر العمليات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: index % 2 == 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    child: Icon(index % 2 == 0 ? Icons.arrow_downward : Icons.arrow_upward, color: index % 2 == 0 ? Colors.green : Colors.red),
                  ),
                  title: Text(index % 2 == 0 ? 'إيداع نقدي' : 'سداد فاتورة'),
                  subtitle: const Text('2024-05-20 10:30 ص'),
                  trailing: Text(
                    '${index % 2 == 0 ? "+" : "-"}${index * 5000 + 1000} ر.ي',
                    style: TextStyle(color: index % 2 == 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String currency, String amount, Color color) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldPrimary, AppColors.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.goldPrimary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currency, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              amount,
              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
