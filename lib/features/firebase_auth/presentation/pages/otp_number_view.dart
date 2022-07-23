import 'package:flutter/material.dart';
import '../bloc/login_bloc/firebase_authentication_bloc.dart';

class OTPNumberView extends StatefulWidget {
  const OTPNumberView({Key? key, this.bloc}) : super(key: key);
  final FirebaseAuthenticationBloc? bloc;

  @override
  _OTPNumberViewState createState() => _OTPNumberViewState();
}

class _OTPNumberViewState extends State<OTPNumberView> {
  final TextEditingController otpNumber = TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    return getBodyDesign();
  }

  Widget getBodyDesign() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: otpNumber,
              decoration: const InputDecoration(hintText: 'Enter OTP Number'),
            ),
            const SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                widget.bloc!.add(OTPSubmitEvent(otpNumber.text));
              },
              child: const Text('Otp'),
            )
          ],
        ),
      ),
    );
  }
}
