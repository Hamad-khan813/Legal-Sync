import 'package:flutter/material.dart';
import 'messages_screen.dart';
import 'home_screen.dart';
import 'legal_categories_screen.dart';
import 'app_setting_screen.dart';

class CaseStatusScreen extends StatefulWidget {
  const CaseStatusScreen({super.key});

  @override
  State<CaseStatusScreen> createState() => _CaseStatusScreenState();
}

class _CaseStatusScreenState extends State<CaseStatusScreen> {
  int _currentIndex = 2;

  final List<_TimelineStep> _timeline = [
    _TimelineStep(
      date: 'Jan 24',
      title: 'Case Registered',
      status: TimelineStatus.done,
      subtitle: 'Case successfully filed',
    ),
    _TimelineStep(
      date: 'Jan 30',
      title: 'Lawyer Assigned',
      status: TimelineStatus.done,
      subtitle: 'Adv. Zia Ullah assigned',
    ),
    _TimelineStep(
      date: 'Jan 30',
      title: 'Document Verification',
      status: TimelineStatus.active,
      subtitle: 'Last Update: 10 Jan 2025',
    ),
    _TimelineStep(
      date: 'Feb 20',
      title: 'Court Hearing Scheduled',
      status: TimelineStatus.pending,
      subtitle: 'Date Expected: 4 Feb 2025',
    ),
    _TimelineStep(
      date: 'Mar 10',
      title: 'Court Hearing Confirmed',
      status: TimelineStatus.pending,
      subtitle: 'Pending decision',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Case Status',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Case Summary Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1E1A10), Color(0xFF1A1200)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(
                            0xFFFF6B00,
                          ).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFF6B00,
                                  ).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(
                                      0xFFFF6B00,
                                    ).withValues(alpha: 0.5),
                                  ),
                                ),
                                child: const Text(
                                  'Case # CL-2025-8475',
                                  style: TextStyle(
                                    color: Color(0xFFFF6B00),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF059669,
                                  ).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Active',
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _CaseDetailRow(
                            label: 'Court',
                            value: 'Supreme Court - Civil Division',
                          ),
                          const SizedBox(height: 6),
                          _CaseDetailRow(
                            label: 'Filed',
                            value: 'October 15, 2023',
                          ),
                          const SizedBox(height: 6),
                          _CaseDetailRow(label: 'Type', value: 'Civil Lawsuit'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Case Progress
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF252525)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Case Progress',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '65%',
                                style: const TextStyle(
                                  color: Color(0xFFFF6B00),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.65,
                              backgroundColor: const Color(0xFF2A2A2A),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFFF6B00),
                              ),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Filed',
                                style: TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Hearing',
                                style: TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Verdict',
                                style: TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Timeline
                    const Text(
                      'Case Timeline',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF252525)),
                      ),
                      child: Column(
                        children: List.generate(_timeline.length, (i) {
                          return _TimelineTile(
                            step: _timeline[i],
                            isLast: i == _timeline.length - 1,
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Case Consultant
                    const Text(
                      'Case Consultant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF252525)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: const Color(
                                      0xFFFF6B00,
                                    ).withValues(alpha: 0.4),
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'ZU',
                                    style: TextStyle(
                                      color: Color(0xFFFF6B00),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Adv. Zia Ullah',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Civil Law Specialist • 12 Years Exp.',
                                      style: TextStyle(
                                        color: Color(0xFF9E9E9E),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFFFB800),
                                          size: 12,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          '4.8 (180 reviews)',
                                          style: TextStyle(
                                            color: Color(0xFF9E9E9E),
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
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.call_outlined,
                                    size: 16,
                                    color: Color(0xFF2563EB),
                                  ),
                                  label: const Text(
                                    'Call now',
                                    style: TextStyle(
                                      color: Color(0xFF2563EB),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF2563EB),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const MessagesScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.chat_bubble_outline,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Chat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF059669),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Hearing Updates
                    const Text(
                      'Hearing Updates',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _HearingUpdateCard(
                      date: 'Today, 14:30',
                      title: 'Third Hearing completed',
                      subtitle: 'Judge requested additional evidence',
                      isRecent: true,
                    ),
                    const SizedBox(height: 10),
                    _HearingUpdateCard(
                      date: 'Dec 5, 2023',
                      title: 'Second Hearing Postponed',
                      subtitle: 'Rescheduled to Jan 10, 2024',
                      isRecent: false,
                    ),
                    const SizedBox(height: 20),

                    // Key Documents
                    const Text(
                      'Key Documents',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          _DocumentChip(
                            name: 'Complaint.pdf',
                            icon: Icons.picture_as_pdf,
                            color: Color(0xFFDC2626),
                          ),
                          SizedBox(width: 10),
                          _DocumentChip(
                            name: 'Evidence.xlsx',
                            icon: Icons.table_chart_outlined,
                            color: Color(0xFF059669),
                          ),
                          SizedBox(width: 10),
                          _DocumentChip(
                            name: 'Notice.jpg',
                            icon: Icons.image_outlined,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 10),
                          _DocumentChip(
                            name: 'Add Doc',
                            icon: Icons.add_circle_outline,
                            color: Color(0xFFFF6B00),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Quick Actions
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.4,
                      children: [
                        _QuickActionButton(
                          label: 'Upload File',
                          icon: Icons.upload_file,
                          color: const Color(0xFFFF6B00),
                          onTap: () {},
                        ),
                        _QuickActionButton(
                          label: 'Schedule',
                          icon: Icons.calendar_month_outlined,
                          color: const Color(0xFF2563EB),
                          onTap: () {},
                        ),
                        _QuickActionButton(
                          label: 'Add Notes',
                          icon: Icons.note_add_outlined,
                          color: const Color(0xFF7C3AED),
                          onTap: () {},
                        ),
                        _QuickActionButton(
                          label: 'Update Status',
                          icon: Icons.update,
                          color: const Color(0xFF059669),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                3 => const MessagesScreen(),
                4 => const AppSettingScreen(),
                _ => const CaseStatusScreen(),
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

// ─── Supporting widgets ───────────────────────────────────────────────────────

class _CaseDetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _CaseDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 52,
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 12),
          ),
        ),
        const Text(
          ':  ',
          style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 12),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFFDDDDDD),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

enum TimelineStatus { done, active, pending }

class _TimelineStep {
  final String date;
  final String title;
  final TimelineStatus status;
  final String subtitle;
  const _TimelineStep({
    required this.date,
    required this.title,
    required this.status,
    required this.subtitle,
  });
}

class _TimelineTile extends StatelessWidget {
  final _TimelineStep step;
  final bool isLast;
  const _TimelineTile({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    IconData dotIcon;
    switch (step.status) {
      case TimelineStatus.done:
        dotColor = const Color(0xFF059669);
        dotIcon = Icons.check_circle;
        break;
      case TimelineStatus.active:
        dotColor = const Color(0xFFFFB800);
        dotIcon = Icons.radio_button_checked;
        break;
      case TimelineStatus.pending:
        dotColor = const Color(0xFF3A3A3A);
        dotIcon = Icons.radio_button_unchecked;
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 54,
            child: Text(
              step.date,
              style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 11),
            ),
          ),
          Column(
            children: [
              Icon(dotIcon, color: dotColor, size: 20),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF252525),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      color: step.status == TimelineStatus.pending
                          ? const Color(0xFF6B6B6B)
                          : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HearingUpdateCard extends StatelessWidget {
  final String date;
  final String title;
  final String subtitle;
  final bool isRecent;

  const _HearingUpdateCard({
    required this.date,
    required this.title,
    required this.subtitle,
    required this.isRecent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isRecent
              ? const Color(0xFFFF6B00).withValues(alpha: 0.3)
              : const Color(0xFF252525),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isRecent
                  ? const Color(0xFFFF6B00).withValues(alpha: 0.12)
                  : const Color(0xFF252525),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isRecent ? Icons.gavel : Icons.history,
              color: isRecent
                  ? const Color(0xFFFF6B00)
                  : const Color(0xFF6B6B6B),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: isRecent
                        ? const Color(0xFFFF6B00)
                        : const Color(0xFF6B6B6B),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
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

class _DocumentChip extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  const _DocumentChip({
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 85,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF252525)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFFCCCCCC),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
