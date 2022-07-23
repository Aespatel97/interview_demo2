import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthentication {
  const FirebaseAuthentication({@required this.user});
  final User? user;

  @override
  List<Object> get props => <Object>[user!];
}

class UserDetails{
  UserDetails({this.mobileNo, this.name, this.uid});

  final String? mobileNo;
  final String? name;
  final String? uid;

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json['name'].toString(),
        mobileNo: json['mobileNo'].toString(),
        uid: json['uid'].toString(),
    );

    Map<String, dynamic> toJson() => {
        'name': name,
        'mobileNo': mobileNo,
        'uid': uid,
    };
}