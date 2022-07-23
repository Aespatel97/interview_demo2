import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smam_tddclean/core/constants/messages.dart';
import 'package:smam_tddclean/core/error/failures.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/entities/firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/usecases/register_usecase.dart';

import '../../../domain/usecases/get_firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GetRegister getRegisterUseCase;
  RegisterBloc(this.getRegisterUseCase) : super(RegisterState()) {
    on<SubmitRegisterEvent>(
        (SubmitRegisterEvent event, Emitter<RegisterState> emit) =>
            getRegister(event.mobileNo, event.name, event.uid, emit));
    
    on<RegisterFailureEvent>((event, emit) => emit(RegisterFailureState(event.message)));

    on<RegisterSuccessEvent>((event, emit) => emit(RegisterSuccessState()));
  }

  getRegister(
      String mobileNo, String? name, String uid, Emitter<RegisterState> emit) {
    try {
      emit(RegisterLoadingState());
      getRegisterUseCase(UserDetails(mobileNo: mobileNo, name: name, uid: uid))
          .then((Either<Failure, RegisterState> value) {
        value.fold((l) {
          add(RegisterFailureEvent(messageSomethingWentWrong));
        }, (RegisterState r) {
          add(RegisterSuccessEvent());
        });
      });
    } catch (e) {
      emit(RegisterFailureState(e.toString()));
    }
  }
}
