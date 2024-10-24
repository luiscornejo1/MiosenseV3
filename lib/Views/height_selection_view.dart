import 'package:flutter/material.dart';
import 'package:miosense/Views/profile_conpletion_view.dart';

class HeightSelectionView extends StatefulWidget {
  final String fullName;
  final String weight;  // Recibir el peso
  final String gender;

  const HeightSelectionView({
    required this.fullName,
    required this.weight,
    required this.gender,
    super.key,
  });

  @override
  _HeightSelectionViewState createState() => _HeightSelectionViewState();
}

class _HeightSelectionViewState extends State<HeightSelectionView> {
  double selectedHeight = 155; // Altura seleccionada por defecto

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
            Navigator.pop(context); // Acción para volver atrás
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Cual Es Tu Altura???',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '${selectedHeight.toStringAsFixed(0)} Cm',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 200,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedHeight = 155.0 + index;
                });
              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      '${155 + index}', // Rango de 155 a 175 cm
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  );
                },
                childCount: 21, // Muestra el rango de 155 a 175 cm
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Navegar a ProfileCompletionView pasando la altura seleccionada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileCompletionView(
                    fullName: widget.fullName,
                    weight: widget.weight,  // Pasar el peso desde WeightSelectionView
                    height: selectedHeight.toString(),  // Pasar la altura seleccionada
                    gender: widget.gender,  // Pasar el género
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCEFF00)),
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
