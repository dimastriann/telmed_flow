import 'package:flutter/material.dart';
import 'package:telmed_mobile/core/constants/colors.dart';

class CallingScreen extends StatelessWidget {
  final String doctorName;
  final String imageUrl;
  final bool isVideo;

  const CallingScreen({
    super.key,
    required this.doctorName,
    required this.imageUrl,
    this.isVideo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background - Semi-transparent image or black
          if (isVideo)
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
          
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Avatar with Pulse Animation Placeholder
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(height: 24),
                Text(
                  doctorName,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  isVideo ? 'Video Calling...' : 'Voice Calling...',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Spacer(),
                
                // Controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallControl(Icons.mic_off, Colors.white24, () {}),
                      _buildCallControl(Icons.call_end, Colors.red, () => Navigator.pop(context)),
                      _buildCallControl(Icons.volume_up, Colors.white24, () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallControl(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }
}
