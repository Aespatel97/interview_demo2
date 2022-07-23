import 'package:dartz/dartz.dart';
import 'package:smam_tddclean/core/error/failures.dart';
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class FirebaseAuthUseCase<Type, Params> {
  Future<Either<Failure, dynamic>> call(Params params);
}

abstract class GetApiUseCase<Type, Params> {
  Future<Either<Failure, dynamic>> call();
}

abstract class RegisterUseCase<Type, Params>{
  Future<Either<Failure, dynamic>> call(Params params);
}

abstract class LazyLoadApiUseCase<Type, Params> {
  Future<Either<Failure, dynamic>> call();
}


class NoParams {
  @override
  List<Object> get props => <Object>[];
}
