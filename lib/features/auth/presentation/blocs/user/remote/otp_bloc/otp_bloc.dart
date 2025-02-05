import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/domain/usecases/otp_usecase/send_otp_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/otp_usecase/verify_otp_usecase.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  //otp send usecase
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;

  OtpBloc(
    this._sendOtpUsecase,
    this._verifyOtpUsecase,
  ) : super(OtpInitialState()) {
    //listing to send otp event
    on<SendOtpEvent>(onOtpSend);
  }

  //on Otp send event
  void onOtpSend(SendOtpEvent event, Emitter<OtpState> emit) async {
    //emit loading state
    emit(OtpLoadingState());

    //try to send otp
    final datastae = await _sendOtpUsecase.call(event.email);

    //if datastate is datasuccess
    if (datastae is DataSuccess && datastae.data != null) {
      emit(OtpSentState());
    }

    //if datastate is datafail
    if (datastae is DataFailed) {
      emit(OtpFailedState(
          "User does not exist or you have entered wrong email"));
    }
  }

  //on otp verify event
  void onOtpVerify(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    //emit loading state
    emit(OtpLoadingState());

    //try to verify otp
    final datastate =
        await _verifyOtpUsecase.call({'email': event.email, 'otp': event.otp});

    //if datastate is datasuccess
    if (datastate is DataSuccess && datastate.data != null) {
      emit(OtpVerifiedState());
    }


    //if datastate is datafail
    if (datastate is DataFailed) {
      emit(OtpFailedState("Invalid OTP, please enter OTP send to your resitered emial"));
    }
  }
}
