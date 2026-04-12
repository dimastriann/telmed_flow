import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Personal Info'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildInfoCard([
              _buildInfoRow('Full Name', 'Dimas Triann'),
              _buildInfoRow('Email', 'dimas.triann@example.com'),
              _buildInfoRow('Phone', '+62 812 3456 7890'),
            ]),
            const SizedBox(height: 24),
            _buildInfoCard([
              _buildInfoRow('Gender', 'Male'),
              _buildInfoRow('Birthdate', 'May 12, 1995'),
              _buildInfoRow('Age', '30 Years'),
              _buildInfoRow('Place of Birth', 'Jakarta, Indonesia'),
            ]),
            const SizedBox(height: 24),
            _buildInfoCard([
              _buildInfoRow('ID Number', '3201************'),
              _buildInfoRow('Blood Type', 'O+'),
              _buildInfoRow('Height', '175 cm'),
              _buildInfoRow('Weight', '70 kg'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          int idx = entry.key;
          Widget child = entry.value;
          return Column(
            children: [
              child,
              if (idx < children.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textMain)),
      ],
    );
  }
}
