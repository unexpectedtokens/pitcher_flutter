import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class PhotoEditor extends StatefulWidget {
  const PhotoEditor({Key? key}) : super(key: key);


  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  List<Offset> points = [];
  ui.Image? background;
  void _printLoc(TapDownDetails dets) {
    var newPoints = [...points];
    newPoints.add(dets.localPosition);
    setState(() {
      points = newPoints;
    });
  }

  void setBackground() async {
    var _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    var fileL = File(image.path);
    ui.decodeImageFromList(fileL.readAsBytesSync(), (res) {
      setState(() {
        background = res;
      });
    });
  }

  void saveImage() async {
    ui.PictureRecorder rec = ui.PictureRecorder();
    Canvas canvas = Canvas(rec);
    BackgroundPaint painter =
    BackgroundPaint(points: points, image: background!);
    var size = context.size;
    painter.paint(canvas, size!);
    var image = await rec
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
    var dat = await image.toByteData(format: ui.ImageByteFormat.png);

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (builder) => Thingy(
    //       file: dat!,
    //     )));
    var uiIntList = dat!.buffer.asUint8List();
    Navigator.of(context).pop(uiIntList);
  }

  @override
  void initState() {
    super.initState();
    setBackground();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: background != null
              ? GestureDetector(
            onTapDown: _printLoc,
            child: Container(
                color: Colors.black54,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter:
                  BackgroundPaint(points: points, image: background!),
                )),
          )
              : const Center(
              child: CircularProgressIndicator(color: Colors.redAccent))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,

        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          saveImage();
        },
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  final List<Offset> points;
  final ui.Image image;
  BackgroundPaint({
    required this.points,
    required this.image,
  });
  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTRB(0, 0, size.width, size.height),
      image: image,
      fit: BoxFit.cover,
    );
    Paint dotPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white54
      ..strokeWidth = 2;

    Paint linePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.white30;

    for (var x = 0; x < points.length; x++) {
      canvas.drawCircle(points[x], 20, dotPaint);
      if (x < points.length - 1) {
        canvas.drawLine(
          points[x],
          points[x + 1],
          linePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(BackgroundPaint oldDelegate) =>
      oldDelegate.points != points;
}

// class Thingy extends StatelessWidget {
//   final ByteData file;
//
//   const Thingy({Key? key, required this.file}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.memory(file.buffer.asUint8List()),
//       ),
//     );
//   }
// }