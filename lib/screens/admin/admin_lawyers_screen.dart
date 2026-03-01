import 'package:flutter/material.dart';

class AdminLawyersScreen extends StatelessWidget {
  const AdminLawyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Total Lawyers',
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
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LawyerCard(
            name: 'Adv. Sarah Malik',
            specialty: 'Corporate Law',
            status: 'Active',
            rating: '4.9',
            cases: 42,
          ),
          _LawyerCard(
            name: 'Barrister Bilal',
            specialty: 'Criminal Law',
            status: 'Active',
            rating: '4.7',
            cases: 38,
          ),
          _LawyerCard(
            name: 'Adv. Ahmed Khan',
            specialty: 'Family Law',
            status: 'On Leave',
            rating: '4.8',
            cases: 15,
          ),
          _LawyerCard(
            name: 'Adv. Zoya Malik',
            specialty: 'Civil Law',
            status: 'Active',
            rating: '4.6',
            cases: 29,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add manual lawyer coming soon!'),
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
}

class _LawyerCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String status;
  final String rating;
  final int cases;

  const _LawyerCard({
    required this.name,
    required this.specialty,
    required this.status,
    required this.rating,
    required this.cases,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = status == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
          child: const Icon(Icons.person, color: Color(0xFF1E3A8A)),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              specialty,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFE67E22)),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.folder, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '$cases Cases',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF059669).withValues(alpha: 0.1)
                : const Color(0xFFE67E22).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? const Color(0xFF059669)
                  : const Color(0xFFE67E22),
            ),
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing $name\'s details'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF1E3A8A),
            ),
          );
        },
      ),
    );
  }
}
