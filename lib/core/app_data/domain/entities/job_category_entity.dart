 import 'package:equatable/equatable.dart';

class JobCategoryEntity extends Equatable {
  const JobCategoryEntity({
   this.id,
   this.name
  });
  


  final int?id;
  final String?name;

  @override
  List<Object?> get props => <Object?>[];
}
