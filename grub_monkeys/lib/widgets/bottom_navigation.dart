import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/analytics.dart';
import '../screens/dashboard.dart';
import '../screens/categories.dart';
import '../screens/profile.dart';

class CommonBottomNav extends StatelessWidget {
  final int currentIndex;
  const CommonBottomNav({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final tabs = [
      _NavItem(icon: Icons.room_service_outlined, label: 'Items', screen: const DashboardScreen()),
      _NavItem(icon: Icons.widgets_outlined, label: 'Categories', screen: const CategoriesScreen()),
      _NavItem(icon: Icons.bar_chart_rounded, label: 'Reports', screen: const ReportsScreen()),
      _NavItem(icon: Icons.person_rounded, label: 'Profile', screen: const AdminProfileScreen()),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (i) {
          final active = i == currentIndex;
          return GestureDetector(
            onTap: () {
              if (i == currentIndex) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => tabs[i].screen));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(tabs[i].icon, size: 26, color: active ? AppColors.primary : AppColors.textLight),
                  const SizedBox(height: 4),
                  Text(
                    tabs[i].label,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      color: active ? AppColors.primary : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final Widget screen;
  _NavItem({required this.icon, required this.label, required this.screen});
}
