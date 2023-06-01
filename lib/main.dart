import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector Demo',
      home: const GestureDemo(),
    );
  }
}

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  _GestureDemoState createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String _gesture = '';
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  bool _isPanGesture = false;

  void _onTap() {
    setState(() {
      _gesture = 'onTap';
    });
  }

  void _onDoubleTap() {
    setState(() {
      _gesture = 'onDoubleTap';
    });
  }

  void _onLongPress() {
    setState(() {
      _gesture = 'onLongPress';
    });
  }

  void _onDragAndDrop(LongPressMoveUpdateDetails details) {
    setState(() {
      _gesture = 'onDragAndDrop';
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    _isPanGesture = false;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      _isPanGesture = false;
      setState(() {
        _scale = details.scale;
        _gesture = 'transform';
      });
    } else if (!_isPanGesture) {
      _isPanGesture = true;
      _previousOffset = details.focalPoint;
    } else {
      setState(() {
        Offset delta = details.focalPoint - _previousOffset;
        _gesture = 'pan update';
        // Use the delta to update the position of the widget being transformed
      });
      _previousOffset = details.focalPoint;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _isPanGesture = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Detector Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          onDoubleTap: _onDoubleTap,
          onLongPress: _onLongPress,
          // onPanUpdate: _onPanUpdate,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          onLongPressMoveUpdate: _onDragAndDrop,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(
              child: Text(
                _gesture,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
