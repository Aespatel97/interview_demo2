import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smam_tddclean/core/constants/colors.dart';
import 'package:smam_tddclean/core/utility/utility.dart';
import 'package:smam_tddclean/core/utility/widget/load_more_new.dart';
import 'package:smam_tddclean/core/utility/widget/loading.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/bloc/lazy_load_api_bloc.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/bloc/lazy_load_api_event.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/presentation/bloc/lazy_load_api_state.dart';

import '../../../../injection_container.dart';
import '../../../firebase_auth/presentation/pages/mobile_number_page.dart';

class LazyLoadApiWidget extends StatefulWidget {
  const LazyLoadApiWidget({Key? key}) : super(key: key);

  @override
  _LazyLoadApiWidgetState createState() => _LazyLoadApiWidgetState();
}

class _LazyLoadApiWidgetState extends State<LazyLoadApiWidget> {
  LazyLoadApiBloc? cubit;
  int index = 0;
  int pageLimit = 5;
  Completer<dynamic>? completer;
  bool isLoadMore = true;
  bool isApiCall = false;
  List<LazyLoadApiEntity> lazyLoadList = <LazyLoadApiEntity>[];

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context);
    cubit!.add(LazyLoadApiEvent());
    completer = Completer<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Load Api call'),
        actions: [
          TextButton(
              onPressed: () {
                final SharedPreferences sharedPreferences =
                    sl<SharedPreferences>();
                sharedPreferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MobileNumberPage()),
                    (Route<dynamic> route) => false);
              },
              child: const Text('LogOut', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: BlocConsumer<LazyLoadApiBloc, LazyLoadApiState>(
        bloc: cubit,
        listener: (BuildContext context, LazyLoadApiState state) {
          if (state is LazyLoadApiErrorState) {
            isApiCall = false;
            showCenterFlash(
                message: state.message.toString(),
                context: context,
                color: colorRed);
          } else if (state is LazyLoadApiLoadingState) {
            isApiCall = true;
            completer = Completer<dynamic>();
          } else if (state is LazyLoadApiLazyLoadState) {
            isApiCall = true;
            completer = Completer<dynamic>();
          } else if (state is LazyLoadApiCompleteState) {
            isApiCall = false;
            isLoadMore = state.isLoadMore;
            index = index + 1;
            pageLimit = pageLimit + 5;
            completer!.complete('done');
          }
        },
        builder: (BuildContext context, LazyLoadApiState state) {
          if (state is LazyLoadApiIntialState) {
            return buildWidget();
          } else if (state is LazyLoadApiLoadingState) {
            return ProgressBar(
              isCard: true,
            );
          } else if (state is LazyLoadApiCompleteState) {
            return buildWidget(list: state.list);
          } else if (state is LazyLoadApiLazyLoadState) {
            return buildWidget(list: state.list);
          } else if (state is LazyLoadApiErrorState) {
            return Center(child: Text(state.message.toString()));
          } else {
            return buildWidget();
          }
        },
      ),
    );
  }

  Widget buildWidget({List<LazyLoadApiEntity>? list}) {
    return Stack(
      children: <Widget>[
        if (list == null)
          const Offstage()
        else
          ListView.builder(
              padding: const EdgeInsets.all(15),
              itemBuilder: (BuildContext context, int i) {
                return SizedBox(height: 20, child: Text('$i ${list[i].name}'));
              },
              itemCount: list.length),
      ],
    );
  }
}
