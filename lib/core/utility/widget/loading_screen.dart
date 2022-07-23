import 'package:flutter/material.dart'; 
import 'package:smam_tddclean/core/constants/colors.dart';
import 'custom_text_view.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final bool _darkTheme = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Material(
              color: colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: !_darkTheme ? colorWhite : colorBlack,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomTextView(
                      type: Type.styleSubTitle,
                      label: 'Loading...',
                      color: colorBlack,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
