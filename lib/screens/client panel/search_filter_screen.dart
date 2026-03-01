import 'package:flutter/material.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  final List<String> _specialties = [
    'Criminal Law',
    'Family Law',
    'Corporate',
    'Civil Law',
    'Immigration',
    'Real Estate',
    'IP Law',
    'Cyber Crime',
  ];
  final Set<String> _selectedSpecialties = {'Criminal Law'};
  final TextEditingController _locationCtrl = TextEditingController();

  RangeValues _feeRange = const RangeValues(480, 800);
  String _minRating = '4.0+';
  bool _availableToday = false;
  bool _acceptingClients = true;

  final List<String> _ratings = ['3.5+', '4.0+', '4.5+'];

  @override
  void dispose() {
    _locationCtrl.dispose();
    super.dispose();
  }

  void _resetAll() {
    setState(() {
      _selectedSpecialties.clear();
      _locationCtrl.clear();
      _feeRange = const RangeValues(0, 1000);
      _minRating = '4.0+';
      _availableToday = false;
      _acceptingClients = false;
    });
  }

  int get _activeFilterCount {
    int count = 0;
    if (_selectedSpecialties.isNotEmpty) count++;
    if (_locationCtrl.text.isNotEmpty) count++;
    if (_feeRange != const RangeValues(0, 1000)) count++;
    if (_availableToday) count++;
    if (_acceptingClients) count++;
    return count;
  }

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
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Filter Lawyers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _resetAll,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFF6B00).withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Color(0xFFFF6B00),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Legal Specialty
                    _SectionTitle(
                      title: 'Legal Specialty',
                      subtitle: '${_selectedSpecialties.length} selected',
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _specialties.map((s) {
                        final selected = _selectedSpecialties.contains(s);
                        return GestureDetector(
                          onTap: () => setState(
                            () => selected
                                ? _selectedSpecialties.remove(s)
                                : _selectedSpecialties.add(s),
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFFF6B00)
                                  : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFFFF6B00)
                                    : const Color(0xFF2A2A2A),
                              ),
                            ),
                            child: Text(
                              s,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF9E9E9E),
                                fontSize: 13,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Location
                    const _SectionTitle(title: 'Location', subtitle: ''),
                    const SizedBox(height: 12),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2A2A2A)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF6B6B6B),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _locationCtrl,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              onChanged: (_) => setState(() {}),
                              decoration: const InputDecoration(
                                hintText: 'City, State or Zip Code',
                                hintStyle: TextStyle(color: Color(0xFF5A5A5A)),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_locationCtrl.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _locationCtrl.clear();
                                setState(() {});
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12),
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
                    const SizedBox(height: 8),
                    // Map preview placeholder
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF252525)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomPaint(
                              painter: _MapPainter(),
                              child: const SizedBox.expand(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFFFF6B00),
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Select on map',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Consultation Fee range
                    _SectionTitle(
                      title: 'Consultation Fee',
                      subtitle:
                          '\$${_feeRange.start.round()} – \$${_feeRange.end.round() >= 1000 ? "1000+" : _feeRange.end.round()}',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF252525)),
                      ),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              activeTrackColor: const Color(0xFFFF6B00),
                              inactiveTrackColor: const Color(0xFF2A2A2A),
                              thumbColor: const Color(0xFFFF6B00),
                              overlayColor: const Color(
                                0xFFFF6B00,
                              ).withValues(alpha: 0.2),
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 10,
                              ),
                            ),
                            child: RangeSlider(
                              values: _feeRange,
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              onChanged: (v) => setState(() => _feeRange = v),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$0',
                                  style: const TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$1000+',
                                  style: const TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Minimum Rating
                    const _SectionTitle(title: 'Minimum Rating', subtitle: ''),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _ratings.map((r) {
                        final selected = _minRating == r;
                        return GestureDetector(
                          onTap: () => setState(() => _minRating = r),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFFF6B00)
                                  : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFFFF6B00)
                                    : const Color(0xFF2A2A2A),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFFFFB800),
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  r,
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xFF9E9E9E),
                                    fontSize: 13,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Availability
                    const _SectionTitle(title: 'Availability', subtitle: ''),
                    const SizedBox(height: 12),
                    _CheckboxTile(
                      label: 'Available Today',
                      value: _availableToday,
                      onChanged: (v) =>
                          setState(() => _availableToday = v ?? false),
                    ),
                    const SizedBox(height: 8),
                    _CheckboxTile(
                      label: 'Accepting New Clients',
                      value: _acceptingClients,
                      onChanged: (v) =>
                          setState(() => _acceptingClients = v ?? false),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Apply button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, {
                    'specialties': _selectedSpecialties.toList(),
                    'location': _locationCtrl.text,
                    'feeMin': _feeRange.start.round(),
                    'feeMax': _feeRange.end.round(),
                    'minRating': _minRating,
                    'availableToday': _availableToday,
                    'acceptingClients': _acceptingClients,
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B00),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.tune, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        _activeFilterCount > 0
                            ? 'Apply Filters ($_activeFilterCount active)'
                            : 'Apply Filters',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFFFF6B00),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}

class _CheckboxTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  const _CheckboxTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value
                ? const Color(0xFFFF6B00).withValues(alpha: 0.4)
                : const Color(0xFF252525),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: value ? const Color(0xFFFF6B00) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: value
                      ? const Color(0xFFFF6B00)
                      : const Color(0xFF3A3A3A),
                  width: 2,
                ),
              ),
              child: value
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: value ? Colors.white : const Color(0xFF9E9E9E),
                fontSize: 14,
                fontWeight: value ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple map painter for the map preview
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF1E2830);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    final roadPaint = Paint()
      ..color = const Color(0xFF2A3A45)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.25),
      Offset(size.width, size.height * 0.25),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.75),
      roadPaint,
    );

    final pinPaint = Paint()..color = const Color(0xFFFF6B00);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 8, pinPaint);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      4,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
