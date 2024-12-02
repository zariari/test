import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockergo/custom_bottom_navigation_bar.dart';
import 'package:lockergo/screens/profile/user_profile.dart';

class LockerSelectionScreen extends StatefulWidget {
  final String facultyName;
  final String floorNumber;
  final String section;
  final int sectionId;

  const LockerSelectionScreen({
    super.key,
    required this.facultyName,
    required this.floorNumber,
    required this.section,
    required this.sectionId,
  });

  @override
  State<LockerSelectionScreen> createState() => _LockerSelectionScreenState();
}

class _LockerSelectionScreenState extends State<LockerSelectionScreen> {
  List<dynamic> lockers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLockers();
  }

  Future<void> fetchLockers() async {
    try {
      final url = Uri.parse(
          'http://pagueya-001-site3.mtempurl.com/api/locker/${widget.sectionId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          lockers = data;
          isLoading = false;
        });
        debugPrint('Lockers loaded: $lockers');
      } else {
        throw Exception('Failed to load lockers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching lockers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          height: screenHeight * 0.04, // Dynamically adjust logo size
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10), // Dynamic padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Selecciona tu Locker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 20),
            Text(
              'Facultad de ${widget.facultyName}\n${widget.floorNumber}\n${widget.section}',
              style: TextStyle(
                fontSize: screenHeight * 0.025, // Dynamically adjust font size
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0a4c86),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.05, 
                        right: screenWidth * 0.05,
                        bottom: screenHeight * 0.02, // Reduce bottom padding to move the grid closer to the line
                      ), // Dynamic padding
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: lockers.length,
                      itemBuilder: (context, index) {
                        final locker = lockers[index];
                        return LockerTile(
                          lockerNumber: locker['locker_number'],
                          isAvailable: !locker['is_reserved'],
                          section: widget.section,
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black, thickness: 5),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Lockers en ',
                  ),
                  TextSpan(
                    text: 'verde',
                    style: TextStyle(color: Colors.green), // Green color for available lockers
                  ),
                  TextSpan(
                    text: ' están disponibles \n Lockers en ',
                  ),
                  TextSpan(
                    text: 'gris',
                    style: TextStyle(color: Colors.grey), // Gray color for reserved lockers
                  ),
                  TextSpan(
                    text: ' ya están reservados',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}

class LockerTile extends StatelessWidget {
  final int lockerNumber;
  final bool isAvailable;
  final String section;

  const LockerTile({
    super.key,
    required this.lockerNumber,
    required this.isAvailable,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          _showConfirmationModal(context, lockerNumber, section);
        } else {
          _showErrorModal(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isAvailable
              ? const Color.fromARGB(255, 96, 206, 100)
              : const Color.fromARGB(255, 150, 145, 145),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF0a4c86), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$lockerNumber',
            style: TextStyle(
              fontSize: screenWidth * 0.065, // Dynamically adjust font size
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0a4c86),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationModal(BuildContext context, int lockerNumber, String section) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.thumb_up, color: Colors.orange, size: 50),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(text: 'Has seleccionado el locker '),
                    TextSpan(
                      text: '$section-$lockerNumber',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '.\nPor favor, confirma tu reserva.'),
                  ],
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 123, 123, 123),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0a4c86),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessModal(context);
              },
              child: const Text(
                'Confirmar',
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text(
                'Tu locker ha sido reservado con éxito.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 123, 123, 123),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
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

  void _showErrorModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 10),
              Text(
                'Este locker ya está reservado. Por favor, selecciona otro locker.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 123, 123, 123),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
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
}
