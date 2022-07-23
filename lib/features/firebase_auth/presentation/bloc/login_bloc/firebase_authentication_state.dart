part of 'firebase_authentication_bloc.dart';

abstract class FirebaseAuthenticationState {
  const FirebaseAuthenticationState();

  @override
  List<Object> get props => <Object>[];
}

class FirebaseAuthenticationInitial extends FirebaseAuthenticationState {}

class FirebaseAuthenticationEmpty extends FirebaseAuthenticationState {}

class FirebaseAuthenticationLoading extends FirebaseAuthenticationState {}

class FirebaseAuthenticationLoaded extends FirebaseAuthenticationState {
  const FirebaseAuthenticationLoaded(this.firebaseAuthentication);
  final FirebaseAuthentication? firebaseAuthentication;
}

class FirebaseAuthenticationSentOtp extends FirebaseAuthenticationState {}

class FirebaseAuthenticationError extends FirebaseAuthenticationState {
  const FirebaseAuthenticationError({required this.message});
  final String? message;

  @override
  List<Object> get props => <Object>[message!];
}
