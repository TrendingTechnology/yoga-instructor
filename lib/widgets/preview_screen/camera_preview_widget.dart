import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({
    Key key,
    @required bool isBodyVisible,
    @required CameraController cameraController,
  })  : _isBodyVisible = isBodyVisible,
        _cameraController = cameraController,
        super(key: key);

  final bool _isBodyVisible;
  final CameraController _cameraController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isBodyVisible
          ? Colors.green.withOpacity(0.8)
          : Colors.red.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'camera_view',
            child: RotatedBox(
              quarterTurns: 1,
              child: Container(
                child: AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
