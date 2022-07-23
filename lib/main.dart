import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/page/lazy_load_api_page.dart';
import 'package:smam_tddclean/injection_container.dart';

import 'features/firebase_auth/presentation/bloc/login_bloc/firebase_authentication_bloc.dart';
import 'features/firebase_auth/presentation/pages/mobile_number_page.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRegister = false;
  @override
  void initState() {
    getDetails();
    super.initState();
  }

  getDetails() async {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    if (sharedPreferences.getString('user') != null) {
      dynamic data = json.decode(sharedPreferences.getString('user') ?? '');
      isRegister = data['name'] != null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<FirebaseAuthenticationBloc>(
        create: (_) => sl<FirebaseAuthenticationBloc>(),
        child: isRegister ? const LazyLoadApiPage() : const MobileNumberPage(),
      ),
    );
  }
}
