import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';

class MedicalRecordDetailScreen extends StatelessWidget {
  final String title;
  final String date;

  const MedicalRecordDetailScreen({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Record Detail'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined, color: AppColors.primaryGreen),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading static PDF record...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Verified Record', style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
            const SizedBox(height: 32),

            _buildSectionTitle('Provider'),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=drjohnson')),
              title: Text('Dr. Johnson', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Cardiology Department'),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Clinical Notes'),
            const Text(
              'Patient reported mild chest pressure during exercise. Heart rate was stable at 72 bpm. No history of coronary disease found. Recommend follow-up in 2 weeks for stress test.',
              style: TextStyle(color: AppColors.textMain, height: 1.5),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Diagnosis'),
            _buildDiagnosisItem('I10', 'Essential (primary) hypertension'),
            _buildDiagnosisItem('R07.9', 'Chest pain, unspecified'),

            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share Record Securely'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryGreen,
                  side: const BorderSide(color: AppColors.primaryGreen),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title.toUpperCase(), style: const TextStyle(color: AppColors.textSecondary, letterSpacing: 1.2, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDiagnosisItem(String code, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
            child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(description)),
        ],
      ),
    );
  }
}
