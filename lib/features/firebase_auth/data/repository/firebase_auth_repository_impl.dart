import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:smam_tddclean/core/error/exception.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/core/network/network_info.dart';
import 'package:smam_tddclean/features/firebase_auth/data/datasource/firebase_auth_data_source.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/repository/firebase_auth_repository.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/bloc/register_bloc/register_bloc.dart';

import '../../presentation/bloc/login_bloc/firebase_authentication_bloc.dart';

class FirebaseAuthenticationRepositoryImpl
    extends FirebaseAuthenticationRepository {
  FirebaseAuthenticationRepositoryImpl({
    @required this.networkInfo,
    @required this.firebaseAuthenticationDataSource,
  });
  final NetworkInfo? networkInfo;
  final FirebaseAuthenticationDataSource? firebaseAuthenticationDataSource;

  @override
  Future<Either<Failure, FirebaseAuthenticationState>>
      getFirebaseAuthentication(String mobileNumber) async {
    if (await networkInfo!.isConnected()) {
      try {
        final Stream<FirebaseAuthenticationState> authState =
            firebaseAuthenticationDataSource!
                .getFirebasePhoneAuth(mobileNumber);

        await for (final FirebaseAuthenticationState state in authState) {
          return Right<Failure, FirebaseAuthenticationState>(state);
        }
        return Left<Failure, FirebaseAuthenticationState>(ServerFailure());
      } on ServerException {
        return Left<Failure, FirebaseAuthenticationState>(ServerFailure());
      }
    } else {
      return Left<Failure, FirebaseAuthenticationState>(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, FirebaseAuthentication>> getOtpSubmit(
      String otpNumber) async {
    if (await networkInfo!.isConnected()) {
      try {
        final FirebaseAuthentication authState =
            await firebaseAuthenticationDataSource!.getOtpSubmit(otpNumber);

        return Right<Failure, FirebaseAuthentication>(authState);
      } on ServerException {
        return Left<Failure, FirebaseAuthentication>(ServerFailure());
      }
    } else {
      return Left<Failure, FirebaseAuthentication>(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterState>> getRegister(
      UserDetails userDetails) async {
    if (await networkInfo!.isConnected()) {
      try {
        final Either<Failure, RegisterState> authState =
            await firebaseAuthenticationDataSource!.getRegister(userDetails);
        return authState;
      } on ServerException {
        return Left<Failure, RegisterState>(ServerFailure());
      }
    } else {
      return Left<Failure, RegisterState>(InternetFailure());
    }
  }
}
