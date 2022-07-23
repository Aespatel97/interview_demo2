// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/core/usecases/usecases.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/usecases/get_firebase_auth.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/repository/lazy_load_api_call_repository.dart';

class LazyLoadUseCases
    implements LazyLoadApiUseCase<LazyLoadApiEntity, Params> {
  LazyLoadUseCases(this.repository);
  final LazyLoadApiRepository repository;

  @override
  Future<Either<Failure, List<LazyLoadApiEntity>>> call(
      ) async {
    return repository.getUserDetails();
  }
}
