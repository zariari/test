import 'package:flutter/material.dart';
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/start.dart'; // Import your start screen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Provide the ThemeProvider at the root
      child: const MyApp(), // Your root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Access the ThemeProvider

    return MaterialApp(
      title: 'LockerGO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(), // Define dark theme
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Toggle theme mode
      debugShowCheckedModeBanner: false,
      home: const StartPage(), // Start screen of your app
    );
  }
}
