import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';
import 'package:telmed_mobile/features/messages/presentation/screens/chat_detail_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        final doctorName = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones'][index];
        final imageUrl = 'https://i.pravatar.cc/150?u=doctor$index';
        
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(
            'Dr. $doctorName',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('You: Thank you doctor!', maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('10:30 AM', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              if (index % 2 == 0)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle),
                  child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                  doctorName: 'Dr. $doctorName',
                  imageUrl: imageUrl,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
