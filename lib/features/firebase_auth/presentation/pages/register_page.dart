import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/core/utility/utility.dart';
import 'package:smam_tddclean/core/utility/widget/loading.dart';
import '../../../../injection_container.dart';
import '../../../lazy_load_api_call/presentation/page/lazy_load_api_page.dart';
import '../bloc/register_bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  final String mobileNo;
  final String uid;
  RegisterPage({Key? key, required this.mobileNo, required this.uid})
      : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController mobileNumber =
      TextEditingController(text: widget.mobileNo);
  final TextEditingController name = TextEditingController();
  RegisterBloc registerBloc = sl<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => sl<RegisterBloc>(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: BlocConsumer<RegisterBloc, RegisterState>(
              bloc: registerBloc,
              builder: (BuildContext context, RegisterState state) {
                return Stack(
                  children: [
                    getBodyWidget(),
                   if (state is RegisterLoadingState) ProgressBar(
                        isCard: true,
                      ) else const Offstage()
                  ],
                );
              },
              listener: (BuildContext context, RegisterState state) {
                if (state is RegisterFailureState) {
                  showCenterFlash(
                      message: state.message,
                      context: context,
                      color: Colors.red);
                } else if (state is RegisterSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LazyLoadApiPage()));
                  showCenterFlash(
                      message: 'Register Successful', context: context);
                }
              })),
    );
  }

  Widget getBodyWidget() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: name,
            decoration: const InputDecoration(hintText: 'Enter Name'),
          ),
          const SizedBox(
            height: 20,
          ),
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
              registerBloc.add(SubmitRegisterEvent(
                  name.text.trim(), widget.mobileNo, widget.uid));
              // bloc!.add(SendOTPEvent(mobileNumber.text));
            },
            child: const Text('Register'),
          )
        ],
      ),
    ));
  }
}
