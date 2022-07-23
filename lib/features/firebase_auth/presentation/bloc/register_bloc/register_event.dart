part of 'register_bloc.dart';

class RegisterEvent{}

class SubmitRegisterEvent extends RegisterEvent{
  SubmitRegisterEvent(this.name, this.mobileNo, this.uid);

  final String? name;
  final String mobileNo;
  final String uid;
}

class RegisterFailureEvent extends RegisterEvent{
  RegisterFailureEvent(this.message);

  final String message;
}

class RegisterSuccessEvent extends RegisterEvent{}