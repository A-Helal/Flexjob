import 'package:flexiJobs/features/shared/data/local_data.dart';

/// Maps the user's `state` field (e.g. "1_pending_personal_info") to an
/// integer step index (1–6) for the profile-completion stepper.
class ParseStatusHelper {
  static int step() {
    final String? state = LocalData.user?.state;
    if (state == null || state.isEmpty) return 1;

    final String firstSegment = state.split('_').first;
    return int.tryParse(firstSegment) ?? 1;
  }
}
