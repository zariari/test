import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockergo/custom_bottom_navigation_bar.dart';
import 'package:lockergo/screens/lockers/section.dart';

class FloorSelectionScreen extends StatefulWidget {
  final int facultyId; // Cambiar a ID de la facultad
  final String facultyName;

  const FloorSelectionScreen({
    super.key,
    required this.facultyId,
    required this.facultyName,
  });

  @override
  State<FloorSelectionScreen> createState() => _FloorSelectionScreenState();
}

class _FloorSelectionScreenState extends State<FloorSelectionScreen> {
  List<dynamic> floors = []; // Adaptar para aceptar JSON de la API
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFloors();
  }

  Future<void> fetchFloors() async {
    try {
      // Construir la URL usando el facultyId
      final url = Uri.parse(
          'http://pagueya-001-site3.mtempurl.com/api/pisos/${widget.facultyId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          floors = data; // Guardar la lista completa de pisos desde la API
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load floors');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching floors: $e');
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
            Center(
              child: Text(
                'Facultad de ${widget.facultyName}',
                style: TextStyle(
                  fontSize: screenHeight * 0.03, // Dynamic font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            const Center(
              child: Text(
                'Selecciona el piso',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : floors.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay pisos disponibles.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: floors.length,
                          itemBuilder: (context, index) {
                            final floor = floors[index];
                            return FloorTile(
                              facultyName: widget.facultyName,
                              floorNumber: floor['floor_number'],
                              floorId: floor['id'],
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}

class FloorTile extends StatelessWidget {
  final String facultyName;
  final String floorNumber;
  final int floorId; // Agregado para pasar el ID del piso

  const FloorTile({
    super.key,
    required this.facultyName,
    required this.floorNumber,
    required this.floorId,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 8), // Dynamic padding
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF0a4c86), width: 2.0),
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SectionSelectionScreen(
                  facultyName: facultyName,
                  floorNumber: floorNumber,
                  floorId: floorId, // Pasar floorId al siguiente widget
                ),
              ),
            );
          },
          title: Center(
            child: Text(
              floorNumber,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0a4c86),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
