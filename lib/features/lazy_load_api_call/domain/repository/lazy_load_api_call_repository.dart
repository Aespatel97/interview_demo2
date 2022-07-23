// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';

abstract class LazyLoadApiRepository {
  Future<Either<Failure, List<LazyLoadApiEntity>>> getUserDetails(
      );
}
