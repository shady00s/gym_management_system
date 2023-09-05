// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:fluent_ui/fluent_ui.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_management/main_screen/widgets/take_new_image_widget.dart';
import 'package:path/path.dart' as p;



/// Example app for Camera Windows plugin.
class TakeNewPhoto extends StatefulWidget {
  final String path;
  /// Default Constructor
  const TakeNewPhoto({super.key,required this.path});

  @override
  State<TakeNewPhoto> createState() => _TakeNewPhotoState();
}

class _TakeNewPhotoState extends State<TakeNewPhoto> {
  String _cameraInfo = 'Unknown';
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;
  bool _previewPaused = false;
  Size? _previewSize;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameras = cameras;
        _cameraInfo = cameraInfo;
      });
    }
  }

  /// Initializes the camera on the device.
  Future<void> _initializeCamera() async {
    assert(!_initialized);

    if (_cameras.isEmpty) {
      return;
    }

    int cameraId = -1;
    try {
      final int cameraIndex = _cameraIndex % _cameras.length;
      final CameraDescription camera = _cameras[cameraIndex];

      cameraId = await CameraPlatform.instance.createCamera(
        camera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );

      unawaited(_errorStreamSubscription?.cancel());
      _errorStreamSubscription = CameraPlatform.instance
          .onCameraError(cameraId)
          .listen(_onCameraError);

      unawaited(_cameraClosingStreamSubscription?.cancel());
      _cameraClosingStreamSubscription = CameraPlatform.instance
          .onCameraClosing(cameraId)
          .listen(_onCameraClosing);

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _initialized = true;
          _cameraId = cameraId;
          _cameraIndex = cameraIndex;
          _cameraInfo = 'Capturing camera: ${camera.name}';
        });
      }
    } on CameraException catch (e) {
      try {
        if (cameraId >= 0) {
          await CameraPlatform.instance.dispose(cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;
          _cameraInfo =
          'Failed to initialize camera: ${e.code}: ${e.description}';
        });
      }
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
            _previewSize = null;
            _previewPaused = false;
            _cameraInfo = 'Camera disposed';
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          setState(() {
            _cameraInfo =
            'Failed to dispose camera: ${e.code}: ${e.description}';
          });
        }
      }
    }
  }

  Widget _buildPreview() {
    return CameraPlatform.instance.buildPreview(_cameraId);
  }

  Future<XFile> _takePicture() async {
    final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
      await file.saveTo(p.join('assets/${widget.path}',file.name)).then((value) {
        _showInSnackBar('Picture captured to: ${file.path}');
        Navigator.pop(context);
      });

    return file;
  }

  Future<void> _togglePreview() async {
    if (_initialized && _cameraId >= 0) {
      if (!_previewPaused) {
        await CameraPlatform.instance.pausePreview(_cameraId);
      } else {
        await CameraPlatform.instance.resumePreview(_cameraId);
      }
      if (mounted) {
        setState(() {
          _previewPaused = !_previewPaused;
        });
      }
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.isNotEmpty) {
      // select next index;
      _cameraIndex = (_cameraIndex + 1) % _cameras.length;
      if (_initialized && _cameraId >= 0) {
        await _disposeCurrentCamera();
        await _fetchCameras();
        if (_cameras.isNotEmpty) {
          await _initializeCamera();
        }
      } else {
        await _fetchCameras();
      }
    }
  }

  void _onCameraError(CameraErrorEvent event) {
    if (mounted) {
      displayInfoBar(
        context,

        builder:(context,exit){
          return InfoBar(
            severity: InfoBarSeverity.warning,
            content: Text('Error: ${event.description}'), title: Text("Error"),);
        }

      );
      // Dispose camera on camera error as it can not be used anymore.
      _disposeCurrentCamera();
      _fetchCameras();
    }
  }

  void _onCameraClosing(CameraClosingEvent event) {
    if (mounted) {
      _showInSnackBar('Camera is closing');
    }
  }

  void _showInSnackBar(String message) {
    displayInfoBar( context, builder: (context, close) {
      return InfoBar(title: Text('warning'),content: Text(message),);
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(_cameraInfo),
            ),
            if (_cameras.isEmpty)
              FilledButton(
                onPressed: _fetchCameras,
                child: const Text('Re-check available cameras'),
              ),
            if (_cameras.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: _initialized
                          ? _disposeCurrentCamera
                          : _initializeCamera,
                      child:
                      Text(_initialized ? 'Dispose camera' : 'Open camera'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Consumer(
                    builder: (context, ref,child) {
                      var image =ref.read(imageProvider.notifier);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                          onPressed: _initialized ?()async{
                           await _takePicture().then((value){
                             image.state = value;
                           });
                          }  : null,
                          child: const Text('Take picture'),
                        ),
                      );
                    }
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: _initialized ? _togglePreview : null,
                      child: Text(
                        _previewPaused ? 'Resume preview' : 'Pause preview',
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),

                  if (_cameras.length > 1) ...<Widget>[
                    const SizedBox(width: 5),
                    FilledButton(
                      onPressed: _switchCamera,
                      child: const Text(
                        'Switch camera',
                      ),
                    ),
                  ]
                ],
              ),
            const SizedBox(height: 5),
            if (_initialized && _cameraId > 0 && _previewSize != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Align(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 500,
                    ),
                    child: AspectRatio(
                      aspectRatio: _previewSize!.width / _previewSize!.height,
                      child: _buildPreview(),
                    ),
                  ),
                ),
              ),

          ],


    );
  }
}