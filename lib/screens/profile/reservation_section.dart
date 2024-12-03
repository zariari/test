import 'package:flutter/material.dart';
import 'package:lockergo/screens/lockers/faculty.dart';
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';

class ReservationsSection extends StatelessWidget {
  const ReservationsSection({super.key});

  void _navigateToFacultyScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FacultyScreen()),
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
                child: const Icon(Icons.thumb_up, color: Colors.orange, size: 50),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(text: 'Estás a punto de eliminar tu reserva.\n'),
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
                _showSuccessModal(context);
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

  void _showSuccessModal(BuildContext context) {
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
                child: const Icon(Icons.check_circle, color: Colors.green, size: 50),
              ),
              const Text(
                'Tu reserva ha sido eliminada con éxito.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
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
                'Cerrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showQRDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow tapping outside to close the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Muestra el código QR en tu asociación de facultad para realizar el pago',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/qr_code_sample.png', // Replace with your QR code image path
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.3, // Adjust height dynamically
                  width: MediaQuery.of(context).size.width * 0.6, // Adjust width dynamically
                ),
              ],
            ),
          ),
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
                'Tus reservas',
                style: TextStyle(
                  fontSize: screenHeight * 0.030, // Dynamically adjust font size
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Color.fromARGB(255, 0, 0, 0), // Blue for normal mode and white for night mode
                ),
              ),
              Row(
                children: [
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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => _navigateToFacultyScreen(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02), // Dynamic padding
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Color(0xFF9de9ff) : Color(0xFF0a4c86), // Blue background
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Número del Locker',
                      style: TextStyle(
                        fontSize: screenHeight * 0.018, // Dynamically adjust font size
                        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Blue background
                      ),
                    ),
                    Text(
                      'Estado de Reserva',
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Blue background
                      ),
                    ),
                    Text(
                      'Periodo',
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Blue background
                      ),
                    ),
                    Text(
                      'Ubicación',
                      style: TextStyle(
                        fontSize: screenHeight * 0.018,
                        color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Blue background
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showQRDialog(context), // Show the enlarged QR code dialog
                  child: Icon(
                    Icons.qr_code,
                    size: screenHeight * 0.1, // Dynamically adjust icon size
                    color: themeProvider.isDarkMode ? Color(0xFF0a4c86) : Colors.white, // Blue background
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
