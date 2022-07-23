part of 'firebase_authentication_bloc.dart';

abstract class FirebaseAuthenticationEvent {
  const FirebaseAuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

class SendOTPEvent extends FirebaseAuthenticationEvent {
  const SendOTPEvent(this.mobileNo);
  final String mobileNo;

}

class OTPSubmitEvent extends FirebaseAuthenticationEvent {
  const OTPSubmitEvent(this.otpNumber);
  final String otpNumber;

}
