import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_text_view.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({this.msg = 'No Data Found'});
  final String msg;

  // ignore: avoid_field_initializers_in_const_classes
  final bool isHeight = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[Container()],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        // child: ImageAssets.noDataFound(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: CustomTextView(
                            label: msg,
                            type: Type.styleTitleBold,
                            maxLine: 5,
                            textAlign: TextAlign.center,
                          )),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
