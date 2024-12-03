import 'package:flutter/material.dart';
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
                child: const Icon(Icons.check_circle,
                    color: Colors.green, size: 50),
              ),
              const Text(
                'Los cambios en tu perfil se han guardado con éxito.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: const Color.fromARGB(255, 123, 123, 123),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
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

  void _showSaveConfirmation(BuildContext context) {
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
                child:
                    const Icon(Icons.thumb_up, color: Colors.orange, size: 50),
              ),
              const Text(
                '¿Deseas guardar los cambios en tu perfil?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access the theme provider

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          height: screenHeight * 0.04, // Dynamically adjust the logo size
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding
            margin: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenHeight * 0.02), // Dynamic margins
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: themeProvider.isDarkMode
                    ? const Color(0xFF9de9ff)
                    : const Color.fromARGB(255, 0, 0, 0), // Blue border
                width: 2,
              ),
              color: themeProvider.isDarkMode
                  ? const Color(0xFF0a4c86)
                  : Colors.white, // Background color in night mode
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Tu perfil',
                    style: TextStyle(
                      fontSize:
                          screenHeight * 0.030, // Dynamically adjust font size
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0,
                              0), // Blue for normal mode and white for night mode
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: themeProvider.isDarkMode
                        ? const Color(0xFF9de9ff)
                        : const Color.fromARGB(255, 0, 0,
                            0), // Background color for the icon in night mode
                    child: Icon(Icons.person,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFF0a4c86)
                            : const Color.fromARGB(255, 255, 255, 255),
                        size: 35), // Person icon color in night mode
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    'Cédula',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFF9de9ff)
                          : const Color.fromARGB(255, 0, 0,
                              0), // Blue for normal mode and white for night mode
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Nombre Apellido:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFF9de9ff)
                          : const Color.fromARGB(
                              255, 0, 0, 0)), // Blue for night mode
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Contraseña:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFF9de9ff)
                          : const Color.fromARGB(
                              255, 0, 0, 0)), // Blue for night mode
                ),
                const SizedBox(height: 5),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Confirmar contraseña:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFF9de9ff)
                          : const Color.fromARGB(
                              255, 0, 0, 0)), // Blue for night mode
                ),
                const SizedBox(height: 5),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: themeProvider.isDarkMode
                              ? const Color(0xFF9de9ff)
                              : const Color.fromARGB(
                                  255, 0, 0, 0)), // Blue for night mode
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Space before buttons

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 123, 123, 123),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08,
                            vertical: screenHeight * 0.010), // Adjusted padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                        fontSize: 18,
                        color: themeProvider.isDarkMode
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 255, 255, 255)),    
                        ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showSaveConfirmation(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.isDarkMode
                            ? const Color(0xFF9de9ff)
                            : const Color(0xFF0a4c86),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08,
                            vertical: screenHeight * 0.010),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                            fontSize: 18,
                            color: themeProvider.isDarkMode
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
