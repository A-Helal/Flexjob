// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class BaseEntity<T> extends Equatable {
    BaseEntity({
    this.message,
    this.statusCode,
    this.data,
    this.totalRecords,
    this.hasMorePages,
    this.ailsName,
    this.key,
  });
  final String? message;
  final int? statusCode;

  final T? data;
  final String? ailsName;
  final int? totalRecords;
  final bool? hasMorePages;
final String? key;
  @override
  List<Object?> get props => <Object?>[];
 
  
}
