import 'package:flutter/material.dart';
import 'package:smam_tddclean/core/constants/colors.dart';

const String styleTitle = 'title';
const String styleSubTitle = 'subtitle';
const String styleHead = 'head';
const String styleHeadBold = 'head_bold';
const String styleSubHead = 'subhead';
const String styleCaption = 'caption';
const String styleCaptionBold = 'caption_bold';
const String styleBody1 = 'body1';
const String styleBody2 = 'body2';
const String styleSubTitleBold = 'subtitle_bold';
const String styleTitleBold = 'title_bold';
const String fontFamily = 'Geomanist';

enum Type {
  styleTitle,
  styleSubTitle,
  styleHead,
  styleHeadBold,
  styleSubHead,
  styleCaption,
  styleCaptionBold,
  styleBody1,
  styleBody1Bold,
  styleBody2,
  styleBody2Bold,
  styleSubTitleBold,
  styleTitleBold,
}

class CustomTextView extends StatelessWidget {
  const CustomTextView({
    this.label,
    this.type,
    this.textStyle,
    int maxLine = 1,
    this.fontSize,
    this.isStrikeThrough = false,
    this.isShimmer = false,
    this.shimmerColor = Colors.indigo,
    this.textDirection = TextDirection.ltr,
    TextOverflow textOverFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.start,
    Color? color = colorWhite,
    this.isDark = false,
    this.showUnderLine = false,
    this.leftRightPadding,
    this.upDownPadding,
    this.fontWeight,
    this.wordPadding = 0,
    // ignore: prefer_initializing_formals
  })  : maxLine = maxLine,
        textOverflow = textOverFlow,
        // ignore: prefer_initializing_formals
        textAlign = textAlign,
        // ignore: prefer_initializing_formals
        color = color;
  final Type? type;
  final String? label;
  final TextStyle? textStyle;
  final int maxLine;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final Color? color;
  final bool isStrikeThrough;
  final bool isShimmer;
  final Color shimmerColor;
  final TextDirection textDirection;
  final bool showUnderLine;
  final double? leftRightPadding;
  final double? upDownPadding;
  final double? fontSize;
  final bool? isDark;
  final double wordPadding;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: leftRightPadding ?? 0, vertical: upDownPadding ?? 0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: textStyle ?? getTextStyle(context),
        ),
        textDirection: textDirection,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: textOverflow,
      ),
    );
  }

  TextStyle getTextStyle(BuildContext context) {
    TextStyle textTheme;
    switch (type) {
      case Type.styleTitle:
        textTheme = Theme.of(context).textTheme.headline6!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: wordPadding,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleSubTitle:
        textTheme = Theme.of(context).textTheme.subtitle2!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: wordPadding,
            fontWeight: FontWeight.w400,
            fontFamily: fontFamily,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleHead:
        textTheme = Theme.of(context).textTheme.headline5!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleHeadBold:
        textTheme = Theme.of(context).textTheme.headline5!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            fontWeight: FontWeight.bold,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleSubHead:
        textTheme = Theme.of(context).textTheme.subtitle1!.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 1.5,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleCaption:
        textTheme = Theme.of(context).textTheme.caption!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleCaptionBold:
        textTheme = Theme.of(context).textTheme.caption!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: wordPadding,
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleBody1:
        textTheme = Theme.of(context).textTheme.bodyText2!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleBody1Bold:
        textTheme = Theme.of(context).textTheme.bodyText2!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            fontWeight: FontWeight.bold,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleBody2:
        textTheme = Theme.of(context).textTheme.bodyText1!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: wordPadding,
            fontFamily: fontFamily,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;

      case Type.styleSubTitleBold:
        textTheme = Theme.of(context).textTheme.subtitle1!.copyWith(
            color: color,
            fontSize: fontSize,
            letterSpacing: wordPadding,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w800);
        break;
      case Type.styleTitleBold:
        textTheme = Theme.of(context).textTheme.headline6!.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;
      case Type.styleBody2Bold:
        textTheme = Theme.of(context).textTheme.bodyText2!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w800,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
        break;

      default:
        textTheme = Theme.of(context).textTheme.headline6!.copyWith(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: wordPadding,
            decoration: isStrikeThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none);
    }

    if (showUnderLine) {
      textTheme = textTheme.copyWith(decoration: TextDecoration.underline);
    }

    return textTheme;
  }
}
