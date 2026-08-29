import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

/// CameraApp is the Main Application.
///
@RoutePage()
class VideoRecordScreen extends StatefulWidget {
  /// Default Constructor
  const VideoRecordScreen({super.key});

  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  int _currentCameraIndex = 0;
  int _recordedSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras![0], ResolutionPreset.max);
      await _controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    await _controller!.startVideoRecording();
    setState(() {
      _isRecording = true;
      _recordedSeconds = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _recordedSeconds++);
    });
  }

  Future<void> _stopRecording() async {
    final XFile file = await _controller!.stopVideoRecording();
    _timer?.cancel();
    setState(() => _isRecording = false);
    CustomMainRouter.push(VideoPreviewRoute(video: file, cameras: _cameras!));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VideoPreviewScreen(videoPath: file.path, cameras: widget.cameras),
    //   ),
    // );
  }

  Future<void> _initCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: true,
    );
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  void _switchCamera() async {
    //  await _controller?.dispose();
    if (_currentCameraIndex == 0) {
      _currentCameraIndex = 1;
      _initCamera(_cameras![1]);
    } else {
      _currentCameraIndex = 0;
      _initCamera(_cameras![0]);
    }
  }

  String _formatTime(int seconds) {
    final String min = (seconds ~/ 60).toString().padLeft(2, '0');
    final String sec = (seconds % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: <Widget>[
        Container(
          color: Palette.black_090909.withValues(alpha: 0.5),
          child: Column(
            children: <Widget>[
              SizedBox(height: 0.8.sh, child: CameraPreview(_controller!)),
              20.heightBox,
              if (_isRecording)
                AppText(
                  text: _formatTime(_recordedSeconds),
                  style: AppTextStyle.bold_16,
                  textColor: Palette.white,
                ),
              if (!_isRecording)
                AppText(
                  textColor: Palette.white,
                  text: context.tr(AppLocalizationKeys.startRecording),
                  style: AppTextStyle.regular_16,
                ),
              10.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _isRecording ? _stopRecording : _startRecording,
                      child: SvgPicture.asset(_isRecording ? "assets/svg/captureRecord.svg" : "assets/svg/capture.svg"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!_isRecording)
          Positioned(
            bottom: 55.h,
            right: 20.w,
            child: FloatingActionButton(
              backgroundColor: Palette.primaryColor,
              child: const Icon(
                Icons.cameraswitch,
                color: Palette.white,
              ),
              onPressed: _switchCamera,
            ),
          ),
      ],
    );
  }
}
