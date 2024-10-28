import 'package:flutter/material.dart';

class AnalysisView extends StatelessWidget {
  final List<int> datosRecolectados;

  AnalysisView({required this.datosRecolectados});

  // Función para analizar los datos y devolver el estado promedio
  Future<String> analizarEstado() async {
    int promedio = datosRecolectados.fold(0, (sum, item) => sum + item) ~/ datosRecolectados.length;
    if (promedio < 1000) {
      return "Bajo";
    } else if (promedio < 2000) {
      return "Moderado";
    } else if (promedio < 3000) {
      return "Alto";
    } else {
      return "Peligro";
    }
  }

  // Función para proporcionar una explicación basada en el estado del músculo
  String getExplicacion(String estado) {
    switch (estado) {
      case "Bajo":
        return "Tu músculo está en un estado óptimo y saludable. Es seguro realizar ejercicios, ya que no se detectan señales de fatiga o lesiones. Sigue con tu rutina habitual de entrenamiento y asegúrate de calentar adecuadamente.";
      case "Moderado":
        return "Tu músculo presenta señales de sobrecarga o fatiga moderada. Esto podría llevar a posibles lesiones si no se da un descanso adecuado. Es recomendable disminuir la intensidad del ejercicio y considerar descanso activo.";
      case "Alto":
        return "Tu músculo muestra un nivel alto de fatiga. Hay riesgo de sufrir lesiones como desgarros leves o sobrecarga muscular si continúas ejercitándote intensamente. Se sugiere descanso, aplicación de hielo y estiramientos ligeros.";
      case "Peligro":
        return "Tu músculo está en un estado crítico, con alto riesgo de lesiones graves. Existe una posibilidad significativa de sufrir desgarros severos, distensiones o lesiones graves en los músculos como cuadriceps, isquiotibiales o gemelos. Se recomienda suspender cualquier actividad física y consultar a un especialista.";
      default:
        return "Estado desconocido. No se puede realizar un análisis adecuado. Verifica que los datos del sensor sean correctos.";
    }
  }

  // Función para obtener las lesiones y riesgos comunes
  String getRiesgosComunes() {
    return '''
Desgarros musculares: Ruptura parcial o completa de las fibras musculares debido a esfuerzos intensos o movimientos bruscos, común en todos estos grupos musculares.

Contracturas y distensiones: Contracciones involuntarias o sobreestiramientos que causan dolor y limitan el movimiento, provocados por la fatiga muscular y la falta de calentamiento adecuado.

Tendinitis: Inflamación de los tendones asociados (como el tendón del cuádriceps y del tendón de Aquiles en gemelos), originada por sobrecarga y movimientos repetitivos.

Contusiones y hematomas: Golpes directos que pueden causar dolor e inflamación en el músculo, frecuentemente en el fútbol debido al contacto físico.

Síndrome compartimental: Presión elevada en los compartimientos musculares, afectando la circulación sanguínea y el rendimiento muscular, aunque es más raro.
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Análisis del Estado del Músculo'),
      ),
      body: FutureBuilder<String>(
        future: analizarEstado(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al analizar los datos'));
          } else {
            String estado = snapshot.data ?? "Desconocido";
            String explicacion = getExplicacion(estado);
            String riesgosComunes = getRiesgosComunes();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estado del Músculo: $estado',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    explicacion,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Posibles Lesiones y Riesgos Comunes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    riesgosComunes,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Vuelve a la pantalla anterior
                    },
                    child: Text('Volver'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
