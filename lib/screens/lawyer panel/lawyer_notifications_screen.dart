import 'package:flutter/material.dart';

class LawyerNotificationsScreen extends StatefulWidget {
  const LawyerNotificationsScreen({super.key});

  @override
  State<LawyerNotificationsScreen> createState() =>
      _LawyerNotificationsScreenState();
}

class _LawyerNotificationsScreenState extends State<LawyerNotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Urgent Deadline Approaching',
      'message':
          'Final brief submission required for Case #4492 - Smith v. Jones by 5:00 PM today.',
      'time': '10:45 AM',
      'type': 'URGENT',
      'read': false,
      'icon': Icons.priority_high,
      'color': Colors.red,
    },
    {
      'title': 'New Evidence Uploaded',
      'message': 'Medical records received for Miller Portfolio. PDF (4.2 MB).',
      'time': '9:20 AM',
      'type': 'LITIGATION',
      'read': true,
      'icon': Icons.description_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Message from Client',
      'message':
          'Robert Brown: "Could you please confirm the court date for next month?"',
      'time': 'Yesterday',
      'type': 'MESSAGE',
      'read': true,
      'icon': Icons.chat_bubble_outline,
      'color': Colors.green,
    },
    {
      'title': 'Calendar Update',
      'message':
          'The deposition for Case #5521 has been rescheduled to Friday at 2:00 PM.',
      'time': 'Yesterday',
      'type': 'CALENDAR',
      'read': true,
      'icon': Icons.calendar_today_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Retainer Replenished',
      'message': 'Invoice #882 has been paid in full by LexCorp Industries.',
      'time': 'Oct 24',
      'type': 'PAYMENT',
      'read': true,
      'icon': Icons.monetization_on_outlined,
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: Color(0xFFFF6B00)),
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n['read'] = true;
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          _buildSectionHeader('TODAY'),
          ..._notifications
              .where(
                (n) => n['time'].contains('AM') || n['time'].contains('PM'),
              )
              .map((n) => _buildNotificationCard(n)),
          const SizedBox(height: 10),
          _buildSectionHeader('YESTERDAY'),
          ..._notifications
              .where((n) => n['time'] == 'Yesterday')
              .map((n) => _buildNotificationCard(n)),
          const SizedBox(height: 10),
          _buildSectionHeader('EARLIER'),
          ..._notifications
              .where(
                (n) =>
                    n['time'] != 'Yesterday' &&
                    !n['time'].contains('AM') &&
                    !n['time'].contains('PM'),
              )
              .map((n) => _buildNotificationCard(n)),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.grey.shade400,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'No older notifications',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> n) {
    bool isUrgent = n['type'] == 'URGENT';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5), // Replaced withOpacity(0.02)
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: n['color'].withAlpha(25), // Replaced withOpacity(0.1)
                  shape: BoxShape.circle,
                ),
                child: Icon(n['icon'], color: n['color'], size: 22),
              ),
              if (!n['read'])
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B00),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      n['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: n['read'] ? Colors.black87 : Colors.black,
                      ),
                    ),
                    Text(
                      n['time'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  n['message'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (isUrgent) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'URGENT',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        n['type'],
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right, color: Colors.grey.shade300, size: 20),
        ],
      ),
    );
  }
}
