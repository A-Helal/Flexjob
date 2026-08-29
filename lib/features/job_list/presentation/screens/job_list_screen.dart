import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/features/job_details/presentation/screens/job_details_screen.dart';
import 'package:flexiJobs/features/job_list/presentation/cubit/job_list_cubit.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/presentation/widgets/job_card_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Screen that shows a filtered list of jobs for a specific category.
@RoutePage()
class JobListScreen extends StatefulWidget {
  const JobListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int categoryId;
  final String categoryName;

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  late final JobListCubit _jobListCubit = getIt<JobListCubit>();
  late final ScrollController _scrollController = ScrollController();

  final List<JobEntity> _jobs = <JobEntity>[];
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _jobListCubit.getAvailableJobs(categoryId: widget.categoryId);
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
    final double pixels = _scrollController.position.pixels;
    final double maxExtent = _scrollController.position.maxScrollExtent;
    if (pixels >= maxExtent - 200 && _jobs.length < _total) {
      _jobListCubit.loadMoreJobs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobListCubit>.value(
      value: _jobListCubit,
      child: MasterWidget(
        hasScroll: false,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(widget.categoryName),
        ),
        widget: BlocConsumer<JobListCubit, JobListState>(
          listener: (BuildContext context, JobListState state) {
            if (state is JobListReadyState) {
              _jobs
                ..clear()
                ..addAll(state.jobList ?? const <JobEntity>[]);
              _total = state.total ?? 0;
              if (state.inProgress == true) {
                ViewsToolbox.showLoading();
              } else {
                ViewsToolbox.dismissLoading();
              }
            } else if (state is JobListErrorState) {
              ViewsToolbox.dismissLoading();
              ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
            }
          },
          builder: (BuildContext context, JobListState state) {
            if (state is! JobListReadyState || _jobs.isEmpty) {
              return const SizedBox.shrink();
            }

            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: _jobs.length + (state.inProgress == true ? 1 : 0),
              itemBuilder: (BuildContext ctx, int index) {
                if (index == _jobs.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const Center(
                        child: CircularProgressIndicator.adaptive()),
                  );
                }
                return JobCard(
                  job: _jobs[index],
                  routeFrom: JobDetailsRouteFrom.jobList,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
