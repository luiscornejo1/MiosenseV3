import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:miosense/Views/analysis_View.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TrackMuscleView extends StatefulWidget {
  @override
  _TrackMuscleViewState createState() => _TrackMuscleViewState();
}

class _TrackMuscleViewState extends State<TrackMuscleView> {
  String estadoMusculo = "Esperando datos...";
  int valorSensor = 0;
  List<FlSpot> datosGrafico = [];
  List<int> listaDatosRecolectados = []; // Lista para almacenar los datos recolectados
  late IO.Socket socket;
  int maxDatos = 20;
  bool showStopButton = false;

  @override
  void initState() {
    super.initState();
    connectToSocket();

    // Mostrar el botón de detener después de 10 segundos
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        showStopButton = true;
      });
    });
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
        valorSensor = data['value'];
        listaDatosRecolectados.add(valorSensor); // Guardamos los datos
        estadoMusculo = evaluarEstadoMusculo(valorSensor);
        actualizarGrafico(valorSensor);
      });
    });

    socket.onDisconnect((_) => print("Desconectado del servidor WebSocket"));
  }

  void actualizarGrafico(int valor) {
    if (datosGrafico.length >= maxDatos) {
      datosGrafico.removeAt(0);
    }
    datosGrafico.add(FlSpot(datosGrafico.length.toDouble(), valor.toDouble()));
  }

  String evaluarEstadoMusculo(int valorSensor) {
    if (valorSensor < 1000) {
      return "Estado: Bajo";
    } else if (valorSensor >= 1000 && valorSensor < 2000) {
      return "Estado: Moderado";
    } else if (valorSensor >= 2000 && valorSensor < 3000) {
      return "Estado: Alto";
    } else {
      return "Estado: Peligro";
    }
  }

  void detenerTrackeo() {
    print("Deteniendo trackeo");
    socket.disconnect();
    print("Socket desconectado");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisView(
          datosRecolectados: listaDatosRecolectados,
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trackeo del Músculo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Valor del sensor: $valorSensor", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(estadoMusculo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: datosGrafico,
                        isCurved: true,
                        barWidth: 3,
                        colors: [Colors.purple],
                        dotData: FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: true), 
                      bottomTitles: SideTitles(showTitles : false),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: true),
                  ),
                ),
              ),
            ),
            if (showStopButton)
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
