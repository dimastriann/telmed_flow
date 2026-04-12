import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telmed_mobile/core/constants/colors.dart';
import 'package:telmed_mobile/core/state/auth_provider.dart';
import 'package:telmed_mobile/features/medical_records/presentation/screens/medical_record_screen.dart';
import 'package:telmed_mobile/features/prescriptions/presentation/screens/prescription_screen.dart';
import 'package:telmed_mobile/features/profile/presentation/screens/personal_info_screen.dart';
import 'package:telmed_mobile/features/profile/presentation/screens/settings_screen.dart';
import 'package:telmed_mobile/features/profile/presentation/screens/help_center_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=currentuser'),
          ),
          const SizedBox(height: 16),
          Text(
            auth.currentAccount,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '${auth.currentAccount.toLowerCase().replaceAll(' ', '.')}@example.com',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          _buildProfileItem(Icons.medical_services_outlined, 'Medical Records', () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicalRecordScreen()));
          }),
          _buildProfileItem(Icons.receipt_long_outlined, 'Prescriptions', () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const PrescriptionScreen()));
          }),
          _buildProfileItem(Icons.person_outline, 'Personal Info', () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoScreen()));
          }),
          _buildProfileItem(Icons.settings_outlined, 'Settings', () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
          _buildProfileItem(Icons.help_outline, 'Help Center', () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterScreen()));
          }),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGreen),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
