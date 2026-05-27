import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grub_monkeys/constants/app_colors.dart';
import 'package:grub_monkeys/widgets/bottom_navigation.dart';
import 'package:grub_monkeys/widgets/common_topbar.dart';

class FoodCategory {
  final String name;
  final int itemCount;
  final String imageUrl;
  const FoodCategory({required this.name, required this.itemCount, required this.imageUrl});
}

class FoodItem {
  final String name;
  final String description;
  final double price;
  final bool isActive;
  final String imageUrl;
  const FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.isActive,
    required this.imageUrl,
  });
}

final List<FoodCategory> _categories = [
  FoodCategory(
    name: 'Sea Food',
    itemCount: 12,
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&q=80',
  ),
  FoodCategory(
    name: 'Burgers',
    itemCount: 15,
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&q=80',
  ),
  FoodCategory(
    name: 'Fresh Juices',
    itemCount: 10,
    imageUrl: 'https://images.unsplash.com/photo-1622597467836-f3e27a1d6e69?w=200&q=80',
  ),
  FoodCategory(
    name: 'Pizzas',
    itemCount: 14,
    imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&q=80',
  ),
  FoodCategory(
    name: 'Desserts',
    itemCount: 9,
    imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=200&q=80',
  ),
];

final List<FoodItem> _seaFoodItems = [
  FoodItem(
    name: 'Grilled Salmon',
    description: 'Fresh salmon grilled with herbs and lemon butter sauce.',
    price: 18.99,
    isActive: true,
    imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=200&q=80',
  ),
  FoodItem(
    name: 'Fried Calamari',
    description: 'Crispy fried squid rings served with spicy aioli.',
    price: 12.99,
    isActive: true,
    imageUrl: 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=200&q=80',
  ),
  FoodItem(
    name: 'Garlic Butter Prawns',
    description: 'Prawns sautéed in garlic butter with herbs.',
    price: 16.99,
    isActive: true,
    imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=200&q=80',
  ),
  FoodItem(
    name: 'Fish & Chips',
    description: 'Crispy battered fish served with fries and tartar sauce.',
    price: 11.99,
    isActive: true,
    imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=200&q=80',
  ),
  FoodItem(
    name: 'Seafood Pasta',
    description: 'Pasta with mixed seafood in a creamy white sauce.',
    price: 14.99,
    isActive: true,
    imageUrl: 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=200&q=80',
  ),
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();
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
      body: SafeAreaView(
        child: Column(
          children: [
            CommonTopBar(title: 'Food Management', subtitle: 'Manage your food categories & items'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildCategoriesSection(),
                    const SizedBox(height: 16),
                    _buildSelectedCategoryBanner(),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildItemList(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNav(currentIndex: 0),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _buildCategoryCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(int index) {
    final category = _categories[index];
    final isSelected = index == _selectedCategoryIndex;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategoryIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 106,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 2.0 : 1.0),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                category.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 70,
                  height: 70,
                  color: AppColors.border,
                  child: const Icon(Icons.fastfood, color: AppColors.textLight),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text('${category.itemCount} Items', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
            // Selected orange underline indicator
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isSelected ? 28 : 0,
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedCategoryBanner() {
    final category = _categories[_selectedCategoryIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                category.imageUrl,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 52,
                  height: 52,
                  color: AppColors.border,
                  child: const Icon(Icons.fastfood, color: AppColors.textLight),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 3),
                  Text('${category.itemCount} Items', style: const TextStyle(fontSize: 13, color: AppColors.textLight)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 15, color: AppColors.white),
                  label: const Text(
                    'Add Item',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Add new item in this list', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
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
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  hintStyle: const TextStyle(fontSize: 14, color: AppColors.textLight),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textLight, size: 22),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
      ),
    );
  }

  Widget _buildItemList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _seaFoodItems.length,
          separatorBuilder: (_, _) =>
              const Divider(height: 1, thickness: 0.8, color: AppColors.border, indent: 20, endIndent: 20),
          itemBuilder: (context, index) {
            return _buildFoodItemRow(_seaFoodItems[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildFoodItemRow(FoodItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 72,
                height: 72,
                color: AppColors.border,
                child: const Icon(Icons.fastfood, color: AppColors.textLight),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                    letterSpacing: -0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 11.5, color: AppColors.textMedium, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Active badge
              if (item.isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.activeGreenBg, borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Active',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.activeGreenText),
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit button
                  _buildActionButton(
                    icon: Icons.edit_outlined,
                    iconColor: AppColors.editBlue,
                    borderColor: AppColors.editBlue,
                    onTap: () {},
                  ),
                  const SizedBox(width: 6),
                  // Delete button
                  _buildActionButton(
                    icon: Icons.delete_outline_rounded,
                    iconColor: AppColors.deleteRed,
                    borderColor: AppColors.deleteRed,
                    onTap: () {},
                  ),
                  const SizedBox(width: 6),
                  // Chevron button
                  _buildActionButton(
                    icon: Icons.chevron_right_rounded,
                    iconColor: AppColors.textMedium,
                    borderColor: AppColors.border,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor.withValues(alpha: 0.5), width: 1.2),
        ),
        child: Icon(icon, size: 17, color: iconColor),
      ),
    );
  }
}

class SafeAreaView extends StatelessWidget {
  final Widget child;
  const SafeAreaView({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
