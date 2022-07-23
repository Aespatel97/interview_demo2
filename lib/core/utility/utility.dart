import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smam_tddclean/core/constants/colors.dart';
import 'package:smam_tddclean/core/utility/widget/custom_text_view.dart';

int tagAndroid = 1;
int tagIOS = 2;

void showLog(String value, {String key = 'Result : '}) {
  // ignore: avoid_print
  print('$key : $value');
}

Future<bool> checkInternet() async {
  try {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      showLog('connected');
      return true;
    }
    else if (result != ConnectivityResult.wifi || result != ConnectivityResult.mobile ) {
      showLog('connected');
      return true;
    }
  } on SocketException catch (e) {
    showLog(e.toString());
    return false;
  }

  return false;
}

void showCenterFlash(
    {@required String? message,
    FlashPosition position = FlashPosition.bottom,
    // FlashStyle style = FlashStyle.floating,
    Color color = colorGreen,
    bool isIcon = false,
    Duration? duration,
    GlobalKey? key,
    required BuildContext context}) {
  showFlash(
      context: context,
      duration: duration ?? const Duration(seconds: 3),
      builder: (BuildContext _, FlashController<dynamic> controller) {
        return Flash<dynamic>(
          behavior: FlashBehavior.floating,
          controller: controller,
          position: FlashPosition.bottom,
          child: Wrap(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  color: color,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      if (isIcon)
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.warning,
                            color: colorWhite,
                            size: 18,
                          ),
                        ),
                      Expanded(
                          child: CustomTextView(
                        label: message,
                        type: Type.styleSubTitleBold,
                        maxLine: 7,
                      )),
                    ],
                  )),
            ],
          ),
        );
      });
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

void hideKeyBoard({BuildContext? context}) {
  if (context != null) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

Future<dynamic> navigatePage(
    {required Widget className,
    required BuildContext context,
    bool isReplace = false,
    bool isReplaceAll = false}) {
  return !isReplace && !isReplaceAll
      ? Navigator.push(
          context,
          MaterialPageRoute<Object>(
              builder: (BuildContext context) => className))
      : isReplace
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute<Object>(
                  builder: (BuildContext context) => className))
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<Object>(
                  builder: (BuildContext context) => className),
              (Route<dynamic> route) => false);
}

Future<String> getFirebaseMessagingToken() async {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final String? token = await _fcm.getToken();
  return Future<String>.value(token);
}

Future<String> getFireBaseToken() async {
  String token = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? currentUser = _auth.currentUser;
  if (currentUser != null) {
    token = await currentUser.getIdToken();
  }
  return Future<String>.value(token);
}

Future<bool> isUserLogged() async {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    final String tokenResult = await firebaseUser.getIdToken();
    // ignore: unnecessary_null_comparison
    return tokenResult != null;
  } else {
    return false;
  }
}

User? getUser() {
  try {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    return firebaseUser;
  } catch (e) {
    showLog(e.toString());
    return null;
  }
}

Widget getDivider() {
  return Divider(
    color: colorGray.withOpacity(0.5),
  );
}
