import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'case_status_screen.dart';
import 'messages_screen.dart';
import 'legal_categories_screen.dart';
import 'login_screen.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  int _currentIndex = 4;
  bool _twoFactorAuth = true;
  bool _caseNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Balance the row
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Profile Section
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFF6B00),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage('images/profile.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B00),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF0F0F0F),
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Alexander Sterling',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'a.sterling@example.com',
                      style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // CASE & ACCOUNT
                    _buildSectionHeader('CASE & ACCOUNT'),
                    const SizedBox(height: 12),
                    _SettingRow(
                      icon: Icons.notifications_active_outlined,
                      iconBgColor: const Color(0xFF2563EB),
                      title: 'Case Notifications',
                      subtitle: 'Alerts for case updates and hearings',
                      trailing: Switch(
                        value: _caseNotifications,
                        onChanged: (val) =>
                            setState(() => _caseNotifications = val),
                        activeThumbColor: const Color(0xFFFF6B00),
                        activeTrackColor: const Color(
                          0xFFFF6B00,
                        ).withValues(alpha: 0.3),
                        inactiveThumbColor: const Color(0xFF9E9E9E),
                        inactiveTrackColor: const Color(0xFF2A2A2A),
                      ),
                    ),
                    _SettingRow(
                      icon: Icons.description_outlined,
                      iconBgColor: const Color(0xFFFF6B00),
                      title: 'Legal Documents',
                      subtitle: 'Manage your shared files and e-signs',
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),

                    // BILLING & PAYMENTS
                    _buildSectionHeader('BILLING & PAYMENTS'),
                    const SizedBox(height: 12),
                    _SettingRow(
                      icon: Icons.credit_card_outlined,
                      iconBgColor: const Color(0xFF7C3AED),
                      title: 'Payment Methods',
                      subtitle: 'Visa ending in **** 4242',
                      onTap: () {},
                    ),
                    _SettingRow(
                      icon: Icons.receipt_long_outlined,
                      iconBgColor: const Color(0xFF0891B2),
                      title: 'Billing History',
                      subtitle: 'View and download past invoices',
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),

                    // SECURITY
                    _buildSectionHeader('SECURITY'),
                    const SizedBox(height: 12),
                    _SettingRow(
                      icon: Icons.lock_outline,
                      iconBgColor: const Color(0xFFDC2626),
                      title: 'Change Password',
                      subtitle: 'Last updated 3 months ago',
                      onTap: () {},
                    ),
                    _SettingRow(
                      icon: Icons.security_outlined,
                      iconBgColor: const Color(0xFF059669),
                      title: 'Two-Factor Auth',
                      subtitle: 'Add extra security to your account',
                      trailing: Switch(
                        value: _twoFactorAuth,
                        onChanged: (val) =>
                            setState(() => _twoFactorAuth = val),
                        activeThumbColor: const Color(0xFFFF6B00),
                        activeTrackColor: const Color(
                          0xFFFF6B00,
                        ).withValues(alpha: 0.3),
                        inactiveThumbColor: const Color(0xFF9E9E9E),
                        inactiveTrackColor: const Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Log Out Button
                    GestureDetector(
                      onTap: () {
                        // Navigate to login screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(
                              0xFFFF6B00,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Color(0xFFFF6B00),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                color: Color(0xFFFF6B00),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF6B6B6B),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final items = [
      {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
      {
        'icon': Icons.balance_outlined,
        'activeIcon': Icons.balance,
        'label': 'Lawyer',
      },
      {
        'icon': Icons.folder_outlined,
        'activeIcon': Icons.folder,
        'label': 'Cases',
      },
      {
        'icon': Icons.chat_bubble_outline,
        'activeIcon': Icons.chat_bubble,
        'label': 'Chat',
      },
      {
        'icon': Icons.settings_outlined,
        'activeIcon': Icons.settings,
        'label': 'Setting',
      },
    ];
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF141414),
        border: Border(top: BorderSide(color: Color(0xFF1E1E1E), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = _currentIndex == index;
          return GestureDetector(
            onTap: () {
              if (isActive) return;
              final Widget destination = switch (index) {
                0 => const HomeScreen(),
                1 => const LegalCategoriesScreen(),
                2 => const CaseStatusScreen(),
                3 => const MessagesScreen(),
                _ => const AppSettingScreen(),
              };

              if (index == 0) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => destination),
                  (_) => false,
                );
                return;
              }

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => destination),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isActive
                      ? item['activeIcon'] as IconData
                      : item['icon'] as IconData,
                  color: isActive
                      ? const Color(0xFFFF6B00)
                      : const Color(0xFF5A5A5A),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFFFF6B00)
                        : const Color(0xFF5A5A5A),
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF252525)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconBgColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF4A4A4A),
                  size: 16,
                ),
          ],
        ),
      ),
    );
  }
}
