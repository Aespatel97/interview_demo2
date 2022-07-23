import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/core/usecases/usecases.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/repository/firebase_auth_repository.dart';

import '../../presentation/bloc/login_bloc/firebase_authentication_bloc.dart';

class GetFirebaseAuthentication
    implements FirebaseAuthUseCase<FirebaseAuthentication, Params> {
  GetFirebaseAuthentication(this.repository);
  final FirebaseAuthenticationRepository repository;

  @override
  Future<Either<Failure, FirebaseAuthenticationState>> call(
      Params params) async {
    return repository.getFirebaseAuthentication(params.number!);
  }

  Future<Either<Failure, FirebaseAuthentication>> getOtpSubmit(
      Params params) async {
    return repository.getOtpSubmit(params.number!);
  }
}

class Params {
  const Params({required this.number});
  final String? number;

  @override
  List<Object> get props => <Object>[number!];
}
