import 'package:flutter/material.dart';
import 'package:smam_tddclean/core/constants/colors.dart';

import 'custom_text_view.dart';

// ignore: must_be_immutable
class ProgressBar extends StatelessWidget {
  ProgressBar(
      {this.message = 'Loading...',
      this.isCard = false,
      this.isCurve = false,
      this.color = Colors.white,
      this.isOpacity = false,
      this.height,
      this.width});
  String message = '';
  bool isCard = false;
  Color color;
  bool isOpacity = false;
  bool isCurve = false;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return isCard
        ? Container(
            decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isCurve ? 20 : 0),
                    topRight: Radius.circular(isCurve ? 20 : 0))),
            height: height ?? MediaQuery.of(context).size.height,
            width: width ?? MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: width == null
                    ? MediaQuery.of(context).size.width * 0.5
                    : width! * 0.5,
                height: height == null
                    ? MediaQuery.of(context).size.height * 0.25
                    : height! * 0.25,
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
                        const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(colorGreen)),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextView(
                          type: Type.styleSubTitle,
                          label: message,
                          color: colorBlack,
                          textAlign: TextAlign.center,
                          maxLine: 4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
          );
  }
}
