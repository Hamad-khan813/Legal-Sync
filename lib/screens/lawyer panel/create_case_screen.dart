import 'package:flutter/material.dart';

class CreateCaseScreen extends StatefulWidget {
  const CreateCaseScreen({super.key});

  @override
  State<CreateCaseScreen> createState() => _CreateCaseScreenState();
}

class _CreateCaseScreenState extends State<CreateCaseScreen> {
  String _billingType = 'Hourly Rate';
  String _estimatedDuration = '1-3 Months';
  String _selectedCaseType = 'Select case type';

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
          'Create Case',
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
          children: [
            _buildSection(
              header: 'Client Name',
              child: _buildInputField(
                hint: 'Search or enter client name',
                prefixIcon: Icons.search,
                controller: TextEditingController(),
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              header: 'Case Type',
              child: _buildDropdownField(
                value: _selectedCaseType,
                items: [
                  'Select case type',
                  'Divorce Law',
                  'Criminal Law',
                  'Corporate Litigation',
                  'Real Estate Law',
                  'Intellectual Property',
                ],
                onChanged: (val) {
                  setState(() {
                    _selectedCaseType = val!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              header: 'Case Title / Reference',
              child: _buildInputField(
                hint: 'e.g. Smith v. Johnson Real Estate Dispute',
                controller: TextEditingController(),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(Icons.description_outlined, 'Case Details'),
            const SizedBox(height: 12),
            _buildSection(
              header: 'Description of Matter',
              child: _buildInputField(
                hint: 'Briefly describe the legal matter and objectives...',
                controller: TextEditingController(),
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              header: 'Internal Reference ID',
              child: _buildInputField(
                hint: 'REF-2024-001',
                controller: TextEditingController(text: 'REF-2024-001'),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              header: 'Estimated Duration',
              child: _buildDropdownField(
                value: _estimatedDuration,
                items: ['1-3 Months', '3-6 Months', '6-12 Months', '1 Year+'],
                onChanged: (val) {
                  setState(() {
                    _estimatedDuration = val!;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(Icons.receipt_long_outlined, 'Fee & Agreement'),
            const SizedBox(height: 12),
            _buildSection(
              header: 'Billing Type',
              child: Row(
                children: [
                  _buildBillingButton('Hourly Rate'),
                  const SizedBox(width: 12),
                  _buildBillingButton('Flat Fee'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_billingType == 'Hourly Rate')
              _buildSection(
                header: 'Hourly Rate (USD)',
                child: _buildInputField(
                  hint: '0.00',
                  prefixIcon: Icons.attach_money,
                  controller: TextEditingController(text: '350.00'),
                ),
              ),
            const SizedBox(height: 20),
            _buildSection(
              header: 'Engagement Letter',
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Upload Engagement Letter',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PDF, Word, or Scanned Document',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 150,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFFF6B00)),
                          ),
                          child: const Text(
                            'Browse Files',
                            style: TextStyle(color: Color(0xFFFF6B00)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save as Draft',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Case created successfully!'),
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
                    child: const Text(
                      'Next Step',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B00).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFFF6B00), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String header, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildInputField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey.shade400, size: 20)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildBillingButton(String label) {
    bool isSelected = _billingType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _billingType = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF6B00) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFFF6B00)
                  : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
