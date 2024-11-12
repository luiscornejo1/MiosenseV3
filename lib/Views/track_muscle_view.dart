import 'package:flutter/material.dart';
import 'package:miosense/Views/analysis_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:math';

class TrackMuscleView extends StatefulWidget {
  @override
  _TrackMuscleViewState createState() => _TrackMuscleViewState();
}

class _TrackMuscleViewState extends State<TrackMuscleView> with SingleTickerProviderStateMixin {
  double valorSensor = 0.0;
  late IO.Socket socket;
  List<int> datosRecolectados = [];
  String estadoMusculo = "Esperando datos...";
  String mensajeDinamico = "";
  Color estadoColor = Colors.green;

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('https://miosense-backend.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.onConnect((_) {
      print("Conectado al servidor WebSocket");
    });

    socket.on('muscleData', (data) {
      setState(() {
        valorSensor = (data['value'] as int).toDouble();
        datosRecolectados.add(valorSensor.toInt());
        estadoMusculo = evaluarEstadoMusculo(valorSensor);
        mensajeDinamico = getMensajeDinamico(valorSensor);
        estadoColor = getColorEstado(estadoMusculo);
      });
    });

    socket.onDisconnect((_) => print("Desconectado del servidor WebSocket"));
  }

  String evaluarEstadoMusculo(double valorSensor) {
    if (valorSensor >= 16) {
      return "Excelente";
    } else if (valorSensor >= 10) {
      return "Bueno";
    } else if (valorSensor >= 5) {
      return "Moderado";
    } else {
      return "Crítico";
    }
  }

  String getMensajeDinamico(double valorSensor) {
    List<String> mensajes = [];
    if (valorSensor >= 16) {
      mensajes = [
        "¡Excelente! Sigue así, tu músculo está en óptimas condiciones.",
        "Muy bien, tu musculatura está fuerte y activa.",
        "El músculo está en gran estado para realizar ejercicios intensos."
      ];
    } else if (valorSensor >= 10) {
      mensajes = [
        "Buen estado, pero monitorea la fatiga.",
        "El músculo responde bien, aunque se recomienda moderación.",
        "Parece que tu músculo está bien, pero cuida la intensidad."
      ];
    } else if (valorSensor >= 5) {
      mensajes = [
        "Moderado: podrías estar experimentando fatiga.",
        "Es posible que necesites un descanso pronto.",
        "Tu músculo muestra signos de sobrecarga, toma precauciones."
      ];
    } else {
      mensajes = [
        "Crítico: riesgo alto de lesión. Descansa.",
        "Alerta: evita actividades intensas por ahora.",
        "Tu músculo necesita atención, podrías estar en riesgo."
      ];
    }
    return mensajes[Random().nextInt(mensajes.length)];
  }

  Color getColorEstado(String estado) {
    switch (estado) {
      case "Excelente":
        return Colors.green;
      case "Bueno":
        return Colors.lightGreen;
      case "Moderado":
        return Colors.orange;
      case "Crítico":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void detenerTrackeo() {
    print("Deteniendo trackeo");
    socket.disconnect();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisView(datosRecolectados: datosRecolectados),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = valorSensor / 16;

    return Scaffold(
      appBar: AppBar(title: Text("Trackeo del Músculo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Valor del sensor (mV): ${valorSensor.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              "Estado: $estadoMusculo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: estadoColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              mensajeDinamico,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[300],
              color: estadoColor,
              minHeight: 20,
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: detenerTrackeo,
              child: Text("Detener Trackeo"),
            ),
          ],
        ),
      ),
    );
  }
}
