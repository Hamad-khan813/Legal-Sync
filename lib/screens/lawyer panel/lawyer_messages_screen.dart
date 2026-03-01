import 'package:flutter/material.dart';
import 'package:legal_sync/screens/lawyer%20panel/lawyer_chat_screen.dart';

class LawyerMessagesScreen extends StatefulWidget {
  const LawyerMessagesScreen({super.key});

  @override
  State<LawyerMessagesScreen> createState() => _LawyerMessagesScreenState();
}

class _LawyerMessagesScreenState extends State<LawyerMessagesScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'name': 'Adv. Julian Vance',
      'message': 'The draft for the property dispute is r...',
      'time': '10:45 AM',
      'unreadCount': 2,
      'avatar': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'name': 'Sarah Jenkins (Legal Asst.)',
      'message': 'Received the documents from the court el...',
      'time': '9:20 AM',
      'unreadCount': 0,
      'avatar': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'name': 'Robert Miller',
      'message': 'Thank you for the update on my case status.',
      'time': 'Yesterday',
      'unreadCount': 0,
      'avatar': 'https://i.pravatar.cc/150?img=11',
    },
    {
      'name': 'David Chen',
      'message': 'Can we schedule a call for Monday morning...',
      'time': 'Yesterday',
      'unreadCount': 0,
      'avatar': 'https://i.pravatar.cc/150?img=13',
    },
    {
      'name': 'Maria Garcia',
      'message': 'The settlement agreement looks good on ...',
      'time': 'Oct 24',
      'unreadCount': 0,
      'avatar': 'https://i.pravatar.cc/150?img=16',
    },
  ];

  String _selectedFilter = 'All';

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
          'Messages',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _messages.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final chat = _messages[index];
                return _buildChatTile(chat);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF6B00),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
          hintText: 'Search conversations...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildFilterChip('All'),
          const SizedBox(width: 8),
          _buildFilterChip('Unread'),
          const SizedBox(width: 8),
          _buildFilterChip('Archived'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LawyerChatScreen(
              clientName: chat['name'],
              avatarUrl: chat['avatar'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(chat['avatar']),
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
                        chat['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: chat['unreadCount'] > 0
                              ? const Color(0xFFFF6B00)
                              : Colors.grey.shade500,
                          fontWeight: chat['unreadCount'] > 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat['message'],
                          style: TextStyle(
                            fontSize: 13,
                            color: chat['unreadCount'] > 0
                                ? Colors.black87
                                : Colors.grey.shade600,
                            fontWeight: chat['unreadCount'] > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat['unreadCount'] > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF6B00),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat['unreadCount'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
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
}
