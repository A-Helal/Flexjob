/// Enum representing the visibility state of check-in/check-out buttons
enum ButtonVisibilityState {
  /// No check-in or check-out buttons should be shown
  none,

  /// Only check-in button should be shown
  checkInOnly,

  /// Only check-out button should be shown
  checkOutOnly,

  /// Both check-in and check-out buttons should be shown (rare case)
  both,
}
