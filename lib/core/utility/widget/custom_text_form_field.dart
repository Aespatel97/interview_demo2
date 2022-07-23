import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smam_tddclean/core/constants/colors.dart';

import '../utility.dart';
import 'custom_text_view.dart';

abstract class OnChangeReturn {
  void onChangeValueTextField(String? tag, String value);
}

InputDecoration getTextFieldDecoration(
    {required BuildContext context, String? text, required Color color}) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
      labelText: text,
      labelStyle: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Colors.grey, fontSize: 14.0),
      fillColor: Colors.black,
      counterText: '',
      border: OutlineInputBorder(borderSide: BorderSide(color: color)));
}

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {this.context,
      this.tag,
      this.controller,
      this.textInputType,
      this.currentFocus,
      this.nextFocus,
      this.isDigitOnly = false,
      this.hintText,
      this.labelText,
      this.inputFormatters,
      this.onChange,
      this.isReadOnly = false,
      this.isChangeReturn = false,
      this.color,
      this.textAlign = TextAlign.start,
      this.decoration,
      this.icon,
      this.isDarkTheme = true,
      this.maxLength,
      this.suffixIcon,
      this.onTap,
      this.iconSize,
      this.autoFocus = false,
      this.obscureText = false,
      this.validator,
      this.maxLine = 1,
      this.textCapitalization = TextCapitalization.sentences,
      this.suffixIconWidget,
      this.onChanged,
      this.textStyle,
      this.autoValidate = false,
      this.isFillColor = false,
      this.leftPadding = 8,
      this.borderSize = 3,
      this.borderColor,
      this.onEditComplete});

  BuildContext? context;
  TextEditingController? controller;
  TextInputType? textInputType;
  FocusNode? currentFocus;
  FocusNode? nextFocus;
  bool isDigitOnly;
  bool isReadOnly;
  String? hintText;
  String? labelText;
  List<TextInputFormatter>? inputFormatters;
  OnChangeReturn? onChange;
  String? tag;
  bool isChangeReturn = false;
  Color? color;
  bool isDarkTheme;
  bool isFillColor;
  IconData? icon;
  void Function()? onTap;
  double? iconSize;
  IconData? suffixIcon;
  int? maxLength = 500;
  TextAlign textAlign;
  TextStyle? textStyle;
  InputDecoration? decoration;
  bool autoFocus = false;
  bool obscureText = false;
  void Function()? onEditComplete;
  final String Function(String?)? validator;
  final int maxLine;
  final TextCapitalization textCapitalization;
  final Widget? suffixIconWidget;
  final Function(String)? onChanged;
  final bool autoValidate;
  final double? leftPadding;
  final double? borderSize;
  Color? borderColor;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    try {
      if (widget.isChangeReturn) {
        widget.controller!.addListener(onChange);
      }
      // ignore: empty_catches
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: widget.maxLine,
        obscureText: widget.obscureText,
        cursorColor: widget.color,
        // autovalidate: ,
        autocorrect: widget.autoValidate,
        readOnly: widget.isReadOnly,
        maxLength: widget.maxLength ?? 200,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textAlign: widget.textAlign,
        autofocus: widget.autoFocus,
        onTap: widget.onTap,
        textCapitalization: widget.textCapitalization,
        onChanged: widget.onChanged ?? (String value) {},
        validator: widget.validator ??
            (String? value) {
              return null;
            },
        inputFormatters: (widget.inputFormatters != null)
            ? widget.inputFormatters
            : <TextInputFormatter>[
                if (widget.isDigitOnly)
                  FilteringTextInputFormatter.digitsOnly
                else
                  FilteringTextInputFormatter.singleLineFormatter
              ],
        textInputAction: widget.nextFocus == null
            ? TextInputAction.done
            : TextInputAction.next,
        style: Theme.of(context).textTheme.caption!.copyWith(
            color: colorBlack,
            fontSize: 18,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
        focusNode: widget.currentFocus,
        onEditingComplete: widget.onEditComplete,
        onFieldSubmitted: (String value) {
          widget.nextFocus == null
              ? widget.currentFocus?.unfocus()
              : fieldFocusChange(
                  context, widget.currentFocus!, widget.nextFocus!);
        },
        decoration: (widget.decoration != null)
            ? widget.decoration
            : widget.icon != null || widget.suffixIcon != null
                ? getTextFieldDecorationWithIconBorder()
                : getTextFieldDecorationWithIconBorder(),
      ),
    );
  }

  InputDecoration getTextFieldDecorationWithIconBorder() {
    final Color primaryColor = Theme.of(context).primaryColor;
    return InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 20,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.color ?? primaryColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.color ?? primaryColor)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.color ?? primaryColor)),
        labelText: widget.labelText,
        errorMaxLines: 2,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            color: colorBlack, fontFamily: fontFamily, fontSize: 15),
        labelStyle: const TextStyle(
            color: colorBlack, fontFamily: fontFamily, fontSize: 18),
        fillColor: colorBlack,
        counterText: '',
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.color ?? primaryColor)));
  }

  void onChange() {
    try {
      final String text = widget.controller!.text;
      widget.onChange!.onChangeValueTextField(widget.tag, text);
      // ignore: empty_catches
    } catch (e) {}
  }
}
