// custom_header.dart
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100, 
      child: Stack(
        children: [
          Image.asset(
            'assets/images/header.png', 
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 20, 
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo_name_black.png', 
                height: 40, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
