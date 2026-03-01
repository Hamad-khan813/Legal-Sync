import 'package:flutter/material.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read.'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
            child: const Text(
              'Mark all as read',
              style: TextStyle(color: Color(0xFF1E3A8A), fontSize: 12),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'TODAY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _NotificationTile(
            title: 'New Lawyer Registration',
            subtitle: 'Adv. Sameer Khan has requested verification.',
            time: '10:42 AM',
            icon: Icons.person_add,
            iconColor: const Color(0xFF059669),
            isUnread: true,
          ),
          _NotificationTile(
            title: 'System Alert',
            subtitle: 'Automated backup completed successfully.',
            time: '02:00 AM',
            icon: Icons.backup,
            iconColor: const Color(0xFF1E3A8A),
            isUnread: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'YESTERDAY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _NotificationTile(
            title: 'New Case Filed',
            subtitle: 'Case #LS-2026-905 requires assignment.',
            time: '04:15 PM',
            icon: Icons.folder,
            iconColor: const Color(0xFFE67E22),
            isUnread: false,
          ),
          _NotificationTile(
            title: 'User Report',
            subtitle: 'Client profile flagged for review.',
            time: '11:20 AM',
            icon: Icons.warning,
            iconColor: const Color(0xFFDC2626),
            isUnread: false,
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnread
              ? const Color(0xFF1E3A8A).withValues(alpha: 0.2)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.1),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            color: const Color(0xFF1F2937),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            if (isUnread) ...[
              const SizedBox(height: 4),
              const CircleAvatar(radius: 4, backgroundColor: Color(0xFFE67E22)),
            ],
          ],
        ),
      ),
    );
  }
}
