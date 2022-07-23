import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/core/webservices/api_call.dart';
import 'package:smam_tddclean/core/webservices/ws_key.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/data/model/lazy_load_api_call_model.dart';

abstract class LazyLoadApiDataSource {
  Future<Either<Failure, List<LazyLoadApiModel>>> getUserDetails();
}

class LazyLoadApiDataSourceImpl implements LazyLoadApiDataSource {
  Dio dio = Dio();

  @override
  Future<Either<Failure, List<LazyLoadApiModel>>> getUserDetails() async {
    try {
      final response = await doApiCall(
          url: 'https://dummy.restapiexample.com/api/v1/employees');

      final List<LazyLoadApiModel> list = <LazyLoadApiModel>[];
      final int total = response['data'].length as int;
      if (total > 0) {
        for (int i = 0; i < total; i++) {
          list.add(LazyLoadApiModel.fromJson(
              response['data'][i] as Map<String, dynamic>));
        }
      }
      return Future<Either<Failure, List<LazyLoadApiModel>>>.value(
          Right<Failure, List<LazyLoadApiModel>>(list));
    } catch (e) {
      return Future<Either<Failure, List<LazyLoadApiModel>>>.value(
          Left<Failure, List<LazyLoadApiModel>>(ServerFailure()));
    }
  }
}
