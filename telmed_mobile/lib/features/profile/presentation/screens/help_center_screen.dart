import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildContactSection(),
            const Divider(height: 48),
            _buildFAQSection(),
            const SizedBox(height: 48),
            const Text('App Version 1.0.0 (Build 2026)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildContactTile(Icons.headset_mic_outlined, 'Customer Support', '24/7 Live Chat', AppColors.primaryGreen),
          const SizedBox(height: 12),
          _buildContactTile(Icons.email_outlined, 'Email Feedback', 'dev@telmedflow.com', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.background),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ExpansionTile(
            title: Text('How to book an appointment?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Go to the Home or Appointments tab, select a doctor, and choose your preferred date and time.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Is my data protected?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Yes, we comply with HIPAA, GDPR, and Indonesian Law No. 27/2022 to ensure your privacy.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Can I get a refund?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Refunds are available for cancellations made at least 24 hours before the appointment.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
