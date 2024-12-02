import 'package:flutter/material.dart';
import 'package:lockergo/screens/log/ob_boarding_page_2.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 130, 
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            padding: const EdgeInsets.symmetric(vertical: 5.0), 
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LockerReservationPromptPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39200),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
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
            ),
          ),
        ],
      ),
    );
  }
}
