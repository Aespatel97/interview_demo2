import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';
import 'package:smam_tddclean/features/lazy_load_api_call/domain/usercase/lazy_load_api_call_usecase.dart';

import 'lazy_load_api_event.dart';
import 'lazy_load_api_state.dart';

class LazyLoadApiBloc extends Bloc<LazyLoadEvent, LazyLoadApiState> {
  LazyLoadApiBloc({
    required LazyLoadUseCases testName,
  })  : userDetailsUseCases = testName,
        super(LazyLoadApiIntialState());
  final LazyLoadUseCases userDetailsUseCases;
  List<LazyLoadApiEntity> lazyLoadList = <LazyLoadApiEntity>[];

  @override
  Stream<LazyLoadApiState> mapEventToState(LazyLoadEvent event) async* {
    if (event is LazyLoadApiEvent) {
      try {
        yield LazyLoadApiLoadingState();
        final Either<Failure, List<LazyLoadApiEntity>> userState =
            await userDetailsUseCases();

        yield userState.fold((Failure failure) {
          return LazyLoadApiErrorState(mapFailureMessage(failure));
        }, (List<LazyLoadApiEntity> success) {
          lazyLoadList.addAll(success);
          return LazyLoadApiCompleteState(lazyLoadList,
              isLoadMore: success.isNotEmpty);
        });
      } catch (e) {
        yield LazyLoadApiErrorState(e.toString());
      }
    }
  }
}
