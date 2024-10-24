import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miosense/Views/weight_selection_view.dart';

class AgeSelectionView extends StatefulWidget {
  final String gender; 
  const AgeSelectionView({super.key, required this.gender});
  
  @override
  _AgeSelectionViewState createState() => _AgeSelectionViewState();
}

class _AgeSelectionViewState extends State<AgeSelectionView> {
  int selectedAge = 18; // Edad seleccionada por defecto

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
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Indícanos Tu Edad',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30.0),
          Text(
            '$selectedAge',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.arrow_drop_up, color: Colors.yellowAccent, size: 40.0),
          const SizedBox(height: 20.0),
          // Implementación del selector CupertinoPicker
          SizedBox(
            height: 150.0,
            child: CupertinoPicker(
              backgroundColor: const Color(0xFF817DC0),
              itemExtent: 50, // Altura de cada ítem
              onSelectedItemChanged: (int index) {
                setState(() {
                  selectedAge = index + 18; // Ajustar el rango de edades
                });
              },
              children: List<Widget>.generate(100, (int index) {
                return Center(
                  child: Text(
                    (index + 18).toString(), // Genera las edades a partir de 18
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Acción al continuar
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> WeightSelectionView(fullName: '', height: '', gender: '',)),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Color.fromARGB(255, 58, 58, 58)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}