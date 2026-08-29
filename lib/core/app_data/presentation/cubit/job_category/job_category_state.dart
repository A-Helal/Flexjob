part of 'job_category_cubit.dart';

abstract class JobCategoryState  {
}

class JobCategoryInitialState extends JobCategoryState {}
class JobCategoryLoadingState extends JobCategoryState {}
class JobCategoryReadyState extends JobCategoryState {}
class JobCategoryErrorState extends JobCategoryState {
  JobCategoryErrorState({
 required this.message,
});
 final String message;

} 
  