import 'package:flutter/material.dart';
import 'admin_verification_detail_screen.dart';

class AdminVerificationListScreen extends StatelessWidget {
  const AdminVerificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Lawyer Verification',
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
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TabItem(title: 'All', count: '(247)', isSelected: true),
                _TabItem(
                  title: 'Pending',
                  count: '(23)',
                  color: const Color(0xFFE67E22),
                  isSelected: false,
                ),
                _TabItem(
                  title: 'Verified',
                  count: '(204)',
                  color: const Color(0xFF059669),
                  isSelected: false,
                ),
                _TabItem(
                  title: 'Rejected',
                  count: '(20)',
                  color: const Color(0xFFDC2626),
                  isSelected: false,
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, Bar ID or city',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  icon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _VerificationCard(
                  name: 'Adv. Muhammad Ali',
                  barId: 'PBC/2018/12345',
                  status: 'PENDING',
                  statusColor: const Color(0xFFE67E22),
                  tag: 'Civil Law',
                  location: 'Peshawar, KPK',
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminVerificationDetailScreen(
                          name: 'Adv. Muhammad Ali',
                        ),
                      ),
                    );
                  },
                ),
                _VerificationCard(
                  name: 'Adv. Fatima Sheikh',
                  barId: 'LHC/2015/05876',
                  status: 'VERIFIED',
                  statusColor: const Color(0xFF059669),
                  tag: 'Criminal Law',
                  location: 'Lahore, Punjab',
                  isVerified: true,
                ),
                _VerificationCard(
                  name: 'Adv. Ahmed Shah',
                  barId: 'KBC/2020/05443',
                  status: 'PENDING',
                  statusColor: const Color(0xFFE67E22),
                  tag: 'Corporate Law',
                  location: 'Karachi, Sindh',
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminVerificationDetailScreen(
                          name: 'Adv. Ahmed Shah',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final String count;
  final Color? color;
  final bool isSelected;

  const _TabItem({
    required this.title,
    required this.count,
    this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title ',
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF1E3A8A)
                    : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: count,
              style: TextStyle(
                color:
                    color ??
                    (isSelected
                        ? const Color(0xFF1E3A8A)
                        : Colors.grey.shade400),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerificationCard extends StatelessWidget {
  final String name;
  final String barId;
  final String status;
  final Color statusColor;
  final String tag;
  final String location;
  final bool isVerified;
  final VoidCallback? onViewDetails;

  const _VerificationCard({
    required this.name,
    required this.barId,
    required this.status,
    required this.statusColor,
    required this.tag,
    required this.location,
    this.isVerified = false,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF1E3A8A),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bar ID: $barId',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1E3A8A,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
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
          const SizedBox(height: 16),
          if (isVerified)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.history,
                  size: 16,
                  color: Color(0xFF1E3A8A),
                ),
                label: const Text(
                  'Verification History',
                  style: TextStyle(color: Color(0xFF1E3A8A)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1E3A8A)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onViewDetails,
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    label: const Text(
                      'View Details',
                      style: TextStyle(color: Color(0xFF4B5563)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Color(0xFF059669),
                        ),
                        label: const Text(
                          'Approve',
                          style: TextStyle(color: Color(0xFF059669)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF059669)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel_outlined,
                          size: 16,
                          color: Color(0xFFDC2626),
                        ),
                        label: const Text(
                          'Reject',
                          style: TextStyle(color: Color(0xFFDC2626)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDC2626)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
