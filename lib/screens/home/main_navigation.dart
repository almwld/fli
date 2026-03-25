import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/screens/home/home_screen.dart';
import 'package:flex_yemen/screens/wallet/wallet_screen.dart';
import 'package:flex_yemen/screens/chat/chat_screen.dart';
import 'package:flex_yemen/screens/profile/profile_screen.dart';
import 'package:flex_yemen/screens/product/add_product_screen.dart';
import 'package:flex_yemen/screens/product/products_screen.dart';
import 'package:flex_yemen/screens/home/map_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductsScreen(),
    const MapScreen(),
    const AddProductScreen(),
    const ChatScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.goldPrimary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'Changa'),
          unselectedLabelStyle: const TextStyle(fontSize: 10, fontFamily: 'Changa'),
          showUnselectedLabels: true,
          items: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'الرئيسية', 0),
            _buildNavItem(Icons.storefront_outlined, Icons.storefront, 'المتجر', 1),
            _buildNavItem(Icons.map_outlined, Icons.map, 'الخريطة', 2),
            _buildAddNavItem(),
            _buildNavItem(Icons.chat_bubble_outline, Icons.chat_bubble, 'الدردشة', 4),
            _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'المحفظة', 5),
            _buildNavItem(Icons.person_outline, Icons.person, 'حسابي', 6),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData unselectedIcon, IconData selectedIcon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(_currentIndex == index ? selectedIcon : unselectedIcon)
          .animate(target: _currentIndex == index ? 1 : 0)
          .scale(duration: 200.ms, curve: Curves.easeOut),
      label: label,
    );
  }

  BottomNavigationBarItem _buildAddNavItem() {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.goldPrimary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ).animate(target: _currentIndex == 3 ? 1 : 0).scale(duration: 200.ms).rotate(begin: 0, end: 0.25),
      label: 'إضافة',
    );
  }
}
