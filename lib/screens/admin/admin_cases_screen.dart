import 'package:flutter/material.dart';

class AdminCasesScreen extends StatefulWidget {
  const AdminCasesScreen({super.key});

  @override
  State<AdminCasesScreen> createState() => _AdminCasesScreenState();
}

class _AdminCasesScreenState extends State<AdminCasesScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Cases Management',
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search feature coming soon!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1F2937)),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Tabs
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
                  _buildSegmentedTab(0, 'Active (1,453)'),
                  _buildSegmentedTab(1, 'Resolved (842)'),
                  _buildSegmentedTab(2, 'Pending (120)'),
                ],
              ),
            ),
          ),

          // Filters row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showFilterBottomSheet(context),
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
                Text(
                  'SHOWING ${_selectedTabIndex == 0
                      ? "1,453"
                      : _selectedTabIndex == 1
                      ? "842"
                      : "120"} RESULTS',
                  style: const TextStyle(
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
                  'CASE DETAILS',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'STATUS',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // List of Cases
          Expanded(child: _buildCasesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add case manually coming soon!'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Color(0xFF1E3A8A),
            ),
          );
        },
        backgroundColor: const Color(0xFF1E3A8A),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String selectedCategory = 'All';
        String selectedDate = 'This Month';

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Cases',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FilterChip(
                        label: 'All',
                        isSelected: selectedCategory == 'All',
                        onTap: () =>
                            setModalState(() => selectedCategory = 'All'),
                      ),
                      _FilterChip(
                        label: 'Civil Law',
                        isSelected: selectedCategory == 'Civil Law',
                        onTap: () =>
                            setModalState(() => selectedCategory = 'Civil Law'),
                      ),
                      _FilterChip(
                        label: 'Criminal Law',
                        isSelected: selectedCategory == 'Criminal Law',
                        onTap: () => setModalState(
                          () => selectedCategory = 'Criminal Law',
                        ),
                      ),
                      _FilterChip(
                        label: 'Family Law',
                        isSelected: selectedCategory == 'Family Law',
                        onTap: () => setModalState(
                          () => selectedCategory = 'Family Law',
                        ),
                      ),
                      _FilterChip(
                        label: 'Corporate Law',
                        isSelected: selectedCategory == 'Corporate Law',
                        onTap: () => setModalState(
                          () => selectedCategory = 'Corporate Law',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Date Range',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _FilterChip(
                        label: 'This Month',
                        isSelected: selectedDate == 'This Month',
                        onTap: () =>
                            setModalState(() => selectedDate = 'This Month'),
                      ),
                      _FilterChip(
                        label: 'Last Month',
                        isSelected: selectedDate == 'Last Month',
                        onTap: () =>
                            setModalState(() => selectedDate = 'Last Month'),
                      ),
                      _FilterChip(
                        label: 'This Year',
                        isSelected: selectedDate == 'This Year',
                        onTap: () =>
                            setModalState(() => selectedDate = 'This Year'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Filtered by: $selectedCategory, $selectedDate',
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSegmentedTab(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCasesList() {
    // Generate different mock data depending on tab selected
    if (_selectedTabIndex == 0) {
      return ListView(
        children: [
          _CaseRowItem(
            caseId: '#LS-2026-894',
            title: 'Property Dispute v. Ali Developers',
            clientName: 'Client: Zubair Khan',
            lawyerName: 'Adv. Sarah Malik',
            category: 'Civil Law',
            date: 'Next Hearing: 15 Mar 2026',
            status: 'ACTIVE',
            statusColor: const Color(0xFF059669),
          ),
          _CaseRowItem(
            caseId: '#LS-2026-872',
            title: 'Divorce Settlement & Custody',
            clientName: 'Client: Ayesha Siddiqui',
            lawyerName: 'Adv. Ahmed Khan',
            category: 'Family Law',
            date: 'Next Hearing: 18 Mar 2026',
            status: 'ACTIVE',
            statusColor: const Color(0xFF059669),
          ),
          _CaseRowItem(
            caseId: '#LS-2026-855',
            title: 'Breach of Employment Contract',
            clientName: 'Client: Umar Farooq',
            lawyerName: 'Barrister Bilal',
            category: 'Corporate Law',
            date: 'Next Hearing: 22 Mar 2026',
            status: 'IN PROGRESS',
            statusColor: const Color(0xFFE67E22),
          ),
          _CaseRowItem(
            caseId: '#LS-2026-821',
            title: 'Fraudulent Check Issuance (Sec 489-F)',
            clientName: 'Client: Hassan Trade Co.',
            lawyerName: 'Adv. Ahmed Khan',
            category: 'Criminal Law',
            date: 'Next Hearing: 05 Apr 2026',
            status: 'ACTIVE',
            statusColor: const Color(0xFF059669),
          ),
        ],
      );
    } else if (_selectedTabIndex == 1) {
      return ListView(
        children: [
          _CaseRowItem(
            caseId: '#LS-2025-430',
            title: 'Land Encroachment Settlement',
            clientName: 'Client: Munir Associates',
            lawyerName: 'Adv. Zoya Malik',
            category: 'Civil Law',
            date: 'Resolved: 02 Jan 2026',
            status: 'RESOLVED',
            statusColor: const Color(0xFF1E3A8A),
          ),
          _CaseRowItem(
            caseId: '#LS-2025-392',
            title: 'Tax Evasion Allegations',
            clientName: 'Client: IT Solutions Ltd',
            lawyerName: 'Adv. Sarah Malik',
            category: 'Corporate Law',
            date: 'Resolved: 28 Dec 2025',
            status: 'CLOSED',
            statusColor: const Color(0xFF6B7280),
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          _CaseRowItem(
            caseId: '#LS-2026-905',
            title: 'Intellectual Property Infringement',
            clientName: 'Client: StartupTech',
            lawyerName: 'Unassigned',
            category: 'Corporate Law',
            date: 'Filed: 26 Feb 2026',
            status: 'PENDING',
            statusColor: const Color(0xFFDC2626),
          ),
          _CaseRowItem(
            caseId: '#LS-2026-911',
            title: 'Tenant Eviction Notice',
            clientName: 'Client: Waqar Properties',
            lawyerName: 'Unassigned',
            category: 'Civil Law',
            date: 'Filed: 27 Feb 2026',
            status: 'PENDING',
            statusColor: const Color(0xFFDC2626),
          ),
        ],
      );
    }
  }
}

class _CaseRowItem extends StatelessWidget {
  final String caseId;
  final String title;
  final String clientName;
  final String lawyerName;
  final String category;
  final String date;
  final String status;
  final Color statusColor;

  const _CaseRowItem({
    required this.caseId,
    required this.title,
    required this.clientName,
    required this.lawyerName,
    required this.category,
    required this.date,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.folder_open, color: Color(0xFF1E3A8A)),
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
                      caseId,
                      style: const TextStyle(
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      category,
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.person, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      clientName,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.gavel, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Lawyer: $lawyerName',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFFE67E22),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.grey),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Viewing details for $caseId'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xFF1E3A8A),
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
