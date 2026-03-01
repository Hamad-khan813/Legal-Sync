import 'package:flutter/material.dart';

class LawyerManagementDocumentScreen extends StatefulWidget {
  const LawyerManagementDocumentScreen({super.key});

  @override
  State<LawyerManagementDocumentScreen> createState() =>
      _LawyerManagementDocumentScreenState();
}

class _LawyerManagementDocumentScreenState
    extends State<LawyerManagementDocumentScreen> {
  int _selectedTabIndex = 0; // 0: All Documents, 1: Pending Reviews
  String _selectedCaseFilter = 'All cases';
  String _selectedClientFilter = 'All Clients';
  String _selectedSort = 'Newest First';
  String _selectedTypeFilter = 'All';

  final List<String> _documentTypes = [
    'All',
    'Evidence',
    'Contracts',
    'Affidavits',
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
          'Manage Document',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSnapshotCard(),
            const SizedBox(height: 20),
            _buildFilterSection(),
            const SizedBox(height: 24),
            _buildClientUploadsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSnapshotCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131D31), // Dark Navy
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review and manage documents uploaded by clients or pending your review.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSnapshotItem(
                'Pending',
                '3',
                const Color(0xFFFF6B00),
              ), // Orange
              _buildSnapshotItem('Approved', '9', Colors.green),
              _buildSnapshotItem('Rejected', '12', Colors.red),
            ],
          ),
          const SizedBox(height: 16),
          // Search Bar on top of Navy card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.white54),
                hintText: 'Search cases or client...',
                hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSnapshotItem(String title, String count, Color countColor) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: countColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Documents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Reset All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF6B00),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tab Switcher
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _buildTab('All Documents', 0),
                _buildTab('Pending Reviews', 1),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Dropdown Filters
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown('CASE', _selectedCaseFilter, [
                  'All cases',
                  'Case A',
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterDropdown('CLIENT', _selectedClientFilter, [
                  'All Clients',
                  'John Doe',
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sort Dropdown
          Row(
            children: [
              const Text(
                'SORT BY  ',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 1,
                ),
              ),
              Expanded(
                child: _buildFilterDropdown('SORT BY', _selectedSort, [
                  'Newest First',
                  'Oldest First',
                ], hideLabel: true),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Document Types Chips
          const Text(
            'DOCUMENT TYPE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _documentTypes
                  .map((type) => _buildTypeChip(type))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black87 : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String selectedValue,
    List<String> items, {
    bool hideLabel = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideLabel)
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
        if (!hideLabel) const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
              ),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    if (label == 'CASE') _selectedCaseFilter = val;
                    if (label == 'CLIENT') _selectedClientFilter = val;
                    if (label == 'SORT BY') _selectedSort = val;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeChip(String label) {
    bool isSelected = _selectedTypeFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTypeFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B00) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B00) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildClientUploadsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Client Uploads',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '3 documents found',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDocumentListItem(
            docTitle: 'Evidence-file-01_ver2.0...',
            clientName: 'Client: Sarah Miller',
            caseName: 'Case type: Real Estate',
            iconType: Icons.description,
            iconColor: Colors.blue.shade400,
            statusLabel: 'PENDING',
            statusColor: const Color(0xFFFF6B00),
            date: 'Submitted: 14 Aug 2025',
          ),
          const SizedBox(height: 12),
          _buildDocumentListItem(
            docTitle: 'Agreement_Draft_review...',
            clientName: 'Client: John Doe',
            caseName: 'Case type: Corporate',
            iconType: Icons.picture_as_pdf,
            iconColor: Colors.red.shade400,
            statusLabel: 'APPROVED',
            statusColor: Colors.green,
            date: 'Submitted: 12 Aug 2025',
          ),
          const SizedBox(height: 12),
          _buildDocumentListItem(
            docTitle: 'Evidence_site_photo_01...',
            clientName: 'Client: Marcus Rash',
            caseName: 'Case type: Property',
            iconType: Icons.image,
            iconColor: Colors.purple.shade400,
            statusLabel: 'PENDING',
            statusColor: const Color(0xFFFF6B00),
            date: 'Submitted: 10 Aug 2025',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDocumentListItem({
    required String docTitle,
    required String clientName,
    required String caseName,
    required IconData iconType,
    required Color iconColor,
    required String statusLabel,
    required Color statusColor,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconType, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      clientName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      caseName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: Colors.orange.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.more_vert,
                      size: 16,
                      color: Colors.grey.shade700,
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
