import 'package:flutter/material.dart';
import 'lawyer_profile_screen.dart';
import 'legal_categories_screen.dart';
import 'messages_screen.dart';
import 'case_status_screen.dart';
import 'search_filter_screen.dart';
import 'app_setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  Map<String, dynamic>? _activeFilters;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.gavel, 'label': 'Civil', 'color': Color(0xFFFF6B00)},
    {
      'icon': Icons.shield_outlined,
      'label': 'Cyber',
      'color': Color(0xFF7C3AED),
    },
    {
      'icon': Icons.local_hospital_outlined,
      'label': 'Medical',
      'color': Color(0xFF059669),
    },
    {
      'icon': Icons.handshake_outlined,
      'label': 'Criminal',
      'color': Color(0xFFDC2626),
    },
    {
      'icon': Icons.home_outlined,
      'label': 'Property',
      'color': Color(0xFF2563EB),
    },
    {
      'icon': Icons.family_restroom,
      'label': 'Family',
      'color': Color(0xFFD97706),
    },
    {
      'icon': Icons.business_center_outlined,
      'label': 'Corporate',
      'color': Color(0xFF0891B2),
    },
    {
      'icon': Icons.lightbulb_outline,
      'label': 'IP Law',
      'color': Color(0xFF7C3AED),
    },
  ];

  final List<Map<String, dynamic>> _lawyers = [
    {
      'name': 'Hamad Khan',
      'specialty': 'Criminal Lawyer',
      'rating': 4.9,
      'reviews': 200,
      'location': 'Islamabad, PK',
      'experience': '8 Years',
      'useProfile': false,
    },
    {
      'name': 'Zaid Salar',
      'specialty': 'Corporate Lawyer',
      'rating': 4.8,
      'reviews': 145,
      'location': 'Lahore, PK',
      'experience': '6 Years',
      'useProfile': false,
    },
    {
      'name': 'Jonathan Sterling',
      'specialty': 'Senior Partner | Corporate Law',
      'rating': 4.9,
      'reviews': 320,
      'location': 'Karachi, PK',
      'experience': '15+ Years',
      'useProfile': true,
    },
    {
      'name': 'Sara Malik',
      'specialty': 'Family Lawyer',
      'rating': 4.7,
      'reviews': 98,
      'location': 'Rawalpindi, PK',
      'experience': '5 Years',
      'useProfile': false,
    },
    {
      'name': 'Adv. Zia Ullah',
      'specialty': 'Civil Law Specialist',
      'rating': 4.8,
      'reviews': 180,
      'location': 'Peshawar, PK',
      'experience': '12 Years',
      'useProfile': false,
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openFilter() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const SearchFilterScreen()),
    );
    if (result != null) {
      setState(() => _activeFilters = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Text(
                    'LegalSync',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'images/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF2A2A2A),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 14),
                                  const Icon(
                                    Icons.search,
                                    color: Color(0xFF6B6B6B),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchCtrl,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      onChanged: (_) => setState(() {}),
                                      decoration: const InputDecoration(
                                        hintText: 'Search lawyers, case...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF5A5A5A),
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  if (_searchCtrl.text.isNotEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        _searchCtrl.clear();
                                        setState(() {});
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.close,
                                          color: Color(0xFF6B6B6B),
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: _openFilter,
                            child: Stack(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _activeFilters != null
                                        ? const Color(0xFFFF6B00)
                                        : const Color(0xFF1E1E1E),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _activeFilters != null
                                          ? const Color(0xFFFF6B00)
                                          : const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.tune,
                                    color: _activeFilters != null
                                        ? Colors.white
                                        : const Color(0xFF9E9E9E),
                                    size: 20,
                                  ),
                                ),
                                if (_activeFilters != null)
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Active filter chips
                    if (_activeFilters != null) ...[
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_list,
                              color: Color(0xFFFF6B00),
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Filters active',
                              style: TextStyle(
                                color: Color(0xFFFF6B00),
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _activeFilters = null),
                              child: const Text(
                                'Clear',
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Categories Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LegalCategoriesScreen(),
                              ),
                            ),
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Color(0xFFFF6B00),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Categories horizontal scroll
                    SizedBox(
                      height: 88,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LegalCategoriesScreen(),
                              ),
                            ),
                            child: Container(
                              width: 72,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF252525),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: (cat['color'] as Color).withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      cat['icon'] as IconData,
                                      color: cat['color'] as Color,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    cat['label'] as String,
                                    style: const TextStyle(
                                      color: Color(0xFFCCCCCC),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Featured Lawyers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Featured Lawyers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LegalCategoriesScreen(),
                              ),
                            ),
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Color(0xFFFF6B00),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Lawyer cards
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _lawyers.length,
                      itemBuilder: (context, index) {
                        final lawyer = _lawyers[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LawyerProfileScreen(
                                name: lawyer['name'] as String,
                                specialty: lawyer['specialty'] as String,
                                rating: lawyer['rating'] as double,
                                reviews: lawyer['reviews'] as int,
                                location: lawyer['location'] as String,
                                experience: lawyer['experience'] as String,
                                useProfileImage: lawyer['useProfile'] as bool,
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF252525),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: lawyer['useProfile'] as bool
                                        ? Image.asset(
                                            'images/profile.jpg',
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: const Color(0xFF2A2A2A),
                                            child: Center(
                                              child: Text(
                                                (lawyer['name'] as String)
                                                    .split(' ')
                                                    .map((e) => e[0])
                                                    .take(2)
                                                    .join(),
                                                style: const TextStyle(
                                                  color: Color(0xFFFF6B00),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lawyer['name'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        lawyer['specialty'] as String,
                                        style: const TextStyle(
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFB800),
                                            size: 14,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '${lawyer['rating']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '(${lawyer['reviews']} reviews)',
                                            style: const TextStyle(
                                              color: Color(0xFF6B6B6B),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Color(0xFF6B6B6B),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          lawyer['location'] as String,
                                          style: const TextStyle(
                                            color: Color(0xFF6B6B6B),
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFFF6B00,
                                        ).withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        lawyer['experience'] as String,
                                        style: const TextStyle(
                                          color: Color(0xFFFF6B00),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
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
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    const items = ['Home', 'Lawyer', 'Cases', 'Chat', 'Setting'];
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
          final isActive = index == 0;
          return GestureDetector(
            onTap: () {
              if (isActive) return;
              final Widget destination = switch (index) {
                1 => const LegalCategoriesScreen(),
                2 => const CaseStatusScreen(),
                3 => const MessagesScreen(),
                4 => const AppSettingScreen(),
                _ => const HomeScreen(),
              };
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
                  items[index],
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
