import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isBiometricEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD (\$)';
  
  // Mock check for hardware support
  final bool _deviceSupportsBiometrics = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _buildSectionHeader('General'),
          _buildSwitchTile(Icons.dark_mode_outlined, 'Dark Mode', _isDarkMode, (v) => setState(() => _isDarkMode = v)),
          _buildDropdownTile(Icons.language_outlined, 'Language', _selectedLanguage, ['English', 'Indonesian'], (v) => setState(() => _selectedLanguage = v!)),
          _buildDropdownTile(Icons.payments_outlined, 'Currency', _selectedCurrency, ['USD (\$)', 'IDR (Rp)'], (v) => setState(() => _selectedCurrency = v!)),
          
          const Divider(height: 32),
          _buildSectionHeader('Security'),
          _buildLinkTile(Icons.lock_outline, 'Change Password', () {}),
          if (_deviceSupportsBiometrics)
            _buildSwitchTile(Icons.fingerprint, 'Biometric Login', _isBiometricEnabled, (v) => setState(() => _isBiometricEnabled = v)),
          
          const Divider(height: 32),
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(Icons.notifications_active_outlined, 'Push Notifications', true, (v) {}),
          _buildSwitchTile(Icons.email_outlined, 'Email Updates', false, (v) {}),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Text(title, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: AppColors.textMain),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryGreen,
      ),
    );
  }

  Widget _buildDropdownTile(IconData icon, String title, String value, List<String> options, ValueChanged<String?> onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: AppColors.textMain),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        underline: Container(),
        onChanged: onChanged,
        items: options.map((String opt) {
          return DropdownMenuItem<String>(value: opt, child: Text(opt));
        }).toList(),
      ),
    );
  }

  Widget _buildLinkTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: AppColors.textMain),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
