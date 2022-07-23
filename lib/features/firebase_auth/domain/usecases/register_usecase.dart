

import 'package:smam_tddclean/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/usecases/usecases.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/bloc/register_bloc/register_bloc.dart';

import '../entities/firebase_auth.dart';
import '../repository/firebase_auth_repository.dart';

class GetRegister
    implements RegisterUseCase<RegisterState, UserDetails> {
  GetRegister(this.repository);
  final FirebaseAuthenticationRepository repository;

  @override
  Future<Either<Failure, RegisterState>> call(UserDetails userDetails) {
   return repository.getRegister(userDetails);
  }
}
