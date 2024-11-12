import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  final List<int> datosRecolectados;

  AnalysisView({required this.datosRecolectados});

  // Función para analizar el promedio de los datos y devolver el estado del músculo
  String analizarEstado() {
    if (datosRecolectados.isEmpty) return "Sin datos";

    // Calcula el promedio de los valores recolectados
    double promedio = datosRecolectados.reduce((a, b) => a + b) / datosRecolectados.length;

    // Clasificación basada en los rangos en mV
    if (promedio >= 16) {
      return "Excelente";
    } else if (promedio >= 10) {
      return "Bueno";
    } else if (promedio >= 5) {
      return "Moderado";
    } else {
      return "Crítico";
    }
  }

  // Función para proporcionar una explicación basada en el estado del músculo
  String getExplicacion(String estado) {
    switch (estado) {
      case "Excelente":
        return "Tu músculo está en excelente condición y es capaz de soportar actividad intensa sin riesgo de fatiga.";
      case "Bueno":
        return "El músculo está en buena forma, pero es recomendable monitorear la fatiga durante actividades prolongadas.";
      case "Moderado":
        return "El músculo muestra signos de fatiga leve. Considera tomar descansos para evitar sobrecarga.";
      case "Crítico":
        return "Riesgo alto de lesión. Es importante descansar para evitar daños serios al músculo.";
      default:
        return "Sin datos disponibles para el análisis.";
    }
  }

  @override
  Widget build(BuildContext context) {
    String estado = analizarEstado();
    String explicacion = getExplicacion(estado);

    return Scaffold(
      appBar: AppBar(
        title: Text("Análisis del Músculo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Estado del Músculo: $estado",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              explicacion,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rangos de EMG (mV):",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("• Excelente: ≥ 16 mV"),
                  Text("• Bueno: 10 - 15 mV"),
                  Text("• Moderado: 5 - 9 mV"),
                  Text("• Crítico: < 5 mV"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
