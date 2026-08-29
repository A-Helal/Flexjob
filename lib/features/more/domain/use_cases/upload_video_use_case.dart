 import 'package:dio/dio.dart';
import 'package:flexiJobs/features/more/domain/repositories/more_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flexiJobs/core/domain/usecase/base_usecase.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/core/network/base_handling.dart';


@injectable
class UploadVideoUseCase implements UseCase< bool, FormData> {
  UploadVideoUseCase({required this.moreRepository});
  final MoreRepository moreRepository;

  @override
  Future<CustomResponseType< bool>> call(
     FormData  file,
  ) async {
    return moreRepository.uploadVideo(
     file:file,
    );
  }
}
