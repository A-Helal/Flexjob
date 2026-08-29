import 'package:dio/src/form_data.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/features/more/data/data_sources/more_remote_data_sources.dart';
import 'package:flexiJobs/features/more/domain/repositories/more_repository.dart';
import 'package:injectable/injectable.dart';
 
@Injectable(as: MoreRepository)
class MoreRepositoryImp implements MoreRepository {
 MoreRepositoryImp({
    required this. moreRemoteDataSource,
  });
  final MoreRemoteDataSource moreRemoteDataSource;

  @override
  Future<CustomResponseType<bool>> uploadVideo({required FormData file}) {
    return moreRemoteDataSource.uploadVideo(file: file);
  }
 
}
