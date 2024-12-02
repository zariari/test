import 'package:flutter/material.dart';
import 'package:lockergo/screens/log/login.dart'; 
import 'package:lockergo/screens/terms_conditions.dart'; 

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/upper_image.png',
                          fit: BoxFit.cover,
                          height: screenHeight * 0.3, // Adjust height of the upper image as needed
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.05, // Move the logo closer to the top edge
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: screenHeight * 0.15, // Adjust the logo height as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 50), // Dynamic padding
                    child: Column(
                      children: [
                        const Text(
                          'Regístrate en LockerGo',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField('Nombres', 'Nombres', TextInputType.text),
                        const SizedBox(height: 20),
                        _buildTextField('Apellidos', 'Apellidos', TextInputType.text),
                        const SizedBox(height: 20),
                        _buildTextField('Cédula', '1234567890', TextInputType.number),
                        const SizedBox(height: 20),
                        _buildTextField('Contraseña', 'Abc123@', TextInputType.text, isPassword: true),
                        const SizedBox(height: 20),
                        _buildTextField('Confirmar contraseña', 'Abc123@', TextInputType.text, isPassword: true),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TermsAndConditionsPage(), 
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0a4c86),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 12), // Dynamic button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/lower_image.png',
                  fit: BoxFit.cover,
                  height: screenHeight * 0.2, // Dynamic footer image size
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes una cuenta? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(), 
                          ),
                        );
                      },
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(
                          color: Color(0xFF0a4c86),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hintText, TextInputType keyboardType, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }
}
