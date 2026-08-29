import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/confirm_to_update_profile.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/badge_icon.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/governorate_drop_down_list_bottomsheet.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/jobs_shimmer.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/jobs_loaded_body.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nested/nested.dart';

@RoutePage()
class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late final JobsCubit _jobsCubit = getIt<JobsCubit>();
  late final UserCubit _userCubit = getIt<UserCubit>();

  /// Lazily instantiated — only created when the user has `missing_params` status.
  CompleteProfileCubit? _completeProfileCubit;

  GovernorateEntity? _selectedGovernorate;
  late final TextEditingController _governorateController;

  @override
  void initState() {
    super.initState();
    _governorateController = TextEditingController();
    _userCubit.getUserInfo();
    _jobsCubit.loadHome();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_governorateController.text.isEmpty) {
      _governorateController.text = context.tr(AppLocalizationKeys.selectGovernorate);
    }
  }

  @override
  void dispose() {
    _governorateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MultiBlocProvider(
        providers: <SingleChildWidget>[
          BlocProvider<JobsCubit>.value(value: _jobsCubit),
          BlocProvider<UserCubit>.value(value: _userCubit),
        ],
        child: BlocListener<UserCubit, UserState>(
          listener: _onUserState,
          child: RefreshIndicator(
            onRefresh: _jobsCubit.refresh,
            edgeOffset: 100,
            child: MasterWidget(
              appBar: _buildAppBar(context),
              hasScroll: false,
              scaffoldColor: Palette.grey_FAFAFA,
              widget: BlocBuilder<JobsCubit, JobsState>(
                builder: (BuildContext context, JobsState state) => switch (state) {
                  JobsLoading() => const JobsShimmer(),
                  JobsLoaded() => JobsLoadedBody(state: state, cubit: _jobsCubit),
                  JobsError(:final String message) => _ErrorBody(message: message, onRetry: _jobsCubit.loadHome),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.secondary,
      leadingWidth: 1.sw,
      toolbarHeight: 50.h,
      centerTitle: false,
      elevation: 0,
      actions: <Widget>[
        BlocBuilder<JobsCubit, JobsState>(
          buildWhen: (JobsState prev, JobsState curr) {
            final int prevCount = prev is JobsLoaded ? prev.data.unreadNotificationCount : 0;
            final int currCount = curr is JobsLoaded ? curr.data.unreadNotificationCount : 0;
            return prevCount != currCount;
          },
          builder: (BuildContext context, JobsState state) {
            final int count = state is JobsLoaded ? state.data.unreadNotificationCount : 0;
            return BadgeIcon(
              count: count,
              onTap: () {
                CustomMainRouter.push(NotificationsRoute());
                _jobsCubit.clearNotificationBadge();
              },
            );
          },
        ),
      ],
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        child: _GreetingText(),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(width: double.infinity, height: 26.h),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _GovernorateSearchBar(
                controller: _governorateController,
                selectedGovernorate: _selectedGovernorate,
                onGovernorate: _onGovernorateSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGovernorateSelected(GovernorateEntity? governorate) {
    setState(() {
      _selectedGovernorate = governorate;
      _governorateController.text = governorate?.name ?? context.tr(AppLocalizationKeys.selectGovernorate);
    });
    _jobsCubit.filterByGovernorate(governorate?.id);
  }

  void _onUserState(BuildContext context, UserState state) {
    if (state is UserReadyState && LocalData.user?.status == 'missing_params') {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        UpdateProfilePopUp.showShouldUpdatePopUp(
          context,
          onYesTap: () {
            // Instantiate only when we know profile completion is actually needed.
            _completeProfileCubit ??= getIt<CompleteProfileCubit>();
            CustomMainRouter.pop();
            _completeProfileCubit!.getUniversites();
            CustomMainRouter.push(
              PersonalInformationRoute(
                completeProfileCubit: _completeProfileCubit!,
                viewMode: false,
                fromUpdatePopup: true,
              ),
            );
          },
        );
      });
    }
  }
}

class _GreetingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: context.tr(AppLocalizationKeys.homeAppBarTitle),
          textColor: Palette.white,
          style: AppTextStyle.bold_22,
        ),
        AppText(
          text: context.tr(AppLocalizationKeys.homeAppBarSubTitle),
          textColor: Palette.grey_D9DDDE,
          style: AppTextStyle.medium_14,
        ),
      ],
    );
  }
}

class _GovernorateSearchBar extends StatelessWidget {
  const _GovernorateSearchBar({
    required this.controller,
    required this.selectedGovernorate,
    required this.onGovernorate,
  });

  final TextEditingController controller;
  final GovernorateEntity? selectedGovernorate;
  final void Function(GovernorateEntity?) onGovernorate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: GestureDetector(
        onTap: selectedGovernorate != null ? null : () => _openBottomSheet(context),
        child: Container(
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: <BoxShadow>[BoxShadow(color: Palette.primaryColor.withValues(alpha: 0.5), blurRadius: 12)],
          ),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/location-pin.svg',
                width: 18.w,
                colorFilter: ColorFilter.mode(Palette.secondary, BlendMode.srcIn),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  controller.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: selectedGovernorate != null ? Palette.black_111111 : Palette.grey_A5A5A5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selectedGovernorate != null)
                GestureDetector(
                  onTap: () => onGovernorate(null),
                  child: Icon(Icons.close_rounded, size: 18.r, color: Palette.grey_7B7B7B),
                )
              else
                Icon(Icons.keyboard_arrow_down_rounded, size: 20.r, color: Palette.grey_A5A5A5),
            ],
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => GovernorateDropDownListBottomSheet(
        onGovernorate: (GovernorateEntity governorate) {
          Navigator.of(context).pop();
          onGovernorate(governorate);
        },
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.wifi_off_rounded, size: 64.r, color: Palette.grey_757575),
            SizedBox(height: 16.h),
            AppText(text: message, style: AppTextStyle.medium_14, textColor: Palette.redBackgroundTheme),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.tr(AppLocalizationKeys.retry)),
            ),
          ],
        ),
      ),
    );
  }
}
