import 'package:flutter/material.dart';
import 'package:miosense/Views/height_selection_view.dart';

class WeightSelectionView extends StatefulWidget {
  final String fullName;
  final String gender;

  WeightSelectionView({
    required this.fullName,
    required this.gender, required String height,
  });

  @override
  _WeightSelectionViewState createState() => _WeightSelectionViewState();
}

class _WeightSelectionViewState extends State<WeightSelectionView> {
  bool isKgSelected = true; // Variable para alternar entre KG y LB
  double selectedWeight = 75; // Peso seleccionado por defecto

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
            'Cual Es Tu Peso??',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWeightUnitButton('KG', isKgSelected),
              const SizedBox(width: 20.0),
              _buildWeightUnitButton('LB', !isKgSelected),
            ],
          ),
          const SizedBox(height: 30.0),
          // Slider personalizado para seleccionar el peso
          SizedBox(
            height: 150,
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFFCEFF00),
                inactiveTrackColor: Colors.grey[800],
                thumbColor: const Color(0xFFCEFF00),
                overlayColor: Colors.yellow.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                min: isKgSelected ? 40 : 90, // Rango para KG o LB
                max: isKgSelected ? 150 : 330,
                value: selectedWeight,
                divisions: isKgSelected ? 110 : 240, // Divisiones según KG o LB
                onChanged: (double value) {
                  setState(() {
                    selectedWeight = value;
                  });
                },
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_up, color: Colors.yellowAccent, size: 40.0),
          Text(
            '${selectedWeight.toStringAsFixed(0)} ${isKgSelected ? 'Kg' : 'Lb'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Navegar a la pantalla de selección de altura (HeightSelectionView)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeightSelectionView(
                    fullName: widget.fullName,  // Pasar el nombre
                    weight: selectedWeight.toString(),  // Pasar el peso seleccionado
                    gender: widget.gender,  // Pasar el género seleccionado
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

  // Botón personalizado para seleccionar la unidad de peso
  Widget _buildWeightUnitButton(String unit, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKgSelected = unit == 'KG';
          selectedWeight = isKgSelected ? 75 : 165; // Restablece el peso
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFCEFF00) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xFFCEFF00)),
        ),
        child: Text(
          unit,
          style: TextStyle(
            color: isSelected ? Colors.black : const Color(0xFFCEFF00),
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
