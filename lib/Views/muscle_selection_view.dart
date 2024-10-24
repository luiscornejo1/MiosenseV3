import 'package:flutter/material.dart';
import 'package:miosense/Views/progress_tracking_view.dart';

class MuscleSelectionView extends StatefulWidget {
  final String fullName;
  final String weight;
  final String height;
  final String gender;

  MuscleSelectionView({
    required this.fullName,
    required this.weight,
    required this.height, 
    required this.gender,
  });

  @override
  _MuscleSelectionViewState createState() => _MuscleSelectionViewState();
}

class _MuscleSelectionViewState extends State<MuscleSelectionView> {
  String? selectedMuscle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un Músculo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Cuádriceps'),
            leading: Radio<String>(
              value: 'Cuádriceps',
              groupValue: selectedMuscle,
              onChanged: (value) {
                setState(() {
                  selectedMuscle = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Isquiotibiales'),
            leading: Radio<String>(
              value: 'Isquiotibiales',
              groupValue: selectedMuscle,
              onChanged: (value) {
                setState(() {
                  selectedMuscle = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Gemelos'),
            leading: Radio<String>(
              value: 'Gemelos',
              groupValue: selectedMuscle,
              onChanged: (value) {
                setState(() {
                  selectedMuscle = value;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: selectedMuscle != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressTrackingView(
                          fullName: widget.fullName, // Pasar el nombre
                          weight: widget.weight,     // Pasar el peso
                          height: widget.height,     // Pasar la altura
                          muscle: selectedMuscle!, selectedMuscle: '',   // Pasar el músculo seleccionado
                        ),
                      ),
                    );
                  }
                : null, // Deshabilitar el botón si no se ha seleccionado un músculo
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
