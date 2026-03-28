import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telmed_mobile/core/state/auth_provider.dart';
import 'package:telmed_mobile/features/auth/presentation/screens/landing_screen.dart';
import 'package:telmed_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TelMedFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1DB98F)),
        useMaterial3: true,
        fontFamily: 'Roboto', 
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isLoggedIn ? const DashboardScreen() : const LandingScreen();
        },
      ),
    );
  }
}
