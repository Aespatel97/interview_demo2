import 'package:smam_tddclean/features/lazy_load_api_call/domain/entity/lazy_load_api_call_entity.dart';

class LazyLoadApiState {}

class LazyLoadApiIntialState extends LazyLoadApiState {}

class LazyLoadApiLoadingState extends LazyLoadApiState {}

class LazyLoadApiLazyLoadState extends LazyLoadApiState {
  LazyLoadApiLazyLoadState(this.list);
  final List<LazyLoadApiEntity>? list;
}

class LazyLoadApiCompleteState extends LazyLoadApiState {
  LazyLoadApiCompleteState(this.list, {this.isLoadMore = false});
  final List<LazyLoadApiEntity>? list;
  final bool isLoadMore;
}

class LazyLoadApiErrorState extends LazyLoadApiState {
  LazyLoadApiErrorState(this.message);
  final String? message;
}
