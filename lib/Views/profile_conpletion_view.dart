import 'package:flutter/material.dart';
import 'muscle_selection_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileCompletionView extends StatefulWidget {
  final String fullName;
  final String weight;  // Agregado: recibir el peso
  final String height;  // Agregado: recibir la altura
  final String gender;

  ProfileCompletionView({
    required this.fullName,
    required this.weight,
    required this.height,
    required this.gender,
  });

  @override
  _ProfileCompletionViewState createState() => _ProfileCompletionViewState();
}

class _ProfileCompletionViewState extends State<ProfileCompletionView> {
  // Controladores para los campos de texto
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  File? _image; // Almacena la imagen seleccionada

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.fullName; // Inicializar el controlador con el nombre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellowAccent),
          onPressed: () {
            Navigator.pop(context); // Volver atrás
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Completa Tu Perfil',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            // Foto de perfil
            GestureDetector(
              onTap: _pickImage, // Selecciona imagen al hacer clic
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _image != null
                    ? FileImage(_image!) // Muestra la imagen seleccionada
                    : const AssetImage('assets/images/default_profile.jpg')
                        as ImageProvider, // Imagen por defecto
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.yellowAccent,
                    child: Icon(Icons.camera_alt, color: Colors.black, size: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Campos del perfil
            _buildTextField('Full name', fullNameController),
            const SizedBox(height: 15.0),
            _buildTextField('Nickname', nicknameController),
            const SizedBox(height: 15.0),
            _buildTextField('Email', emailController),
            const SizedBox(height: 15.0),
            _buildTextField('Mobile Number', mobileNumberController),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar "Start"
                print('Perfil Completado: ${fullNameController.text}, ${nicknameController.text}, ${emailController.text}, ${mobileNumberController.text}');
                
                // Navegar a MuscleSelectionView pasando los datos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MuscleSelectionView(
                      fullName: fullNameController.text,
                      weight: widget.weight,  // Pasar el peso desde ProfileCompletionView
                      height: widget.height,  // Pasar la altura desde ProfileCompletionView
                      gender: widget.gender,  // Pasar el género
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir los campos de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
