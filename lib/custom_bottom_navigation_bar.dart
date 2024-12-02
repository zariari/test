// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:lockergo/screens/home.dart';
import 'package:lockergo/screens/lockers/faculty.dart';
import 'package:lockergo/screens/profile/user_profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0a4c86), 
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.4),
      currentIndex: currentIndex,
      iconSize: 28, 
      selectedFontSize: 14, 
      unselectedFontSize: 12, 
      onTap: (index) {
        if (index == currentIndex) return;

        Widget page = const LockerReservationPage(); 

        switch (index) {
          case 0:
            page = const LockerReservationPage();
            break;
          case 1:
            page = const FacultyScreen();
            break;
          case 2:
            page = const ProfilePage();
            break;
        }

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Lockers'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
