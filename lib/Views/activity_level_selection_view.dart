import 'package:flutter/material.dart';
import 'muscle_selection_view.dart';

class ActivityLevelSelectionView extends StatelessWidget {
  final String fullName;
  final String weight;
  final String height;  // Recibir la altura
  final String gender;

  ActivityLevelSelectionView({
    required this.fullName,
    required this.weight,
    required this.height,  // Recibir la altura
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel de Actividad Física'),
      ),
      body: Column(
        children: [
          Text('Nombre: $fullName'),
          Text('Peso: $weight'),
          Text('Altura: $height CM'),  // Mostrar la altura
          Text('Género: $gender'),
          // Aquí puedes agregar los botones o controles para seleccionar el nivel de actividad física

          ElevatedButton(
            onPressed: () {
              // Pasar los datos a la siguiente vista (MuscleSelectionView)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MuscleSelectionView(
                    fullName: fullName,
                    weight: weight,
                    height: height,  // Pasar la altura
                    gender: gender,
                  ),
                ),
              );
            },
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
