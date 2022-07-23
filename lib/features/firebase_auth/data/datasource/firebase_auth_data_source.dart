import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:smam_tddclean/injection_container.dart';

import '../../../../core/error/failures.dart';
import '../../presentation/bloc/login_bloc/firebase_authentication_bloc.dart';

abstract class FirebaseAuthenticationDataSource {
  Stream<FirebaseAuthenticationState> getFirebasePhoneAuth(String mobileNUmber);
  Future<FirebaseAuthentication> getOtpSubmit(String otpNUmber);
  Future<Either<Failure, RegisterState>> getRegister(UserDetails userDetails);
}

class FirebaseAuthenticationDataSourceImpl
    implements FirebaseAuthenticationDataSource {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int? _forceResendingToken;
  StreamController<FirebaseAuthenticationState> eventStream =
      StreamController<FirebaseAuthenticationState>.broadcast();
  String? verificatedId;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Stream<FirebaseAuthenticationState> getFirebasePhoneAuth(
    String mobileNUmber,
  ) async* {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$mobileNUmber',
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        forceResendingToken: _forceResendingToken);

    yield* eventStream.stream;
  }

  Future<void> verificationCompleted(AuthCredential credential) async {}

  String verificationFailed(FirebaseAuthException authException) {
    try {
      eventStream.add(FirebaseAuthenticationError(message: authException.message));
      return authException.message.toString();
    } catch (e) {
    eventStream.add(FirebaseAuthenticationSentOtp());
      return '';
    }
  }

  void codeSent(String verificationId, [int? forceResendingToken]) {
    _forceResendingToken = forceResendingToken;
    verificatedId = verificationId;
    eventStream.add(FirebaseAuthenticationSentOtp());
  }

  // ignore: use_setters_to_change_properties
  void codeAutoRetrievalTimeout(String verificationId) {
      eventStream.add(FirebaseAuthenticationError(message: 'Something went wrong.'));
    verificatedId = verificationId;
  }

  @override
  Future<FirebaseAuthentication> getOtpSubmit(String otpNUmber) async {
    FirebaseAuthentication? firebaseAuthentication;
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificatedId!,
      smsCode: otpNUmber,
    );

    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    if (authResult.user != null) {
      return FirebaseAuthentication(user: authResult.user);
    } else {
      return firebaseAuthentication!;
    }
  }
  void logout() {
    FacebookAuth.instance.logOut();
    FirebaseAuth.instance.signOut();
  }
  
  @override
  Future<Either<Failure, RegisterState>> getRegister(UserDetails userDetails)  async {
    FirebaseFirestore firebaseFirestore =  FirebaseFirestore.instance;
    try{
      await firebaseFirestore.collection('users').doc(userDetails.uid.toString()).set(userDetails.toJson());
      SharedPreferences sharedPreferences = sl<SharedPreferences>();
      sharedPreferences.setString('user', json.encode(userDetails.toJson()));
      return Right<Failure, RegisterState>(RegisterSuccessState());
    }catch (e){
      return Left<Failure, RegisterState>(ServerFailure());
    }
  }
}
