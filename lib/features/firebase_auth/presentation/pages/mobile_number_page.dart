import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/core/constants/colors.dart';
import 'package:smam_tddclean/core/utility/utility.dart';
import 'package:smam_tddclean/core/utility/widget/loading.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/pages/register_page.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/page/lazy_load_api_page.dart';
import '../../../../injection_container.dart';
import '../bloc/login_bloc/firebase_authentication_bloc.dart';
import 'otp_number_view.dart';

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  _MobileNumberPageState createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  FirebaseAuthenticationBloc? bloc;
  final TextEditingController mobileNumber =
      TextEditingController(text: '9574981151');
  @override
  void initState() {
    bloc = sl<FirebaseAuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseAuthenticationBloc>(
        create: (_) => sl<FirebaseAuthenticationBloc>(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login Page'),
          ),
          body: BlocConsumer<FirebaseAuthenticationBloc,
              FirebaseAuthenticationState>(
            listener:
                (BuildContext context, FirebaseAuthenticationState state) {
              if (state is FirebaseAuthenticationError) {
                showCenterFlash(
                    message: state.message.toString(),
                    context: context,
                    color: colorRed);
              } else if (state is FirebaseAuthenticationLoaded) {
                getRegisterNavigagtion(state);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => RegisterPage(
                //             mobileNo: mobileNumber.text.trim(),
                //             uid: state.firebaseAuthentication?.user?.uid
                //                     .toString() ??
                //                 '')));
              }
            },
            bloc: bloc,
            builder: (BuildContext context, FirebaseAuthenticationState state) {
              return Stack(
                children: [
                  if (state is FirebaseAuthenticationSentOtp)
                    OTPNumberView(
                      bloc: bloc,
                    )
                  else
                    getBodyDesign(),
                  if (state is FirebaseAuthenticationLoading)
                    ProgressBar(
                      isCard: true,
                    )
                ],
              );

              // if (state is FirebaseAuthenticationEmpty) {
              //   return getBodyDesign();
              // } else if (state is FirebaseAuthenticationLoading) {
              //   return ProgressBar(
              //     isCard: true,
              //   );
              // } else if (state is FirebaseAuthenticationSentOtp) {
              //   return OTPNumberView(
              //     bloc: bloc,
              //   );
              // } else if (state is FirebaseAuthenticationError) {
              //   return Center(
              //     child: Text(
              //       state.message!,
              //     ),
              //   );
              // } else if (state is FirebaseAuthenticationLoaded) {
              //   return SizedBox(
              //     child: Text(state.firebaseAuthentication!.user!.phoneNumber
              //         .toString()),
              //   );
              // } else {
              //   return getBodyDesign();
              // }
            },
          ),
        ));
  }

  Widget getBodyDesign() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: mobileNumber,
            decoration: const InputDecoration(hintText: 'Enter Mobile Number'),
          ),
          const SizedBox(
            height: 20,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              bloc!.add(SendOTPEvent(mobileNumber.text));
            },
            child: const Text('Login'),
          )
        ],
      ),
    ));
  }

  getRegisterNavigagtion(FirebaseAuthenticationLoaded state) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var a = await firebaseFirestore
        .collection('users')
        .doc(state.firebaseAuthentication?.user?.uid.toString() ?? '')
        .get();
    if (a.data() == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterPage(
                  mobileNo: mobileNumber.text.trim(),
                  uid: state.firebaseAuthentication?.user?.uid.toString() ??
                      '')));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LazyLoadApiPage()));
    }
  }
}
