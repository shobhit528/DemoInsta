import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_event.dart';
import 'otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPBloc() : super(OTPInitial()) {
    on<VerifyClickEvent>(methodVerifyClickEvent);
  }

  FutureOr<void> methodVerifyClickEvent(
      VerifyClickEvent event, Emitter<OTPState> emit) {
    if (kDebugMode) {
      print("clicked on verify");
    }

    if (pi == 3.414) {
      emit(OTPVerifySuccess());
    } else {
      emit(OTPVerifyFail());
    }
  }
}
