import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:flexiJobs/features/more/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:flexiJobs/features/more/presentation/widgets/more_body.dart';
import 'package:flexiJobs/features/more/presentation/widgets/profile_hero_header.dart';
import 'package:flexiJobs/features/shared/cubit/locale_cubit/locale_cubit.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen>
    with SingleTickerProviderStateMixin {
  final LocaleCubit _localeCubit = getIt<LocaleCubit>();
  final UserCubit _userCubit = getIt<UserCubit>();
  BuildContext? _dialogContext;

  String _imagePath = '';
  bool _hasImage = false;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
    _initAnimations();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _animController.forward(),
    );
  }

  void _initAnimations() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
  }

  void _loadUserImage() {
    final AttachmentDto? profilePic = LocalData.user?.attachments
        ?.where((AttachmentDto e) => e.type == 'profile_picture')
        .firstOrNull;
    if (profilePic != null) {
      _hasImage = true;
      _imagePath = profilePic.path;
    }
  }

  void _onProfileTap() {
    if (!_hasImage) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (_, Animation<double> animation, __) =>
            FullscreenImageViewer(
              imageUrl: ApiConstants.baseStorageUrlProd + _imagePath,
              animation: animation,
            ),
      ),
    );
  }

  void _onProfileReturned() {
    _loadUserImage();
    setState(() {});
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider<UserCubit>.value(
        value: _userCubit,
        child: BlocListener<UserCubit, UserState>(
          listener: (BuildContext context, UserState state) {
            if (state is UserDeletedState) {
              ViewsToolbox.dismissLoading();
              ViewsToolbox.showSuccessAwesomeSnackBar(
                context,
                context.tr(AppLocalizationKeys.deleteRequestSuccess),
              );
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SlideTransition(
                    position: _slideAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: ProfileHeroHeader(
                        hasImage: _hasImage,
                        imagePath: _imagePath,
                        onImageTap: _onProfileTap,
                      ),
                    ),
                  ),
                  70.heightBox,
                  MoreBody(
                    localeCubit: _localeCubit,
                    userCubit: _userCubit,
                    dialogContext: _dialogContext,
                    onProfileReturned: _onProfileReturned,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
