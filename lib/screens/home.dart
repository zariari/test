import 'package:flutter/material.dart';
import 'package:lockergo/custom_bottom_navigation_bar.dart';
import 'package:lockergo/screens/lockers/faculty.dart';

class LockerReservationPage extends StatelessWidget {
  const LockerReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/header.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_name_black.png',
          height: screenHeight * 0.04, // Dynamically adjust logo size
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Bienvenido Nombre',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Reservar tu\nLocker Universitario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/locker_image.png',
              height: screenHeight * 0.25, // 25% of screen height for image
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Total Lockers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const Text(
              '1200',
              style: TextStyle(fontSize: 68, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const Text(
              'Periodo Academica 2024-2025',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FacultyScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf39200), 
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 10), // Dynamic padding based on screen width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Reserva tu Locker Ya!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '¿Necesitas ayuda con tu reserva?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Contáctanos en ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'soporte@lockergo.com',
                    style: TextStyle(fontSize: 16, color: Color(0xFF0a4c86)),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
