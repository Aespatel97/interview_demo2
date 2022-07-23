import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/usecases/get_firebase_auth.dart';

part 'firebase_authentication_event.dart';
part 'firebase_authentication_state.dart';

class FirebaseAuthenticationBloc
    extends Bloc<FirebaseAuthenticationEvent, FirebaseAuthenticationState> {
  FirebaseAuthenticationBloc({required this.getFirebaseAuthentication})
      : super(FirebaseAuthenticationEmpty());
  final GetFirebaseAuthentication? getFirebaseAuthentication;

  FirebaseAuthenticationState get initialState => FirebaseAuthenticationEmpty();

  @override
  Stream<FirebaseAuthenticationState> mapEventToState(
    FirebaseAuthenticationEvent event,
  ) async* {
    if (event is SendOTPEvent) {
      yield FirebaseAuthenticationLoading();
      final Either<Failure, FirebaseAuthenticationState> authenticationState =
          await getFirebaseAuthentication!(Params(number: event.mobileNo));
      yield* authenticationState.fold((Failure l) async* {
        yield FirebaseAuthenticationError(message: _mapFailureMessage(l));
      }, (FirebaseAuthenticationState r) async* {
        yield r;
      })!;
    } else if (event is OTPSubmitEvent) {
      yield FirebaseAuthenticationLoading();
      final Either<Failure, FirebaseAuthentication> authenticationState = await getFirebaseAuthentication!
          .getOtpSubmit(Params(number: event.otpNumber));
      yield authenticationState.fold((Failure l) {
        return FirebaseAuthenticationError(message: _mapFailureMessage(l));
      }, (FirebaseAuthentication r) {
        return FirebaseAuthenticationLoaded(r);
      });
    }
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server fail';
      case InternetFailure:
        return 'No Internet Connection.';
      default:
        return 'No Internet Connection.';
    }
  }
}
