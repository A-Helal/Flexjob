import 'package:flexiJobs/features/job_details/presentation/enum/button_visibility_state.dart';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';

/// Helper class to determine check-in/check-out button visibility logic
class CheckInOutVisibilityHelper {
  /// Determines which buttons should be visible based on job entity state
  ///
  /// Returns [ButtonVisibilityState] indicating which buttons to show
  static ButtonVisibilityState getButtonVisibility(JobEntity jobEntity) {
    // Check if user has check-in available for today's shift
    final bool hasCheckInAvailable = jobEntity.checkInTodayShift != null;

    // Check if user has check-out available for today's shift (and hasn't checked in yet)
    final bool hasCheckOutAvailable = jobEntity.checkoutTodayShift != null &&
                                       jobEntity.checkInTodayShift == null;

    if (hasCheckInAvailable && hasCheckOutAvailable) {
      // Should never happen, but handle it
      return ButtonVisibilityState.checkInOnly;
    } else if (hasCheckInAvailable) {
      return ButtonVisibilityState.checkInOnly;
    } else if (hasCheckOutAvailable) {
      return ButtonVisibilityState.checkOutOnly;
    } else {
      return ButtonVisibilityState.none;
    }
  }

  /// Checks if check-in button should be visible
  static bool shouldShowCheckIn(JobEntity jobEntity) {
    return jobEntity.checkInTodayShift != null;
  }

  /// Checks if check-out button should be visible
  static bool shouldShowCheckOut(JobEntity jobEntity) {
    return jobEntity.checkoutTodayShift != null &&
           jobEntity.checkInTodayShift == null;
  }

  /// Checks if both buttons can be shown together with cancel button
  static bool hasCancelButtonSpace(JobEntity jobEntity) {
    // If no check-in or check-out buttons, cancel button gets full width
    return jobEntity.checkInTodayShift == null &&
           jobEntity.checkoutTodayShift == null;
  }
}
