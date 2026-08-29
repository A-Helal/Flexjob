import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/more/presentation/cubit/more_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

@RoutePage()
class VideoPreviewScreen extends StatefulWidget {
  const VideoPreviewScreen({
    required this.video,
    required this.cameras,
    super.key,
  });
  final XFile video;
  final List<CameraDescription> cameras;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController _videoController;
  bool _isPlaying = false;
  Duration? _duration;

  MoreCubit _moreCubit = getIt<MoreCubit>();
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.video.path));
    ViewsToolbox.showLoading();
    _videoController.initialize().then((_) {
      ViewsToolbox.dismissLoading();
      setState(() {});
    });

    _videoController.addListener(() {
      _duration = _videoController.value.position;
      setState(() {});
      final bool playing = _videoController.value.isPlaying;
      if (playing != _isPlaying) {
        setState(() => _isPlaying = playing);
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoreCubit>.value(
      value: _moreCubit,
      child: BlocListener<MoreCubit, MoreState>(
        listener: (BuildContext context, MoreState state) {
          if (state is MoreReadyState) {
            ViewsToolbox.dismissLoading();
            CustomMainRouter.pop();
            CustomMainRouter.pop(result: true);
          } else if (state is MoreErrorState) {
            ViewsToolbox.dismissLoading();
            ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
          } else if (state is MoreLoadingState) {
            ViewsToolbox.showLoading();
          }
        },
        child: Scaffold(
          backgroundColor: Palette.black_090909.withValues(alpha: 0.5),
          body: Column(
            children: <Widget>[
              // Video player
              Center(
                child: _videoController.value.isInitialized
                    ? SizedBox(height: 0.77.sh, child: VideoPlayer(_videoController))
                    : const SizedBox.shrink(),
              ),

              if (_videoController.value.isInitialized) ...<Widget>[
                // Seek bar
                SizedBox(
                  height: 12.h,
                  child: VideoProgressIndicator(
                    _videoController,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Palette.primaryColor,
                      bufferedColor: Palette.greyBorder,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                ),

                // Current / Total time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _formatDuration(_duration!),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatDuration(_videoController.value.duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.replay_10, color: Colors.white),
                      onTap: () {
                        final Duration newPosition = _videoController.value.position - const Duration(seconds: 10);
                        _videoController.seekTo(
                          newPosition < Duration.zero ? Duration.zero : newPosition,
                        );
                      },
                    ),
                    GestureDetector(
                      child: Icon(
                        _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: _togglePlayPause,
                    ),
                    GestureDetector(
                      child: const Icon(Icons.forward_10, color: Colors.white),
                      onTap: () {
                        final Duration max = _videoController.value.duration;
                        final Duration newPosition = _videoController.value.position + const Duration(seconds: 10);
                        _videoController.seekTo(
                          newPosition > max ? max : newPosition,
                        );
                      },
                    ),
                  ],
                ),

                14.heightBox,

                // Retake & Submit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomElevatedButton(
                      width: 0.4.sw,
                      textColor: Palette.primaryColor,
                      backgroundColor: Palette.white,
                      text: "Retake",
                      onPressed: () {
                        CustomMainRouter.pop();
                      },
                    ),
                    CustomElevatedButton(
                      width: 0.4.sw,
                      text: "Submit",
                      onPressed: () async {
                        MultipartFile multipartFile;
                        FormData formData = FormData();

                        multipartFile = await MultipartFile.fromFile(widget.video.path, filename: widget.video.name);

                        formData.files.add(MapEntry("attachment[file]", multipartFile));

                        formData.fields.add(MapEntry("attachment[type]", "intro_video"));

                        await _moreCubit.uploadVideo(file: formData);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
