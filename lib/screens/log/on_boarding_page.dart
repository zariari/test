import 'package:flutter/material.dart';
import 'package:lockergo/screens/log/ob_boarding_page_2.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                      height: screenHeight * 0.3, // Keep dynamic height for the upper image
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.05, // Adjusting logo position closer to the top
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.15, // Keep dynamic logo size
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10), // Dynamic padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tu aliado para reservar lockers en tu universidad,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0a4c86),
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Rápido\n',
                          style: TextStyle(color: Color(0xFFf39200)),
                        ),
                        TextSpan(
                          text: 'y\n',
                          style: TextStyle(
                            color: Color(0xFF0a4c86),
                            fontSize: 40,
                          ),
                        ),
                        TextSpan(
                          text: 'Fácil',
                          style: TextStyle(color: Color(0xFFf39200)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03), // Dynamic padding
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LockerReservationPromptPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39200),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 12), // Dynamic button padding
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
    );
  }
}
