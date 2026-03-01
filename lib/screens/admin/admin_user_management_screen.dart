import 'package:flutter/material.dart';

class AdminUserManagementScreen extends StatelessWidget {
  const AdminUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showComingSoon(String feature) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$feature feature coming soon!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF1E3A8A),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'User Management',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1F2937)),
            onPressed: () => showComingSoon('Search'),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1F2937)),
            onPressed: () => showComingSoon('Filter Users'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Control Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Lawyers (247)',
                          style: TextStyle(
                            color: Color(0xFF1E3A8A),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Clients (3,892)',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () => showComingSoon('Result Filters'),
                  icon: const Icon(Icons.tune, size: 16, color: Colors.grey),
                  label: const Text(
                    'Filters',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const Text(
                  'SHOWING 247 RESULTS',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'USER INFORMATION',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ACTION',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // User List
          Expanded(
            child: ListView(
              children: [
                _UserRowItem(
                  name: 'Zubair Khan',
                  email: 'zubair.khan@legalsync.pk',
                  location: 'Lahore, High Court Bar',
                  status: 'ACTIVE',
                  statusColor: const Color(0xFF059669),
                ),
                _UserRowItem(
                  name: 'Sana Mirza',
                  email: 's.mirza@legals.pk.com',
                  location: 'Peshawar, District Court',
                  status: 'SUSPENDED',
                  statusColor: const Color(0xFFDC2626),
                ),
                _UserRowItem(
                  name: 'Ahmed Ali',
                  email: 'ahmed.ali@legalsync.pk',
                  location: 'Islamabad, Supreme Court',
                  status: 'ACTIVE',
                  statusColor: const Color(0xFF059669),
                ),
                _UserRowItem(
                  name: 'Fatima Jinnah',
                  email: 'fatima.j@outlook.com',
                  location: 'Karachi, High Court',
                  status: 'ACTIVE',
                  statusColor: const Color(0xFF059669),
                ),
                _UserRowItem(
                  name: 'Omar Farooq',
                  email: 'omar.f@legalsync.pk',
                  location: 'Rawalpindi, Sessions Court',
                  status: 'ACTIVE',
                  statusColor: const Color(0xFF059669),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showComingSoon('Add User'),
        backgroundColor: const Color(0xFF1E3A8A),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

class _UserRowItem extends StatelessWidget {
  final String name;
  final String email;
  final String location;
  final String status;
  final Color statusColor;

  const _UserRowItem({
    required this.name,
    required this.email,
    required this.location,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.only(bottom: 1),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
            child: const Icon(Icons.person, color: Color(0xFF1E3A8A)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User Options coming soon!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
