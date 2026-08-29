// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flexiJobs/core/network/base_handling.dart';
import 'package:flexiJobs/core/error/failure.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/domain/use_cases/get_governorates.dart';

import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/entity/base_entity.dart';
import 'package:flexiJobs/features/shared/models/request/base_request_model.dart';
import 'package:injectable/injectable.dart';

part 'governorate_state.dart';

@injectable
class GovernorateCubit extends Cubit<GovernorateState> {
  GovernorateCubit({required this.getGovernoratsUseCase})
      : super(GovernorateInitialState());
  final GetGovernoratsUseCase getGovernoratsUseCase;

  Future<void> getGovernorate({BaseRequestModel? baseRequestModel}) async {
    final CustomResponseType<BaseEntity<List<GovernorateEntity>>>
        eitherPackagesOrFailure = await getGovernoratsUseCase(BaseRequestModel(
            page: 1, pageSize: 100, relatedObjects: <String>["cities"]));

    eitherPackagesOrFailure.fold((Failure failure) {},
        (BaseEntity<List<GovernorateEntity>> response) async {
      await LocalData.setGovernorates(response.data!);
    });
  }
}
