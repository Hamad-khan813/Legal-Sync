import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Unread', 'Important'];

  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      icon: Icons.gavel_rounded,
      iconBgColor: const Color(0xFFFF6B00),
      title: 'Hearing Reminder',
      description:
          'Case #4421: Miller vs. State. Your hearing starts in 2 hours at Department 12. Please arrive 15 mins early.',
      time: '10m ago',
      section: 'TODAY',
      isRead: false,
      isImportant: true,
    ),
    _NotificationItem(
      icon: Icons.chat_bubble_outline,
      iconBgColor: const Color(0xFF3B82F6),
      title: 'New Message from Sarah Jenkins',
      description:
          '"I\'ve uploaded the revised settlement agreement for your review..."',
      time: '45m ago',
      section: 'TODAY',
      isRead: false,
      isImportant: false,
    ),
    _NotificationItem(
      icon: Icons.description_outlined,
      iconBgColor: const Color(0xFF10B981),
      title: 'Document Verified',
      description:
          'The \'NDA_Final_V2.pdf\' has been successfully verified by our legal team.',
      time: 'Yesterday, 4:20 PM',
      section: 'YESTERDAY',
      isRead: false,
      isImportant: false,
    ),
    _NotificationItem(
      icon: Icons.receipt_long_outlined,
      iconBgColor: const Color(0xFFFF6B00),
      title: 'Invoice Generated',
      description:
          'Monthly retainer invoice for October services is now available.',
      time: 'Yesterday, 11:05 AM',
      section: 'YESTERDAY',
      isRead: true,
      isImportant: false,
    ),
    _NotificationItem(
      icon: Icons.history,
      iconBgColor: const Color(0xFF6B7280),
      title: 'Status Update: Case #3920',
      description:
          'Status changed from \'In Progress\' to \'Awaiting Court Date\'.',
      time: 'Oct 24, 2023',
      section: 'YESTERDAY',
      isRead: true,
      isImportant: true,
    ),
  ];

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification dismissed'),
        backgroundColor: const Color(0xFF111827),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<_NotificationItem> get _filteredNotifications {
    if (_selectedTabIndex == 1) {
      return _notifications.where((n) => !n.isRead).toList();
    } else if (_selectedTabIndex == 2) {
      return _notifications.where((n) => n.isImportant).toList();
    }
    return _notifications;
  }

  @override
  Widget build(BuildContext context) {
    // Group notifications by section
    final Map<String, List<MapEntry<int, _NotificationItem>>> grouped = {};
    final filtered = _filteredNotifications;
    for (int i = 0; i < filtered.length; i++) {
      final section = filtered[i].section;
      grouped.putIfAbsent(section, () => []);
      grouped[section]!.add(MapEntry(i, filtered[i]));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF111827),
                        size: 16,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var n in _notifications) {
                          n.isRead = true;
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: const Icon(
                        Icons.done_all,
                        color: Color(0xFFFF6B00),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTabIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTabIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFF6B00)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFFF6B00)
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF4B5563),
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Notification List
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        for (final section in grouped.keys) ...[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 12,
                              left: 4,
                            ),
                            child: Text(
                              section,
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          for (final entry in grouped[section]!)
                            _buildNotificationCard(entry.key, entry.value),
                        ],
                        const SizedBox(height: 30),
                        _buildEndMessage(),
                        const SizedBox(height: 30),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(int index, _NotificationItem notification) {
    return Dismissible(
      key: ValueKey('notification_${index}_${notification.title}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removeNotification(index),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 24),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead
                ? const Color(0xFFE5E7EB)
                : const Color(0xFFFF6B00).withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: notification.iconBgColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                notification.icon,
                color: notification.iconBgColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            color: const Color(0xFF111827),
                            fontSize: 15,
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B00),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.description,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xFF9CA3AF),
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        notification.time,
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEndMessage() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.schedule, color: const Color(0xFFD1D5DB), size: 40),
          const SizedBox(height: 10),
          const Text(
            'No more notifications for the last 30 days',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            color: const Color(0xFFD1D5DB),
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'No notifications yet',
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'You\'re all caught up!',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;
  final String time;
  final String section;
  bool isRead;
  final bool isImportant;

  _NotificationItem({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
    required this.time,
    required this.section,
    this.isRead = false,
    this.isImportant = false,
  });
}
