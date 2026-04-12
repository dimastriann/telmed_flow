import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';
import 'package:telmed_mobile/features/appointments/presentation/screens/appointment_success_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const BookingScreen({super.key, required this.doctor});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedDateIndex = 0;
  String? _selectedTime;

  final List<String> _dates = ['Mon, 12 Oct', 'Tue, 13 Oct', 'Wed, 14 Oct', 'Thu, 15 Oct', 'Fri, 16 Oct'];
  final List<String> _times = ['09:00 AM', '10:00 AM', '11:30 AM', '02:00 PM', '03:30 PM', '05:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Book Schedule'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textMain,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Select Date Title
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          // Date Selection
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedDateIndex == index;
                List<String> parts = _dates[index].split(', ');
                return GestureDetector(
                  onTap: () => setState(() => _selectedDateIndex = index),
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGreen : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          parts[0].substring(0, 3),
                          style: TextStyle(color: isSelected ? Colors.white70 : AppColors.textSecondary, fontSize: 12),
                        ),
                        Text(
                          parts[1].split(' ')[0],
                          style: TextStyle(color: isSelected ? Colors.white : AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Select Time Title
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Available Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          // Time Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _times.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedTime == _times[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = _times[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGreen : Colors.white,
                      border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _times[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textMain,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedTime == null ? null : () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentSuccessScreen(
                        doctor: widget.doctor,
                        date: _dates[_selectedDateIndex],
                        time: _selectedTime!,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
