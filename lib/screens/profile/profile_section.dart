import 'package:flutter/material.dart';
import 'package:lockergo/screens/log/login.dart';
import 'package:lockergo/screens/profile/user_edit.dart';
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _navigateToEditProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, 
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: const Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 50),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(text: 'Estás a punto de eliminar tu cuenta.\n'),
                    TextSpan(
                      text: 'Esta acción es irreversible.\n',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '¿Estás seguro de que deseas continuar?',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: const Color.fromARGB(255, 123, 123, 123),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: const Color(0xFF0a4c86),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Access the theme provider

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color.fromARGB(255, 0, 0, 0), // Blue border
          width: 2,
        ),
        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Background color in night mode
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu perfil',
                style: TextStyle(
                  fontSize: screenHeight * 0.030,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Color.fromARGB(255, 0, 0, 0), // Blue for normal mode and white for night mode
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Align icons to the right
                children: [
                  GestureDetector(
                    onTap: () {
                      themeProvider.toggleTheme(); // Toggle the theme
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black, // White background for dark mode, black for light mode
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        themeProvider.isDarkMode
                            ? Icons.wb_sunny // Sun icon for light mode
                            : Icons.nightlight_round, // Moon icon for dark mode
                        color: themeProvider.isDarkMode ? Colors.black : Colors.white, // Black icon for dark mode, white for light mode
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => _showDeleteConfirmation(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => _navigateToEditProfilePage(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                  onTap: () => _logout(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color(0xFF0a4c86),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.power_settings_new,
                      color: themeProvider.isDarkMode ? Colors.black : Colors.white, // Black icon for night mode
                    ),
                  ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color.fromARGB(255, 0, 0, 0), // Background color for the icon in night mode
                  child: Icon(Icons.person, color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Color.fromARGB(255, 255, 255, 255), size: 35), // Person icon color in night mode
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre Apellido',
                    style: TextStyle(
                      fontSize: screenHeight * 0.018,
                      color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color.fromARGB(255, 0, 0, 0), // Blue for normal mode and white for night mode
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Cédula',
                    style: TextStyle(
                      fontSize: screenHeight * 0.018,
                      color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color.fromARGB(255, 0, 0, 0), // Blue for normal mode and white for night mode
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
