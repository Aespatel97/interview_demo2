import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/bloc/lazy_load_api_bloc.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/widget/lazy_load_api_widget.dart';

import '../../../../injection_container.dart';

class LazyLoadApiPage extends StatefulWidget {
  const LazyLoadApiPage({Key? key}) : super(key: key);

  @override
  _LazyLoadApiPageState createState() => _LazyLoadApiPageState();
}

class _LazyLoadApiPageState extends State<LazyLoadApiPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LazyLoadApiBloc>(
      create: (_) => sl<LazyLoadApiBloc>(),
      child: const LazyLoadApiWidget(),
    );
  }
}
