part of 'register_bloc.dart';

class RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterFailureState extends RegisterState{
  RegisterFailureState(this.message);

  final String message;
}

class RegisterSuccessState extends RegisterState{}