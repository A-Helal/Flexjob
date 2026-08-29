enum AppStatus {
  pending,
  approved,
  accepted,
  missingParams
}

extension AppStatusHelper on AppStatus {
  static AppStatus? of(String? status) {
    switch (status) {
      case "pending":
        return AppStatus.pending;
      case "approved":
        return AppStatus.approved;
      case "accepted":
        return AppStatus.accepted;
      case "missing_params":
        return AppStatus.missingParams;

      default:
        return null;
    }
  }
}
