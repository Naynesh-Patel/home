import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../presentation/error/failure.dart';
import '../../repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpModelState> {
  final AuthRepository repository;
  TextEditingController pinController = TextEditingController();

  SignUpBloc(this.repository) : super(const SignUpModelState()) {
    on<SignUpEventName>((event, emit) {
      emit(state.copyWith(name: event.name, state: const SignUpStateInitial()));
    });
    on<SignUpEventEmail>((event, emit) {
      emit(state.copyWith(
          email: event.email, state: const SignUpStateInitial()));
    });

    on<SignUpEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, state: const SignUpStateInitial()));
    });
    on<SignUpEventPasswordConfirm>((event, emit) {
      emit(state.copyWith(
          passwordConfirmation: event.passwordConfirm,
          state: const SignUpStateInitial()));
    });
    on<SignUpEventAgree>((event, emit) {
      emit(state.copyWith(agree: event.agree));
    });
    on<SignUpEventSubmit>(_submitForm);

    on<AccountActivateCodeSubmit>(_accountActivateCode);
    on<SignUpEventResendCodeSubmit>(_resendCodeEvent);
    on<SignUpEventFormDataClear>(_clearFormData);
  }

  Future<void> _clearFormData(
      SignUpEventFormDataClear event, Emitter<SignUpModelState> emit) async {
    emit(state.clear());
  }

  void _submitForm(
      SignUpEventSubmit event, Emitter<SignUpModelState> emit) async {
    emit(state.copyWith(state: const SignUpStateLoading()));
    final bodyData = state.toMap();
    log(bodyData.toString(), name: "SignUp Data");

    final result = await repository.signUp(bodyData);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = SignUpStateLoadedError(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          final error =
              SignUpStateFormError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (user) {
        log(user.toString(), name: "SignUpBloc Success");
        emit(state.copyWith(state: SignUpStateLoaded(user)));
      },
    );
  }

  Future<void> _accountActivateCode(
    AccountActivateCodeSubmit event,
    Emitter<SignUpModelState> emit,
  ) async {
    emit(state.copyWith(state: const SignUpStateLoading()));
    final map = {'email': state.email, 'token': event.code};
    print('map $map');
    final result = await repository.activeAccountCodeSubmit(map);

    result.fold(
      (Failure failure) {
        final error = SignUpStateFormError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (String success) {
        final loadedData = AccountActivateSuccess(success);
        emit(state.copyWith(state: loadedData));
      },
    );
  }

  Future<void> _resendCodeEvent(
    SignUpEventResendCodeSubmit event,
    Emitter<SignUpModelState> emit,
  ) async {
    emit(state.copyWith(state: const SignUpStateLoading()));
    final map = {'email': event.email};
    final result = await repository.resendVerificationCode(map);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(state: SignUpStateLoadedError(failure.errors)));
      } else {
        emit(state.copyWith(
            state: SignUpStateFormError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(state: ResendCodeState(success)));
    });
  }
}
