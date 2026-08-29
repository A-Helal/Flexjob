import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.hasImage,
    required this.imagePath,
    required this.onTap,
  });

  final bool hasImage;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'profile_avatar',
        child: Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: hasImage
                ? CachedNetworkImage(
              imageUrl: ApiConstants.baseStorageUrlProd + imagePath,
              width: 90.w,
              height: 90.w,
              fit: BoxFit.cover,
              memCacheWidth: 180,
              memCacheHeight: 180,
              fadeInDuration: const Duration(milliseconds: 200),
              placeholder: (_, __) => _AvatarPlaceholder(),
              errorWidget: (_, __, ___) => _AvatarPlaceholder(),
            )
                : _AvatarPlaceholder(),
          ),
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F0F0),
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/user_icon.svg',
          width: 36.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}