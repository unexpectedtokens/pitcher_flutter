import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



class CameraView extends StatefulWidget {



  const CameraView({
    Key? key,

  }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription camera;


  void _initCamera() async{
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    camera = firstCamera;
  }

  @override
  void initState(){
    super.initState();
    // Obtain a list of the available cameras on the device.



    _controller = CameraController(
        camera,
        ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        return CameraPreview(_controller);
      }else{
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
