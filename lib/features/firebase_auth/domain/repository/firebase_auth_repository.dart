import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/bloc/register_bloc/register_bloc.dart';

import '../../presentation/bloc/login_bloc/firebase_authentication_bloc.dart';

abstract class FirebaseAuthenticationRepository {
  Future<Either<Failure, FirebaseAuthenticationState>>
      getFirebaseAuthentication(String mobileNumber);

  Future<Either<Failure, FirebaseAuthentication>> getOtpSubmit(
      String otpNumber);

  Future<Either<Failure, RegisterState>> getRegister(UserDetails userDetails);
}
