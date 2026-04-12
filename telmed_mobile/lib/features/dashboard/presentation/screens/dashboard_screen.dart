import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telmed_mobile/core/constants/colors.dart';
import 'package:telmed_mobile/core/state/auth_provider.dart';
import 'package:telmed_mobile/features/dashboard/presentation/widgets/appointment_card.dart';
import 'package:telmed_mobile/features/dashboard/presentation/widgets/vital_card.dart';
import 'package:telmed_mobile/features/messages/presentation/screens/message_screen.dart';
import 'package:telmed_mobile/features/appointments/presentation/screens/appointment_list_screen.dart';
import 'package:telmed_mobile/features/appointments/presentation/screens/doctor_list_screen.dart';
import 'package:telmed_mobile/features/profile/presentation/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardContent(),
    const MessageScreen(),
    const AppointmentListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'TelMedFlow' : ['Home', 'Messages', 'Appointments', 'Profile'][_currentIndex]),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_currentIndex == 3 ? Icons.info_outline : Icons.notifications_none),
            onPressed: () {
              if (_currentIndex == 3) {
                _showInfoModal(context);
              } else {
                _showNotificationsModal(context);
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=currentuser'),
              ),
              accountName: Text(auth.currentAccount, style: const TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('${auth.currentAccount.toLowerCase().replaceAll(' ', '.')}@example.com'),
              decoration: const BoxDecoration(color: AppColors.primaryGreen),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Switch Account', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                  ),
                  ...auth.accounts.map((account) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: account == auth.currentAccount ? AppColors.primaryGreen : Colors.grey[200],
                      child: Text(account[0], style: TextStyle(color: account == auth.currentAccount ? Colors.white : Colors.black)),
                    ),
                    title: Text(account, style: TextStyle(fontWeight: account == auth.currentAccount ? FontWeight.bold : FontWeight.normal)),
                    onTap: () {
                      auth.switchAccount(account);
                      Navigator.pop(context);
                    },
                  )),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.add, color: AppColors.primaryGreen),
                    title: const Text('Add Account'),
                    onTap: () {
                      auth.addAccount('Family Member ${auth.accounts.length + 1}');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                auth.logout();
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  void _showInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.primaryGreen),
            SizedBox(width: 10),
            Text('App Information'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TelMedFlow Mobile', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Version: 1.0.0'),
            SizedBox(height: 12),
            Text('Developed for seamless telemedicine experience connecting patients with expert doctors and AI diagnostics.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
  }

  void _showNotificationsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.notifications_none, color: AppColors.primaryGreen),
            SizedBox(width: 10),
            Text('Notifications'),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildNotificationItem('Appointment Confirmed', 'Your appointment with Dr. Smith is confirmed for tomorrow at 2:00 PM.'),
              const Divider(),
              _buildNotificationItem('New Prescription', 'Dr. Smith has sent you a new digital prescription.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Welcome Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${context.watch<AuthProvider>().currentAccount}!',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text('How are you feeling today?', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
                const Icon(Icons.notifications_none, size: 28, color: AppColors.textMain),
              ],
            ),
            const SizedBox(height: 32),
            
            // Upcoming appointment section
            const Text(
              'Upcoming appointment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),
            const AppointmentCard(
              date: 'Oct 26',
              time: '2:00 PM',
              doctorName: 'Dr. Smith',
              avatarUrl: 'https://i.pravatar.cc/150?u=drsmith',
            ),
            
            const SizedBox(height: 24),
            // Start Consultation Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text('Start consultation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
            
            // Vitals Section
            const Text(
              'Vitals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VitalCard(
                  title: 'Heart Rate',
                  value: '72',
                  unit: 'bpm',
                  icon: Icons.favorite,
                  iconColor: AppColors.accentRed,
                ),
                VitalCard(
                  title: 'Blood Pressure',
                  value: '120/80',
                  unit: 'mmHg',
                  icon: Icons.health_and_safety,
                  iconColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
