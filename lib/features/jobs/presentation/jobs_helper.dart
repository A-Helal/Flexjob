import 'dart:math';
import 'package:flexiJobs/features/jobs/domain/entities/job_entity.dart';
import 'package:flexiJobs/features/jobs/domain/entities/vendor_entity.dart';

class JobsHelper {
  static final Random _random = Random();

  /// Generates a list of dummy jobs for shimmer/preview purposes
  static List<JobEntity> generateDummyJobs(int count) {
    return List.generate(count, (int index) {
      return JobEntity(
        id: index + 1,
        title: _randomJobTitle(),
        code: "JOB-${100 + index}",
        status: _randomStatus(),
        state: _randomState(),
        description: "This is a description for ${_randomJobTitle()} job.",
        latitude: (29 + _random.nextDouble()).toStringAsFixed(6),
        longitude: (31 + _random.nextDouble()).toStringAsFixed(6),
        vendorPayTotalPrice: (400 + _random.nextInt(500)).toDouble(),
        vendorPayPricePerHour: (40 + _random.nextInt(20)).toDouble(),
        totalPrice: (500 + _random.nextInt(500)).toDouble(),
        pricePerHour: (50 + _random.nextInt(20)).toDouble(),
        userTotalPrice: (450 + _random.nextInt(500)).toDouble(),
        userPricePerHour: (45 + _random.nextInt(20)).toDouble(),
        startDate: DateTime(2025, 8, 10 + _random.nextInt(15)),
        endDate: DateTime(2025, 9, 1 + _random.nextInt(15)),
        startTime: _randomTime(),
        endTime: _randomTime(),
        shiftHours: 8,
        numOfApplicants: _random.nextInt(15),
        vendorBranch: "Branch ${index + 1}",
        vendorId: 100 + index,
        vendorBranchId: 200 + index,
        jobCategory: _randomCategory(),
        jobCategoryId: 300 + index,
        cityId: 400 + index,
        vendor: VendorEntity(
          id: 100 + index,
          name: "Vendor ${index + 1}",
        ),
        needsIntroVideo: false,
        total: 800 + _random.nextInt(200),
      );
    });
  }

  /// Generates a valid HH:mm time (24-hour format)
  static String _randomTime() {
    final String hour = _random.nextInt(24).toString().padLeft(2, '0');
    final String minute = _random.nextInt(60).toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  static String _randomJobTitle() {
    final List<String> titles = <String>[
      "Cashier",
      "Waiter",
      "Security Guard",
      "Cleaner",
      "Warehouse Worker",
      "Sales Assistant",
    ];
    return titles[_random.nextInt(titles.length)];
  }

  static String _randomStatus() {
    final List<String> statuses = <String>["open", "in_progress", "closed"];
    return statuses[_random.nextInt(statuses.length)];
  }

  static String _randomState() {
    final List<String> states = <String>["available", "assigned", "completed"];
    return states[_random.nextInt(states.length)];
  }

  static String _randomCategory() {
    final List<String> categories = <String>[
      "Retail",
      "Hospitality",
      "Security",
      "Cleaning",
      "Logistics",
      "Sales",
    ];
    return categories[_random.nextInt(categories.length)];
  }
}
