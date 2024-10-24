import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProgressTrackingView extends StatefulWidget {
  final String fullName;
  final String weight;
  final String height;
  final String muscle;

  ProgressTrackingView({
    required this.fullName,
    required this.weight,
    required this.height,
    required this.muscle, required String selectedMuscle,
  });

  @override
  _ProgressTrackingViewState createState() => _ProgressTrackingViewState();
}

class _ProgressTrackingViewState extends State<ProgressTrackingView> {
  VideoPlayerController? _controller;  // Cambiado para permitir nulos

  @override
  void initState() {
    super.initState();
    
    // Solo inicializar el controlador si el músculo es Cuádriceps
    if (widget.muscle == "Cuádriceps") {
      _controller = VideoPlayerController.asset(
        'assets/videos/body_cuadriceps_video.mp4',
      )..initialize().then((_) {
          setState(() {});  // Refresca la pantalla cuando el video esté listo
          _controller!.play();  // Comienza la reproducción automáticamente
        });
    }
  }

  @override
  void dispose() {
    // Solo liberar el controlador si fue inicializado
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.fullName, style: TextStyle(fontSize: 20)),
                  Text('${widget.weight} Kg', style: TextStyle(fontSize: 16)),
                  Text('${widget.height} CM', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Músculo a Monitorear: ${widget.muscle}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          
          // Verificar si el video está inicializado y mostrarlo
          widget.muscle == "Cuádriceps" && _controller != null
              ? _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Center(child: CircularProgressIndicator())  // Mostrar un indicador mientras el video se carga
              : Center(child: Text('No hay video disponible para ${widget.muscle}')),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Verificar si hay controlador y si el video está listo
              if (_controller != null && _controller!.value.isInitialized) {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
                setState(() {});
              }
            },
            child: Text(
              _controller != null && _controller!.value.isPlaying ? 'Pausar' : 'Iniciar Trackeo',
            ),
          ),
        ],
      ),
    );
  }
}
