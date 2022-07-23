import 'package:flutter/material.dart';
import 'package:smam_tddclean/core/constants/colors.dart'; 

import 'custom_text_view.dart';

Widget getWidgetButton(
    {BuildContext? context,
    String? label,
    Function? func,
    Color? bgColor,
    Color? textColor,
    double? width,
    String? imagedata,
    double iconSize = 20,
    double? height,
    double borderRadius = 8,
    bool isBorder = false,
    Color? colorBorder,
    Color leftIconColor = colorWhite,
    Color rightIconColor = colorWhite,
    bool isLoading = false,
    bool isAnimation = false,
    AnimationController? controller,
    String textLoading = 'Loading...'}) {
  return isLoading
      ? Container(
          decoration: BoxDecoration(
            color: isBorder ? colorWhite : bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          width: width ?? MediaQuery.of(context!).size.width,
          height: height ?? 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator()),
              const SizedBox(
                width: 20,
              ),
              CustomTextView(
                label: textLoading,
                type: Type.styleSubTitle,
              )
            ],
          ))
      : Container(
          width: width ?? MediaQuery.of(context!).size.width,
          height: height ?? 50,
          decoration: BoxDecoration(
            color: isBorder ? colorWhite : bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: func != null
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: bgColor,
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  ),
                  onPressed: () {
                    func();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (imagedata != null)
                        Image.asset(
                          imagedata,
                          height: 20,
                        )
                      else
                        const Offstage(),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextView(
                          label: label,
                          type: Type.styleTitle,
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: colorWhite,
                              fontFamily: fontFamily),
                          color: (textColor != null)
                              ? textColor
                              : isBorder
                                  ? colorBorder
                                  : colorWhite),
                    ],
                  ),
                )
              : OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: bgColor,
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  ),
                  onPressed: () {
                    if (func != null) {
                      func();
                    }
                  },
                  child: Center(
                    child: CustomTextView(
                        label: label,
                        type: Type.styleSubTitle,
                        color: (textColor != null)
                            ? textColor
                            : isBorder
                                ? colorBorder
                                : colorWhite),
                  ),
                ),
        );
}
