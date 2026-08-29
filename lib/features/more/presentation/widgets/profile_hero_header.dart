import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/features/more/presentation/widgets/hero_background.dart';
import 'package:flexiJobs/features/more/presentation/widgets/profile_avatar.dart';
import 'package:flexiJobs/features/more/presentation/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeroHeader extends StatelessWidget {
  const ProfileHeroHeader({
    super.key,
    required this.hasImage,
    required this.imagePath,
    required this.onImageTap,
  });

  final bool hasImage;
  final String imagePath;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        HeroBackground(),
        Positioned(
          bottom: -90.h,
          child: Column(
            children: <Widget>[
              ProfileAvatar(
                hasImage: hasImage,
                imagePath: imagePath,
                onTap: onImageTap,
              ),
              8.heightBox,
              ProfileInfo(),
            ],
          ),
        ),
      ],
    );
  }
}
