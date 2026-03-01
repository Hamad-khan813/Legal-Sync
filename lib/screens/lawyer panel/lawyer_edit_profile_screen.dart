import 'package:flutter/material.dart';

class LawyerEditProfileScreen extends StatefulWidget {
  const LawyerEditProfileScreen({super.key});

  @override
  State<LawyerEditProfileScreen> createState() =>
      _LawyerEditProfileScreenState();
}

class _LawyerEditProfileScreenState extends State<LawyerEditProfileScreen> {
  final List<String> _specializations = [
    'Corporate Law',
    'Intellectual Property',
    'Litigation',
    'M&A',
    'Taxation',
  ];

  final List<String> _selectedSpecializations = [
    'Corporate Law',
    'Litigation',
    'M&A',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6B00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildInputField(
              label: 'FULL NAME',
              hint: 'Jonathan Sterling, Esq.',
              controller: TextEditingController(
                text: 'Jonathan Sterling, Esq.',
              ),
            ),
            const SizedBox(height: 20),

            _buildInputField(
              label: 'EMAIL ADDRESS',
              hint: 'j.sterling@lawfirm.com',
              controller: TextEditingController(text: 'j.sterling@lawfirm.com'),
            ),
            const SizedBox(height: 20),

            _buildInputField(
              label: 'STATE BAR NUMBER',
              hint: 'CA-983241',
              controller: TextEditingController(text: 'CA-983241'),
              suffixIcon: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'AREA OF SPECIALIZATION',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._specializations.map((spec) => _buildSpecChip(spec)),
                _buildAddSpecChip(),
              ],
            ),
            const SizedBox(height: 20),

            _buildInputField(
              label: 'MOBILE NUMBER',
              hint: '+1 (555) 012-3456',
              controller: TextEditingController(text: '+1 (555) 012-3456'),
            ),
            const SizedBox(height: 20),

            _buildInputField(
              label: 'OFFICE ADDRESS',
              hint: 'Suite 400, Financial District\nSan Francisco, CA 94111',
              controller: TextEditingController(
                text: 'Suite 400, Financial District\nSan Francisco, CA 94111',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Save Professional Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF6B00)),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecChip(String spec) {
    bool isSelected = _selectedSpecializations.contains(spec);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSpecializations.remove(spec);
          } else {
            _selectedSpecializations.add(spec);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B00) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B00) : Colors.grey.shade200,
          ),
        ),
        child: Text(
          spec,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAddSpecChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFFF6B00),
          style: BorderStyle.solid,
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Color(0xFFFF6B00), size: 16),
          SizedBox(width: 4),
          Text(
            'Add',
            style: TextStyle(
              color: Color(0xFFFF6B00),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
