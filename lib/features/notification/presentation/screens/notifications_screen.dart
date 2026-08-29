import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/notification/domain/entities/notification_entity.dart';
import 'package:flexiJobs/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:flexiJobs/features/notification/presentation/widgets/empty_notifications_widget.dart';
import 'package:flexiJobs/features/notification/presentation/widgets/notification_card.dart';
import 'package:flexiJobs/features/notification/presentation/widgets/notification_shimmer.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationCubit _cubit = getIt<NotificationCubit>();
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit.loadInitial();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>.value(
      value: _cubit,
      child: MasterWidget(
        hasScroll: false,
        scaffoldColor: Palette.grey_FAFAFA,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.notifications),
        ),
        widget: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (BuildContext context, NotificationState state) {
            if (state is NotificationLoaded && state.loadMoreError != null) {
              ViewsToolbox.showErrorAwesomeSnackBar(context, state.loadMoreError!);
            }
          },
          builder: (BuildContext context, NotificationState state) =>
              switch (state) {
            NotificationLoading() => const NotificationShimmer(),
            NotificationLoaded() => _LoadedBody(
                state: state,
                scrollController: _scrollController,
              ),
            NotificationError(:final String message) => _ErrorBody(
                message: message,
                onRetry: _cubit.loadInitial,
              ),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loaded body — date-grouped sections
// ─────────────────────────────────────────────────────────────────────────────

class _Section {
  const _Section({required this.label, required this.items});

  final String label;
  final List<NotificationEntity> items;
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.state, required this.scrollController});

  final NotificationLoaded state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (state.notifications.isEmpty) return const EmptyNotificationsWidget();

    final List<_Section> sections =
        _buildSections(state.notifications, context);

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
      itemCount: sections.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext ctx, int index) {
        if (index == sections.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: const Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        final _Section section = sections[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18.h, bottom: 8.h),
              child: AppText(
                text: section.label,
                style: AppTextStyle.semiBold_14,
                textColor: Palette.grey_757575,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < section.items.length; i++) ...<Widget>[
                    NotificationCard(notification: section.items[i]),
                    if (i < section.items.length - 1)
                      Padding(
                        padding: EdgeInsets.only(left: 72.w),
                        child: const Divider(
                          height: 1,
                          thickness: 0.6,
                          color: Color(0xFFF0F0F0),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<_Section> _buildSections(
    List<NotificationEntity> notifications,
    BuildContext context,
  ) {
    final Map<String, List<NotificationEntity>> map =
        <String, List<NotificationEntity>>{};
    final List<String> order = <String>[];

    for (final NotificationEntity n in notifications) {
      final String label = _dateLabel(n.createdAt, context);
      if (!map.containsKey(label)) {
        map[label] = <NotificationEntity>[];
        order.add(label);
      }
      map[label]!.add(n);
    }

    return order
        .map((_s) => _Section(label: _s, items: map[_s]!))
        .toList();
  }

  String _dateLabel(DateTime date, BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime dateOnly = DateTime(date.year, date.month, date.day);
    final int diff = today.difference(dateOnly).inDays;

    if (diff == 0) return context.tr(AppLocalizationKeys.today);
    if (diff == 1) return context.tr(AppLocalizationKeys.yesterday);
    if (diff < 7) {
      final String locale = LanguageHelper.isAr(context) ? 'ar' : 'en';
      return DateFormat('EEEE', locale).format(date);
    }
    return DateFormat('yyyy-MM-dd', 'en').format(date);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Error body
// ─────────────────────────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.cloud_off_rounded, size: 56, color: Palette.grey_757575),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(context.tr(AppLocalizationKeys.retry)),
          ),
        ],
      ),
    );
  }
}
