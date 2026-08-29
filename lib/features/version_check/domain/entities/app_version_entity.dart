import 'package:equatable/equatable.dart';

class AppVersionEntity extends Equatable {
  final int? androidVersion;
  final int? androidCriticalVersion;
  final int? iosVersion;
  final int? iosCriticalVersion;
  final String? currentDatetime;

  const AppVersionEntity({
    this.androidVersion,
    this.androidCriticalVersion,
    this.iosVersion,
    this.iosCriticalVersion,
    this.currentDatetime,
  });

  @override
  List<Object?> get props => [
        androidVersion,
        androidCriticalVersion,
        iosVersion,
        iosCriticalVersion,
        currentDatetime,
      ];
}
