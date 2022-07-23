import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/core/network/network_info.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/data/datasource/lazy_load_api_call_data_source.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/repository/lazy_load_api_call_repository.dart'; 

class LazyLoadApiRepositoryImpl extends LazyLoadApiRepository {
  LazyLoadApiRepositoryImpl(
      {@required this.getApiCallDataSource, @required this.networkInfo});
  final LazyLoadApiDataSource? getApiCallDataSource;
  final NetworkInfo? networkInfo;

  @override
  Future<Either<Failure, List<LazyLoadApiEntity>>> getUserDetails(
      ) async {
    if (await networkInfo!.isConnected()) {
      try {
        final Either<Failure, List<LazyLoadApiEntity>> getName =
            await getApiCallDataSource!.getUserDetails();
        return getName;
      } catch (e) {
        return Future<Either<Failure, List<LazyLoadApiEntity>>>.value(
            Left<Failure, List<LazyLoadApiEntity>>(ServerFailure()));
      }
    } else {
      return Future<Either<Failure, List<LazyLoadApiEntity>>>.value(
          Left<Failure, List<LazyLoadApiEntity>>(InternetFailure()));
    }
  }
}
