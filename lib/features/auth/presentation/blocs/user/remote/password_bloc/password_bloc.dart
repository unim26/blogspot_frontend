import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/domain/usecases/password_usecase/forgot_password_usecase.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  PasswordBloc(
    this._forgotPasswordUsecase,
  ) : super(PasswordInitialState()) {
    //listing to forgot password event
    on<ForgotPasswordEvent>(onForgotPassword);
  }

  //on frogot password event
  void onForgotPassword(
      ForgotPasswordEvent event, Emitter<PasswordState> emit) async {
    //emit loadinding state
    emit(PasswordLoadingState());

    //try to update password
    final datastate = await _forgotPasswordUsecase
        .call({'email': event.email, 'password': event.password});

    //check if datastate is datasuccess
    if (datastate is DataSuccess && datastate.data != null) {
      emit(PasswordForgotedState());
    }

    //check if datastate is datafail
    if (datastate is DataFailed) {
      emit(PasswordFailToForgotState('Something went wrong, try again'));
    }
  }
}
