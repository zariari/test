import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lockergo/screens/log/login.dart';
import 'package:lockergo/screens/terms_conditions.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FocusNode _nombresFocusNode = FocusNode();
  final FocusNode _apellidosFocusNode = FocusNode();
  final FocusNode _cedulaFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isFooterVisible = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _nombresFocusNode.addListener(_onFocusChange);
    _apellidosFocusNode.addListener(_onFocusChange);
    _cedulaFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _confirmPasswordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _nombresFocusNode.dispose();
    _apellidosFocusNode.dispose();
    _cedulaFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFooterVisible = !_nombresFocusNode.hasFocus &&
          !_apellidosFocusNode.hasFocus &&
          !_cedulaFocusNode.hasFocus &&
          !_passwordFocusNode.hasFocus &&
          !_confirmPasswordFocusNode.hasFocus;
    });
  }

  Future<void> _registerUser() async {
    const String apiUrl = 'http://pagueya-001-site3.mtempurl.com/api/Usuario';

    final userData = {
      "first_name": _nameController.text.trim(),
      "last_name": _lastNameController.text.trim(),
      "cedula": _idController.text.trim(),
      "password": _passwordController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado exitosamente')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const TermsAndConditionsPage()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${errorData['ExceptionMessage']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con la API: $e')),
      );
    }
  }

  String? validateCedula(String? cedula) {
    if (cedula == null || cedula.isEmpty) {
      return 'La cédula es obligatoria.';
    }
    const int tamanoCedula = 10;
    const int numeroProvincia = 24;
    const int tercerDigito = 6;
    List<int> coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
    int total = 0;

    if (cedula.length != tamanoCedula || !RegExp(r'^\d+$').hasMatch(cedula)) {
      return 'La cédula debe contener exactamente 10 dígitos.';
    }

    int provincia = int.tryParse(cedula.substring(0, 2)) ?? -1;
    if (provincia <= 0 || provincia > numeroProvincia) {
      return 'Código de provincia inválido.';
    }

    int digitoTres = int.tryParse(cedula[2]) ?? -1;
    if (digitoTres >= tercerDigito || digitoTres < 0) {
      return 'El tercer dígito de la cédula no es válido.';
    }

    for (int i = 0; i < coeficientes.length; i++) {
      int digito = int.tryParse(cedula[i]) ?? -1;
      int valor = coeficientes[i] * digito;
      total += valor >= 10 ? valor - 9 : valor;
    }

    int digitoVerificador = (10 - (total % 10)) % 10;
    int digitoVerificadorRecibido = int.tryParse(cedula[9]) ?? -1;

    if (digitoVerificador != digitoVerificadorRecibido) {
      return 'Cédula inválida.';
    }

    return null;
  }

  void _submitForm() {
    if (_idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos.')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    _registerUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
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
                            height: screenHeight * 0.3,
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.05,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: screenHeight * 0.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05, vertical: 50),
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
                          _buildTextField(
                              'Nombres', 'Nombres', _nameController),
                          const SizedBox(height: 20),
                          _buildTextField(
                              'Apellidos', 'Apellidos', _lastNameController),
                          const SizedBox(height: 20),
                          _buildTextField('Cédula', '1234567890', _idController,
                              validateCedula),
                          const SizedBox(height: 20),
                          _buildPasswordField(
                              'Contraseña', 'Abc123@', _passwordController),
                          const SizedBox(height: 20),
                          _buildPasswordField('Confirmar contraseña', 'Abc123@',
                              _confirmPasswordController),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0a4c86),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.15, vertical: 12),
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
            if (_isFooterVisible)
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/lower_image.png',
                      fit: BoxFit.cover,
                      height: screenHeight * 0.2,
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
      ),
    );
  }

  Widget _buildTextField(
      String label, String hintText, TextEditingController controller,
      [String? Function(String?)? validator]) {
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
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPasswordField(
      String label, String hintText, TextEditingController controller) {
    return _buildTextField(label, hintText, controller);
  }
}
