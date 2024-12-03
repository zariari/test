import 'package:flutter/material.dart';
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Access the theme provider
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding based on screen width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color.fromARGB(255, 0, 0, 0), width: 2), // Blue border (#9de9ff)
        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Background color blue (#0a4c86)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Adjust border radius dynamically if needed
        child: Image.asset(
          'assets/images/map.png',
          fit: BoxFit.cover,
          height: screenHeight * 0.3, // Dynamically adjust image height
          width: double.infinity, // Make the image full-width of the container
        ),
      ),
    );
  }
}
