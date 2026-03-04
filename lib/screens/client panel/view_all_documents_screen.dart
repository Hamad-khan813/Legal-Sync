import 'package:flutter/material.dart';

class ViewAllDocumentsScreen extends StatefulWidget {
  const ViewAllDocumentsScreen({super.key});

  @override
  State<ViewAllDocumentsScreen> createState() => _ViewAllDocumentsScreenState();
}

class _ViewAllDocumentsScreenState extends State<ViewAllDocumentsScreen> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _tabs = ['All', 'Contracts', 'Court Orders', 'Other'];

  final List<_DocumentItem> _allDocuments = [
    _DocumentItem(
      name: 'NDA_Final_V2.pdf',
      type: 'pdf',
      uploadedBy: 'Mark Thompson',
      category: 'Contracts',
      date: 'Nov 2, 2023',
      caseInfo: 'Civil Case',
    ),
    _DocumentItem(
      name: 'ID_Verification_Scan.jpg',
      type: 'image',
      uploadedBy: 'You',
      category: 'Other',
      date: 'Oct 28, 2023',
      caseInfo: 'General Profile',
    ),
    _DocumentItem(
      name: 'Settlement_Calculator.xlsx',
      type: 'spreadsheet',
      uploadedBy: 'Finance Dept',
      category: 'Other',
      date: 'Oct 20, 2023',
      caseInfo: 'Legal Accounting',
    ),
    _DocumentItem(
      name: 'Court_Summons_Copy.pdf',
      type: 'pdf',
      uploadedBy: 'Sarah Jenkins',
      category: 'Court Orders',
      date: 'Oct 15, 2023',
      caseInfo: 'Civil Case',
    ),
    _DocumentItem(
      name: 'Partnership_Agreement.pdf',
      type: 'pdf',
      uploadedBy: 'Legal Team',
      category: 'Contracts',
      date: 'Oct 10, 2023',
      caseInfo: 'Corporate',
    ),
    _DocumentItem(
      name: 'Evidence_Photo_01.jpg',
      type: 'image',
      uploadedBy: 'You',
      category: 'Other',
      date: 'Oct 5, 2023',
      caseInfo: 'Criminal Case',
    ),
  ];

  List<_DocumentItem> get _filteredDocuments {
    var docs = _allDocuments;

    // Filter by tab
    if (_selectedTab != 0) {
      final category = _tabs[_selectedTab];
      docs = docs.where((d) => d.category == category).toList();
    }

    // Filter by search
    if (_searchQuery.isNotEmpty) {
      docs = docs
          .where(
            (d) => d.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return docs;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        'Recent Activity',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: const Icon(
                        Icons.upload_outlined,
                        color: Color(0xFFFF6B00),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() => _searchQuery = val);
                        },
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search files...',
                          hintStyle: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.close,
                            color: Color(0xFF9CA3AF),
                            size: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category Tabs
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  final isActive = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFFF6B00)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive
                              ? const Color(0xFFFF6B00)
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : const Color(0xFF4B5563),
                          fontSize: 13,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Documents List grouped by date
            Expanded(
              child: _filteredDocuments.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader('TODAY'),
                          _buildDocumentCard(_allDocuments[0]),
                          _buildDocumentCard(_allDocuments[1]),
                          const SizedBox(height: 20),
                          _buildSectionHeader('YESTERDAY'),
                          _buildDocumentCard(_allDocuments[2]),
                          _buildDocumentCard(_allDocuments[3]),
                          const SizedBox(height: 20),
                          _buildSectionHeader('LAST WEEK'),
                          _buildDocumentCard(_allDocuments[4]),
                          _buildDocumentCard(_allDocuments[5]),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF6B00),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDocumentCard(_DocumentItem doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // File icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getFileColor(doc.type).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getFileIcon(doc.type),
              color: _getFileColor(doc.type),
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Uploaded by ${doc.uploadedBy}',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(color: Color(0xFFD1D5DB)),
                    ),
                    Flexible(
                      child: Text(
                        doc.caseInfo,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  doc.date,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // More options
          GestureDetector(
            onTap: () {
              _showDocOptions(doc);
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.more_vert,
                color: Color(0xFF4B5563),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDocOptions(_DocumentItem doc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  doc.name,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _buildBottomSheetOption(
                  Icons.visibility_outlined,
                  'Preview',
                  () => Navigator.pop(context),
                ),
                _buildBottomSheetOption(
                  Icons.download_outlined,
                  'Download',
                  () => Navigator.pop(context),
                ),
                _buildBottomSheetOption(
                  Icons.share_outlined,
                  'Share',
                  () => Navigator.pop(context),
                ),
                _buildBottomSheetOption(
                  Icons.delete_outline,
                  'Delete',
                  () => Navigator.pop(context),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? const Color(0xFFEF4444)
            : const Color(0xFF4B5563),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive
              ? const Color(0xFFEF4444)
              : const Color(0xFF111827),
          fontSize: 15,
        ),
      ),
      onTap: onTap,
    );
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'image':
        return Icons.image_outlined;
      case 'spreadsheet':
        return Icons.table_chart_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _getFileColor(String type) {
    switch (type) {
      case 'pdf':
        return const Color(0xFFEF4444);
      case 'image':
        return const Color(0xFFFF6B00);
      case 'spreadsheet':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_off_outlined,
            color: const Color(0xFFD1D5DB),
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'No documents found',
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try a different search or category',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem {
  final String name;
  final String type;
  final String uploadedBy;
  final String category;
  final String date;
  final String caseInfo;

  const _DocumentItem({
    required this.name,
    required this.type,
    required this.uploadedBy,
    required this.category,
    required this.date,
    required this.caseInfo,
  });
}
