import 'package:flexiJobs/features/shared/data/local_data.dart';

class UseHelper {
  static bool isGuest() {
    return LocalData.user?.is_guest == 1;
  }
}
