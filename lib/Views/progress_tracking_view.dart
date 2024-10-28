import 'package:flutter/material.dart';
import 'package:miosense/Views/track_muscle_view.dart';
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
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // Inicializar el controlador del video según el músculo seleccionado
    if (widget.muscle == "Cuádriceps") {
      _controller = VideoPlayerController.asset(
        'assets/videos/body_cuadriceps_video.mp4',
      )..initialize().then((_) {
          setState(() {});  // Refresca la pantalla cuando el video esté listo
        });
    } else if (widget.muscle == "Isquiotibiales") {
      _controller = VideoPlayerController.asset(
        'assets/videos/isquiotibiales.mp4',
      )..initialize().then((_) {
          setState(() {});  // Refresca la pantalla cuando el video esté listo
        });
    } else if (widget.muscle == "Gemelos") {
      _controller = VideoPlayerController.asset(
        'assets/videos/gemelos.mp4',
      )..initialize().then((_) {
          setState(() {});  // Refresca la pantalla cuando el video esté listo
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();  // Liberar el controlador del video
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

          // Mostrar el video si está inicializado, dependiendo del músculo
          (widget.muscle == "Cuádriceps" || widget.muscle == "Isquiotibiales" || widget.muscle == "Gemelos") && _controller != null
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackMuscleView()),
              );
            },
            child: Text('Iniciar Trackeo',
            ),
          ),
        ],
      ),
    );
  }
}
