import 'package:flutter/material.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analytics & Growth',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF1E3A8A)),
            onPressed: () => showComingSoon('Share Report'),
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined, color: Color(0xFF1E3A8A)),
            onPressed: () => showComingSoon('Download CSV'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: const Color(0xFF1E3A8A),
              unselectedLabelColor: const Color(0xFF6B7280),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'Case Stats'),
                Tab(text: 'User Growth'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCaseStatsTab(),
          _buildUserGrowthTab(context, showComingSoon),
        ],
      ),
    );
  }

  Widget _buildCaseStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FilterChip(label: 'Today', isSelected: true),
              _FilterChip(label: 'This Week', isSelected: false),
              _FilterChip(label: 'Month', isSelected: false),
              _FilterChip(label: 'Custom', isSelected: false),
            ],
          ),
          const SizedBox(height: 24),

          // Case Distribution
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
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
                      'Case Distribution',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.info_outline, color: Colors.grey[400], size: 18),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Mock Donut Chart
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 1.0,
                            color: const Color(0xFF1E3A8A),
                            strokeWidth: 12,
                          ),
                          CircularProgressIndicator(
                            value: 0.55,
                            color: const Color(0xFFE67E22),
                            strokeWidth: 12,
                          ),
                          CircularProgressIndicator(
                            value: 0.25,
                            color: const Color(0xFF059669),
                            strokeWidth: 12,
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '1.2k',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Legend
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LegendItem(
                            color: const Color(0xFF1E3A8A),
                            label: 'Civil',
                            percentage: '45%',
                          ),
                          _LegendItem(
                            color: const Color(0xFFE67E22),
                            label: 'Criminal',
                            percentage: '30%',
                          ),
                          _LegendItem(
                            color: const Color(0xFF059669),
                            label: 'Family',
                            percentage: '25%',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Key Performance Metrics
          const Text(
            'Key Performance Metrics',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 16),
          _MetricRow(
            title: 'New Leads',
            value: '248',
            growth: '+15%',
            isPositive: true,
          ),
          _MetricRow(
            title: 'Avg Response Time',
            value: '14m',
            growth: '-2%',
            isPositive: false,
          ),
          _MetricRow(
            title: 'Revenue (PKR)',
            value: '1.2M',
            growth: '+8%',
            isPositive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildUserGrowthTab(
    BuildContext context,
    Function(String) showComingSoon,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Growth Chart Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Growth',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '+12% from last month',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xFFE67E22),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'LAWYERS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xFF1E3A8A),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'CLIENTS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Custom drawn mock line chart utilizing clip path could go here
                SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      "Line Chart visualization\n(Clients - Blue, Lawyers - Orange)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Jan',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      'Feb',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      'Mar',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      'Apr',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      'May',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Performing Lawyers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              TextButton(
                onPressed: () => showComingSoon('Top Lawyers Directory'),
                child: const Text(
                  'View All',
                  style: TextStyle(color: Color(0xFF1E3A8A)),
                ),
              ),
            ],
          ),

          // Lawyer List
          _TopLawyerItem(
            name: 'Advocate Ahmed Khan',
            court: 'Corporate Law • Islamabad',
            rating: '98%',
            subtitle: 'SUCCESS RATE',
            avatarColor: Colors.amber,
          ),
          _TopLawyerItem(
            name: 'Zoya Malik',
            court: 'Family Law • Lahore',
            rating: '94%',
            subtitle: 'SUCCESS RATE',
            avatarColor: Colors.pink,
          ),
          _TopLawyerItem(
            name: 'Barrister Bilal Shah',
            court: 'Criminal Law • Karachi',
            rating: '92%',
            subtitle: 'SUCCESS RATE',
            avatarColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade600,
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String percentage;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Color(0xFF4B5563), fontSize: 12),
              ),
            ],
          ),
          Text(
            percentage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String title;
  final String value;
  final String growth;
  final bool isPositive;

  const _MetricRow({
    required this.title,
    required this.value,
    required this.growth,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 10,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      growth,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopLawyerItem extends StatelessWidget {
  final String name;
  final String court;
  final String rating;
  final String subtitle;
  final Color avatarColor;

  const _TopLawyerItem({
    required this.name,
    required this.court,
    required this.rating,
    required this.subtitle,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: avatarColor.withValues(alpha: 0.2),
        child: Icon(Icons.person, color: avatarColor),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
      subtitle: Text(
        court,
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            rating,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
