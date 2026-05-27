import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grub_monkeys/constants/app_colors.dart';
import 'package:grub_monkeys/widgets/bottom_navigation.dart';
import 'package:grub_monkeys/widgets/common_topbar.dart';
class CategoryData {
  final String name;
  final int itemCount;
  final String imageUrl;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;

  const CategoryData({
    required this.name,
    required this.itemCount,
    required this.imageUrl,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
  });
}

final List<CategoryData> _categoryList = [
  CategoryData(
    name: 'Sea Food',
    itemCount: 12,
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&q=80',
    icon: Icons.set_meal_outlined,
    iconBg: AppColors.iconSeafood,
    iconFg: AppColors.fgSeafood,
  ),
  CategoryData(
    name: 'Burgers',
    itemCount: 15,
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&q=80',
    icon: Icons.lunch_dining_outlined,
    iconBg: AppColors.iconBurger,
    iconFg: AppColors.fgBurger,
  ),
  CategoryData(
    name: 'Fresh Juices',
    itemCount: 10,
    imageUrl: 'https://images.unsplash.com/photo-1622597467836-f3e27a1d6e69?w=200&q=80',
    icon: Icons.local_bar_outlined,
    iconBg: AppColors.iconJuice,
    iconFg: AppColors.fgJuice,
  ),
  CategoryData(
    name: 'Pizzas',
    itemCount: 14,
    imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&q=80',
    icon: Icons.local_pizza_outlined,
    iconBg: AppColors.iconPizza,
    iconFg: AppColors.fgPizza,
  ),
  CategoryData(
    name: 'Desserts',
    itemCount: 9,
    imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=200&q=80',
    icon: Icons.cake_outlined,
    iconBg: AppColors.iconDessert,
    iconFg: AppColors.fgDessert,
  ),
  CategoryData(
    name: 'Chinese',
    itemCount: 11,
    imageUrl: 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=200&q=80',
    icon: Icons.ramen_dining_outlined,
    iconBg: AppColors.iconChinese,
    iconFg: AppColors.fgChinese,
  ),
  CategoryData(
    name: 'Sandwiches',
    itemCount: 8,
    imageUrl: 'https://images.unsplash.com/photo-1553909489-cd47e0ef937f?w=200&q=80',
    icon: Icons.fastfood_outlined,
    iconBg: AppColors.iconSandwich,
    iconFg: AppColors.fgSandwich,
  ),
  CategoryData(
    name: 'Beverages',
    itemCount: 7,
    imageUrl: 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=200&q=80',
    icon: Icons.local_drink_outlined,
    iconBg: AppColors.iconBeverage,
    iconFg: AppColors.fgBeverage,
  ),
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<CategoryData> get _filtered => _searchQuery.isEmpty
      ? _categoryList
      : _categoryList.where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CommonTopBar(
              title: 'Categories',
              subtitle: 'Manage your food categories/lists',
              action: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16, color: AppColors.white),
                label: const Text(
                  'Add Category',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    letterSpacing: 0.1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildCategoryList(),
                    const SizedBox(height: 16),
                    _buildInfoBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNav(currentIndex: 1),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: const InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(fontSize: 14, color: AppColors.textLight),
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.textLight, size: 22),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.tune_rounded, color: AppColors.textDark, size: 22),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    final items = _filtered;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: List.generate(items.length, (index) {
            final isLast = index == items.length - 1;
            return Column(
              children: [
                _CategoryRow(category: items[index]),
                if (!isLast)
                  const Divider(height: 1, thickness: 0.8, color: AppColors.divider, indent: 20, endIndent: 20),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.list_alt_rounded, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Manage Your Categories',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add, edit or delete categories to organize your food items better.',
                  style: TextStyle(fontSize: 12.5, color: AppColors.textMedium, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final CategoryData category;
  const _CategoryRow({required this.category});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              category.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: AppColors.border,
                child: const Icon(Icons.image_not_supported_outlined, color: AppColors.textLight),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: category.iconBg, shape: BoxShape.circle),
            child: Icon(category.icon, color: category.iconFg, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text('${category.itemCount} Items', style: const TextStyle(fontSize: 12.5, color: AppColors.textLight)),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionBtn(
                icon: Icons.edit_outlined,
                iconColor: AppColors.editBlue,
                borderColor: const Color(0xFFBDD4F0),
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _ActionBtn(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.deleteRed,
                borderColor: const Color(0xFFF2BBBB),
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _ActionBtn(
                icon: Icons.chevron_right_rounded,
                iconColor: AppColors.textMedium,
                borderColor: AppColors.border,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.iconColor, required this.borderColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }
}
