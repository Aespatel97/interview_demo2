import 'package:firebase_auth/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';

class FirebaseAuthModel extends FirebaseAuthentication {
  const FirebaseAuthModel({required this.user});
  final User user;
}
