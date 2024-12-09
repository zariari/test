import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockergo/screens/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:lockergo/globals/globals.dart' as globals;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    const String apiUrl = 'http://pagueya-001-site3.mtempurl.com/api/Usuario';

    try {
      final response =
          await http.get(Uri.parse('$apiUrl/${globals.currentUserCedula}'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _firstNameController.text = userData['first_name'];
          _lastNameController.text = userData['last_name'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Error al cargar el perfil: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return null; // Permitir dejar el campo vacío si no se quiere actualizar
    }
    if (password.length < 8) {
      return 'Debe tener al menos 8 caracteres.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Debe incluir al menos una letra mayúscula.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Debe incluir al menos una letra minúscula.';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Debe incluir al menos un número.';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return 'Debe incluir al menos un carácter especial (!@#\$&*~).';
    }
    return null;
  }

  Future<void> _updateProfile() async {
    const String apiUrl = 'http://pagueya-001-site3.mtempurl.com/api/Usuario';

    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text.isNotEmpty &&
          _passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden.')),
        );
        return;
      }

      final updatedUser = {
        "cedula": globals.currentUserCedula,
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        if (_passwordController.text.isNotEmpty)
          "password": _passwordController.text.trim(),
      };

      try {
        final response = await http.put(
          Uri.parse('$apiUrl/${globals.currentUserCedula}'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(updatedUser),
        );

        if (response.statusCode == 200) {
          _showSuccessModal();
        } else {
          final errorData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Error al actualizar el perfil: ${errorData['message'] ?? 'No se pudo actualizar el perfil.'}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  void _showSuccessModal() {
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
                backgroundColor: const Color(0xFF0a4c86),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el modal
                Navigator.of(context)
                    .pop(true); // Regresa a la pantalla de perfil
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
          height: screenHeight * 0.04,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              margin: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: themeProvider.isDarkMode
                      ? const Color(0xFF9de9ff)
                      : const Color.fromARGB(255, 0, 0, 0),
                  width: 2,
                ),
                color: themeProvider.isDarkMode
                    ? const Color(0xFF0a4c86)
                    : Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(
                        fontSize: screenHeight * 0.030,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    'Cédula',
                    globals.currentUserCedula ?? 'Cargando...',
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    'Nombre',
                    _firstNameController.text,
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    'Apellido',
                    _lastNameController.text,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordField(
                    'Contraseña',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    toggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildPasswordField(
                    'Confirmar Contraseña',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    toggleObscure: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 123, 123, 123),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08,
                              vertical: screenHeight * 0.010),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _updateProfile,
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
                        child: const Text(
                          'Guardar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value,
      {TextEditingController? controller, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller ?? TextEditingController(text: value),
          enabled: enabled,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label,
      {required TextEditingController controller,
      required bool obscureText,
      required VoidCallback toggleObscure}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) => validatePassword(value),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: toggleObscure,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
