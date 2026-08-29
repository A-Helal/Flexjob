import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullscreenImageViewer extends StatefulWidget {
  const FullscreenImageViewer({
    super.key,
    required this.imageUrl,
    required this.animation,
  });

  final String imageUrl;
  final Animation<double> animation;

  @override
  State<FullscreenImageViewer> createState() => FullscreenImageViewerState();
}

class FullscreenImageViewerState extends State<FullscreenImageViewer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _scaleAnim = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black.withValues(
            alpha: _fadeAnim.value * 0.88,
          ),
          body: GestureDetector(
            onTap: _dismiss,
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnim,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: GestureDetector(
                    // todo:Prevent tap on image from dismissing matensa4 ya m3lm
                    onTap: () {},
                    child: Hero(
                      tag: 'profile_avatar',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl,
                          width: 0.85.sw,
                          height: 0.85.sw,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            width: 0.85.sw,
                            height: 0.85.sw,
                            color: const Color(0xFF2C2C2C),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            width: 0.85.sw,
                            height: 0.85.sw,
                            color: const Color(0xFF2C2C2C),
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white54,
                              size: 40.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
