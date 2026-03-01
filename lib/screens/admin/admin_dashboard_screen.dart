import 'package:flutter/material.dart';
import 'admin_analytics_screen.dart';
import 'admin_verification_list_screen.dart';
import 'admin_user_management_screen.dart';
import 'admin_settings_screen.dart';
import 'admin_cases_screen.dart';
import 'admin_notifications_screen.dart';
import 'admin_profile_screen.dart';
import 'admin_lawyers_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light theme for admin
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.gavel,
                color: Color(0xFF1E3A8A),
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LegalSync',
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'ADMIN PORTAL',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Stack(
              children: [
                Icon(Icons.notifications_none, color: Color(0xFF1F2937)),
                Positioned(
                  right: 2,
                  top: 4,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFFE67E22),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminNotificationsScreen(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminProfileScreen()),
                );
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF1E3A8A),
                child: Icon(Icons.person, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search lawyers, cases or clients...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Stats Grid
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.05,
                      children: [
                        _StatCard(
                          title: 'Total Lawyers',
                          value: 247,
                          icon: Icons.business_center,
                          color: const Color(0xFF1E3A8A),
                          showReviewBtn: true,
                          onReviewTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminLawyersScreen(),
                            ),
                          ),
                        ),
                        _StatCard(
                          title: 'Active Cases',
                          value: 1453,
                          icon: Icons.folder,
                          color: const Color(0xFF059669),
                          showReviewBtn: true,
                          onReviewTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminCasesScreen(),
                            ),
                          ),
                        ),
                        _StatCard(
                          title: 'Pending Verifications',
                          value: 23,
                          icon: Icons.verified_user,
                          color: const Color(0xFFE67E22),
                          showReviewBtn: true,
                          onReviewTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AdminVerificationListScreen(),
                            ),
                          ),
                        ),
                        _StatCard(
                          title: 'Total Clients',
                          value: 3892,
                          icon: Icons.people,
                          color: const Color(0xFF7C3AED),
                          showReviewBtn: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Quick Actions
                    const Text(
                      'QUICK ACTIONS',
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _QuickActionItem(
                            title: 'Add Lawyer',
                            icon: Icons.person_add,
                            bgColor: const Color(0xFF1E3A8A),
                            onTap: () => _showComingSoon('Add Lawyer'),
                          ),
                          _QuickActionItem(
                            title: 'Reports',
                            icon: Icons.insert_chart,
                            bgColor: const Color(0xFFE67E22),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminAnalyticsScreen(),
                              ),
                            ),
                          ),
                          _QuickActionItem(
                            title: 'Verify Bar',
                            icon: Icons.verified,
                            bgColor: const Color(0xFF059669),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AdminVerificationListScreen(),
                              ),
                            ),
                          ),
                          _QuickActionItem(
                            title: 'Support',
                            icon: Icons.support_agent,
                            bgColor: const Color(0xFF7C3AED),
                            onTap: () => _showComingSoon('Support Center'),
                          ),
                          _QuickActionItem(
                            title: 'System',
                            icon: Icons.settings,
                            bgColor: const Color(0xFF4B5563),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminSettingsScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Recent Activity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'RECENT ACTIVITY',
                          style: TextStyle(
                            color: Color(0xFF4B5563),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _showComingSoon('Recent Activity'),
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _ActivityItem(
                      icon: Icons.person,
                      iconBg: const Color(0xFF1E3A8A),
                      title: 'Adv. Ahmed Khan',
                      description: 'registered from Lahore High Court.',
                      time: '2 minutes ago',
                    ),
                    _ActivityItem(
                      icon: Icons.check_circle,
                      iconBg: const Color(0xFF059669),
                      title: 'Verification Approved',
                      description: 'for Adv. Sarah Malik.',
                      time: '15 minutes ago',
                    ),
                    _ActivityItem(
                      icon: Icons.post_add,
                      iconBg: const Color(0xFFE67E22),
                      title: 'Fatima Jinnah',
                      description: 'posted a new Corporate Law case.',
                      time: '1 hour ago',
                    ),
                    const SizedBox(height: 32),

                    // Chart Placeholder
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'REGISTRATION TRENDS',
                                style: TextStyle(
                                  color: Color(0xFF4B5563),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF059669,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  '+12% this week',
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Mock Bar chart
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _ChartBar(height: 40, label: 'Mon'),
                              _ChartBar(height: 70, label: 'Tue'),
                              _ChartBar(height: 50, label: 'Wed'),
                              _ChartBar(height: 90, label: 'Thu'),
                              _ChartBar(height: 60, label: 'Fri'),
                              _ChartBar(height: 30, label: 'Sat'),
                              _ChartBar(height: 45, label: 'Sun'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: const Color(0xFF9CA3AF),
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        backgroundColor: Colors.white,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Cases'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminUserManagementScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminCasesScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminSettingsScreen()),
            );
          }
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;
  final bool showReviewBtn;
  final VoidCallback? onReviewTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.showReviewBtn,
    this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onReviewTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title details coming soon!'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF1E3A8A),
              ),
            );
          },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
              ],
            ),
            const Spacer(),
            // Count up animation
            TweenAnimationBuilder(
              tween: IntTween(begin: 0, end: value),
              duration: const Duration(seconds: 1),
              builder: (context, int val, child) {
                return Text(
                  formatNumber(val),
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11),
            ),
            if (showReviewBtn) ...[
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 24,
                child: ElevatedButton(
                  onPressed: onReviewTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'REVIEW NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String formatNumber(int n) {
    return n.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String description;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBg, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4B5563),
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: '$title ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      TextSpan(text: description),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final double height;
  final String label;

  const _ChartBar({required this.height, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: height),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutBack,
            builder: (context, double val, child) {
              return Container(
                width: 24,
                height: val,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 10),
        ),
      ],
    );
  }
}
