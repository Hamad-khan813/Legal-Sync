import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'legal_categories_screen.dart';
import 'case_status_screen.dart';
import 'app_setting_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 3;
  bool _showSearch = false;
  final TextEditingController _searchCtrl = TextEditingController();

  final List<_ChatItem> _allChats = const [
    _ChatItem(
      name: 'Adv. Zia Ullah',
      initials: 'ZU',
      lastMessage: 'Your next hearing is Feb 20.',
      time: '10:48 AM',
      unread: 2,
      isOnline: true,
      isTyping: false,
      isGroup: false,
      color: Color(0xFF059669),
    ),
    _ChatItem(
      name: 'Alex Johnson',
      initials: 'AJ',
      lastMessage: 'Typing...',
      time: '10:48 AM',
      unread: 3,
      isOnline: true,
      isTyping: true,
      isGroup: false,
      color: Color(0xFF2563EB),
    ),
    _ChatItem(
      name: 'Marketing Team',
      initials: 'MT',
      lastMessage: 'Sara: New campaign assets uploaded',
      time: '9:35 AM',
      unread: 5,
      isOnline: false,
      isTyping: false,
      isGroup: true,
      color: Color(0xFF7C3AED),
    ),
    _ChatItem(
      name: 'Engineering Weekly',
      initials: 'EW',
      lastMessage: 'Saraf: Can we push the deploy?',
      time: 'Yesterday',
      unread: 0,
      isOnline: false,
      isTyping: false,
      isGroup: true,
      color: Color(0xFF0891B2),
    ),
    _ChatItem(
      name: 'Michael Chen',
      initials: 'MC',
      lastMessage: 'See you at the conference room...',
      time: 'Monday',
      unread: 0,
      isOnline: false,
      isTyping: false,
      isGroup: false,
      color: Color(0xFFD97706),
    ),
    _ChatItem(
      name: 'Sara Malik',
      initials: 'SM',
      lastMessage: 'Thanks for the document review!',
      time: 'Sunday',
      unread: 0,
      isOnline: false,
      isTyping: false,
      isGroup: false,
      color: Color(0xFFDC2626),
    ),
  ];

  List<_ChatItem> get _unreadChats =>
      _allChats.where((c) => c.unread > 0).toList();
  List<_ChatItem> get _groupChats => _allChats.where((c) => c.isGroup).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFF6B00),
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
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
                        'Messages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showSearch = !_showSearch),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _showSearch ? Icons.close : Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
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

            // Animated search bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: _showSearch ? 58 : 0,
              child: _showSearch
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2A2A2A)),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.search,
                              color: Color(0xFF6B6B6B),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchCtrl,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Search messages...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF5A5A5A),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 16),

            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF6B6B6B),
                indicator: BoxDecoration(
                  color: const Color(0xFFFF6B00),
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  const Tab(text: 'All Chats'),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Unread'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B00),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_unreadChats.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Tab(text: 'Groups'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _ChatList(chats: _allChats),
                  _ChatList(chats: _unreadChats),
                  _ChatList(chats: _groupChats),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    const items = [
      {'label': 'Home'},
      {'label': 'Lawyer'},
      {'label': 'Cases'},
      {'label': 'Chat'},
      {'label': 'Setting'},
    ];
    const icons = [
      Icons.home_outlined,
      Icons.balance_outlined,
      Icons.folder_outlined,
      Icons.chat_bubble_outline,
      Icons.settings_outlined,
    ];
    const activeIcons = [
      Icons.home,
      Icons.balance,
      Icons.folder,
      Icons.chat_bubble,
      Icons.settings,
    ];

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF141414),
        border: Border(top: BorderSide(color: Color(0xFF1E1E1E), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          final isActive = _currentIndex == index;
          return GestureDetector(
            onTap: () {
              if (isActive) return;
              final Widget destination = switch (index) {
                0 => const HomeScreen(),
                1 => const LegalCategoriesScreen(),
                2 => const CaseStatusScreen(),
                4 => const AppSettingScreen(),
                _ => const MessagesScreen(),
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
                  isActive ? activeIcons[index] : icons[index],
                  color: isActive
                      ? const Color(0xFFFF6B00)
                      : const Color(0xFF5A5A5A),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  items[index]['label']!,
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

// ─── Chat list ────────────────────────────────────────────────────────────────

class _ChatList extends StatelessWidget {
  final List<_ChatItem> chats;
  const _ChatList({required this.chats});

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, color: Color(0xFF2A2A2A), size: 52),
            SizedBox(height: 12),
            Text(
              'No messages here',
              style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 14),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: chats.length,
      itemBuilder: (_, i) {
        final chat = chats[i];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatDetailScreen(chat: chat)),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF252525)),
            ),
            child: Row(
              children: [
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: chat.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          chat.isGroup ? 14 : 25,
                        ),
                        border: Border.all(
                          color: chat.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Center(
                        child: chat.isGroup
                            ? Icon(Icons.group, color: chat.color, size: 22)
                            : Text(
                                chat.initials,
                                style: TextStyle(
                                  color: chat.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    if (chat.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF1A1A1A),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        chat.lastMessage,
                        style: TextStyle(
                          color: chat.isTyping
                              ? const Color(0xFF059669)
                              : const Color(0xFF6B6B6B),
                          fontSize: 12,
                          fontStyle: chat.isTyping
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Time & badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.time,
                      style: TextStyle(
                        color: chat.unread > 0
                            ? const Color(0xFFFF6B00)
                            : const Color(0xFF5A5A5A),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (chat.unread > 0)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B00),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${chat.unread}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Chat detail ──────────────────────────────────────────────────────────────

class ChatDetailScreen extends StatefulWidget {
  final _ChatItem chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! How can I help you today?',
      'mine': false,
      'time': '10:00 AM',
    },
    {
      'text': 'I have a question about my case documents.',
      'mine': true,
      'time': '10:01 AM',
    },
    {
      'text': 'Sure! Please share the details.',
      'mine': false,
      'time': '10:02 AM',
    },
    {
      'text': 'The court hearing is scheduled for Feb 20.',
      'mine': false,
      'time': '10:03 AM',
    },
    {
      'text': 'Great, I will prepare everything before that.',
      'mine': true,
      'time': '10:05 AM',
    },
    {
      'text': 'Please upload the required docs by Feb 15.',
      'mine': false,
      'time': '10:06 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.chat.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  widget.chat.initials,
                  style: TextStyle(
                    color: widget.chat.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.chat.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: widget.chat.isOnline
                        ? const Color(0xFF059669)
                        : const Color(0xFF6B6B6B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isMine = msg['mine'] as bool;
                return Align(
                  alignment: isMine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.72,
                    ),
                    decoration: BoxDecoration(
                      color: isMine
                          ? const Color(0xFFFF6B00)
                          : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMine ? 16 : 4),
                        bottomRight: Radius.circular(isMine ? 4 : 16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isMine
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'] as String,
                          style: TextStyle(
                            color: isMine
                                ? Colors.white
                                : const Color(0xFFDDDDDD),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'] as String,
                          style: TextStyle(
                            color: isMine
                                ? Colors.white.withValues(alpha: 0.6)
                                : const Color(0xFF5A5A5A),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Input bar
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF141414),
              border: Border(top: BorderSide(color: Color(0xFF1E1E1E))),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.attach_file, color: Color(0xFF6B6B6B)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    if (_ctrl.text.trim().isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'text': _ctrl.text.trim(),
                          'mine': true,
                          'time': 'Now',
                        });
                        _ctrl.clear();
                      });
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B00),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
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

// ─── Model ────────────────────────────────────────────────────────────────────

class _ChatItem {
  final String name, initials, lastMessage, time;
  final int unread;
  final bool isOnline, isTyping, isGroup;
  final Color color;
  const _ChatItem({
    required this.name,
    required this.initials,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.isOnline,
    required this.isTyping,
    required this.isGroup,
    required this.color,
  });
}
