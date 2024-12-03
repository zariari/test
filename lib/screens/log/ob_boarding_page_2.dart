import 'package:flutter/material.dart';
import 'package:lockergo/screens/log/register.dart';

class LockerReservationPromptPage extends StatelessWidget {
  const LockerReservationPromptPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Theme(
      data: ThemeData.light(), // Force light theme for this page
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F9FF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRect(
                  child: Transform.translate(
                    offset: const Offset(0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/upper_image.png',
                        fit: BoxFit.cover,
                        height: screenHeight * 0.3, // Dynamic image height
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight *
                      0.05, // Position the logo based on screen height
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: screenHeight * 0.15, // Dynamic logo size
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.10), // Dynamic padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Reserva tu Locker Ahora!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFf39200),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/calendar_icon.png',
                      height: screenHeight * 0.22, // Dynamic icon size
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            // Next Button Section
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.03), // Dynamic padding
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf39200),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.10,
                      vertical: 10), // Dynamic button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Footer Image
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/lower_image.png',
                fit: BoxFit.cover,
                height: screenHeight * 0.15, // Dynamic footer image size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
