import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grub_monkeys/widgets/bottom_navigation.dart';

class AppColors {
  static const primary = Color(0xFFF47C2E);
  static const primaryLight = Color(0xFFFFF0E6);
  static const primaryBorder = Color(0xFFF9C49E);
  static const background = Color(0xFFF8F8F8);
  static const white = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF1A1A1A);
  static const textMedium = Color(0xFF555555);
  static const textLight = Color(0xFF9E9E9E);
  static const border = Color(0xFFEEEEEE);
  static const divider = Color(0xFFF2F2F2);
  static const cardShadow = Color(0x0A000000);
  static const activeGreenBg = Color(0xFFE8F8EE);
  static const activeGreenTxt = Color(0xFF2EAA5E);
  static const logoutRed = Color(0xFFE05252);
  static const logoutRedLight = Color(0xFFFFF0F0);
}

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});
  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
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
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildRestaurantCard(),
                    const SizedBox(height: 16),
                    _buildAccountDetailsCard(),
                    const SizedBox(height: 16),
                    _buildOtherSettingsCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNav(currentIndex: 3),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              child: const Icon(Icons.chevron_left_rounded, size: 28, color: AppColors.textDark),
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Profile',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Manage your restaurant & account details',
                style: TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard() {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          _SectionHeader(title: 'Restaurant Details', onEdit: () {}),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300&q=80',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 120,
                        height: 120,
                        color: AppColors.border,
                        child: const Icon(Icons.storefront_outlined, color: AppColors.textLight, size: 36),
                      ),
                    ),
                  ),
                  // Camera icon badge
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.camera_alt_outlined, size: 16, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),

              // Restaurant info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tasty Bite Restaurant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Active badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.activeGreenBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.activeGreenTxt),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(icon: Icons.location_on_outlined, text: '123 Food Street, New York, NY 10001, USA'),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.phone_outlined, text: '+1 987 654 3210'),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.mail_outline_rounded, text: 'info@tastybite.com'),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.language_outlined, text: 'www.tastybite.com'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    final accountItems = [
      _AccountItem(icon: Icons.person_outline_rounded, label: 'Admin Name', value: 'John Doe'),
      _AccountItem(icon: Icons.mail_outline_rounded, label: 'Email Address', value: 'john.doe@tastybite.com'),
      _AccountItem(icon: Icons.phone_outlined, label: 'Phone Number', value: '+1 987 654 3210'),
      _AccountItem(icon: Icons.lock_outline_rounded, label: 'Password', value: '••••••••', isPassword: true),
    ];
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: 'Account Details', onEdit: () {}),
          const SizedBox(height: 8),
          ...List.generate(accountItems.length, (i) {
            final item = accountItems[i];
            final isLast = i == accountItems.length - 1;
            return Column(
              children: [
                _AccountRow(item: item),
                if (!isLast) const Divider(height: 1, thickness: 0.8, color: AppColors.divider),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOtherSettingsCard() {
    final settingsItems = [
      _SettingItem(icon: Icons.notifications_outlined, label: 'Notification Settings', isLogout: false),
      _SettingItem(icon: Icons.shield_outlined, label: 'Privacy Policy', isLogout: false),
      _SettingItem(icon: Icons.description_outlined, label: 'Terms & Conditions', isLogout: false),
      _SettingItem(icon: Icons.help_outline_rounded, label: 'Help & Support', isLogout: false),
      _SettingItem(icon: Icons.logout_rounded, label: 'Logout', isLogout: true),
    ];
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Other Settings',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
          ),
          ...List.generate(settingsItems.length, (i) {
            final item = settingsItems[i];
            final isLast = i == settingsItems.length - 1;
            return Column(
              children: [
                _SettingRow(item: item),
                if (!isLast) const Divider(height: 1, thickness: 0.8, color: AppColors.divider),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;
  const _SectionHeader({required this.title, required this.onEdit});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryBorder, width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit_outlined, size: 15, color: AppColors.primary),
                SizedBox(width: 5),
                Text(
                  'Edit',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: AppColors.textLight),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4)),
        ),
      ],
    );
  }
}

class _AccountItem {
  final IconData icon;
  final String label;
  final String value;
  final bool isPassword;
  const _AccountItem({required this.icon, required this.label, required this.value, this.isPassword = false});
}

class _AccountRow extends StatelessWidget {
  final _AccountItem item;
  const _AccountRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
            child: Icon(item.icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          // Label + value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textDark),
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  style: TextStyle(fontSize: 13, color: AppColors.textLight, letterSpacing: item.isPassword ? 2.0 : 0),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 22, color: AppColors.textLight),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String label;
  final bool isLogout;
  const _SettingItem({required this.icon, required this.label, required this.isLogout});
}

class _SettingRow extends StatelessWidget {
  final _SettingItem item;
  const _SettingRow({required this.item});
  @override
  Widget build(BuildContext context) {
    final iconBg = item.isLogout ? AppColors.logoutRedLight : AppColors.primaryLight;
    final iconColor = item.isLogout ? AppColors.logoutRed : AppColors.primary;
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(item.icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 14),
            // Label
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 22, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}
