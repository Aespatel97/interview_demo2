import 'package:smam_tddclean/core/constants/messages.dart';

import '../constants/strings.dart';

abstract class Failure {
  const Failure();
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class InternetFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

String mapFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    case InternetFailure:
      return messageNoInternet;
    default:
      return messageSomethingWentWrong;
  }
}
