import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockergo/custom_bottom_navigation_bar.dart';
import 'package:lockergo/screens/lockers/locker.dart';

class SectionSelectionScreen extends StatefulWidget {
  final String facultyName;
  final String floorNumber;
  final int floorId;

  const SectionSelectionScreen({
    super.key,
    required this.facultyName,
    required this.floorNumber,
    required this.floorId,
  });

  @override
  State<SectionSelectionScreen> createState() => _SectionSelectionScreenState();
}

class _SectionSelectionScreenState extends State<SectionSelectionScreen> {
  List<dynamic> sections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSections();
  }

  Future<void> fetchSections() async {
    try {
      final url = Uri.parse(
          'http://pagueya-001-site3.mtempurl.com/api/secciones/${widget.floorId}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          sections = data; // Guardar la lista de secciones desde la API
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load sections');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching sections: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          height: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                ' ${widget.floorNumber} de la facultad de ${widget.facultyName}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '¿Qué sección es la adecuada para ti?',
                style: TextStyle(fontSize: 17, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: sections.isEmpty
                        ? const Center(
                            child: Text(
                              'No hay secciones disponibles.',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: sections.length,
                            itemBuilder: (context, index) {
                              final section = sections[index];
                              return SectionTile(
                                facultyName: widget.facultyName,
                                floorNumber: widget.floorNumber,
                                sectionName: section['section_name'],
                                sectionId: section['id'], // Pasar el ID de la sección
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

class SectionTile extends StatelessWidget {
  final String facultyName;
  final String floorNumber;
  final String sectionName;
  final int sectionId; // Agregado para pasar el ID de la sección

  const SectionTile({
    super.key,
    required this.facultyName,
    required this.floorNumber,
    required this.sectionName,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
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
                builder: (context) => LockerSelectionScreen(
                  facultyName: facultyName,
                  floorNumber: floorNumber,
                  section: sectionName,
                  sectionId: sectionId, // Pasar el sectionId requerido
                ),
              ),
            );
          },
          title: Center(
            child: Text(
              sectionName,
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
