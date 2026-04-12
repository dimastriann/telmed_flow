import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';
import 'package:telmed_mobile/features/dashboard/presentation/widgets/appointment_card.dart';
import 'package:telmed_mobile/features/appointments/presentation/screens/doctor_list_screen.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: AppColors.primaryGreen,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primaryGreen,
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(24),
                    children: const [
                      AppointmentCard(
                        date: 'Oct 26',
                        time: '2:00 PM',
                        doctorName: 'Dr. Smith',
                        avatarUrl: 'https://i.pravatar.cc/150?u=drsmith',
                      ),
                      AppointmentCard(
                        date: 'Oct 28',
                        time: '10:00 AM',
                        doctorName: 'Dr. Johnson',
                        avatarUrl: 'https://i.pravatar.cc/150?u=drjohnson',
                      ),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.all(24),
                    children: const [
                      AppointmentCard(
                        date: 'Oct 20',
                        time: '4:00 PM',
                        doctorName: 'Dr. Williams',
                        avatarUrl: 'https://i.pravatar.cc/150?u=drwilliams',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorListScreen()),
          );
        },
        backgroundColor: AppColors.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Appointment', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
