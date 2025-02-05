import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/domain/usecases/user_usecase/login_user_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/user_usecase/logout_user_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/user_usecase/signup_user_usecase.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final LoginUserUseCase _loginUserUseCase;
  final LogoutUserUseCase _logoutUserUseCase;
  final SignupUserUsecase _signupUserUsecase;

  //initializing bloc with initial state
  RemoteUserBloc(
    this._loginUserUseCase,
    this._logoutUserUseCase,
    this._signupUserUsecase,
  ) : super(RemoteUserInitialState()) {
    //listening to login event
    on<RemoteUserLoginEvent>(onLogin);

    //listening to logout event
    on<RemoteUserLogoutEvent>(onLogout);

    //listening to signup event
    on<RemoteUserRegisterEvent>(onSignup);
  }

  
  
  //function to handle login event
  void onLogin(
      RemoteUserLoginEvent event, Emitter<RemoteUserState> emit) async {
    //emitting loading state
    emit(RemoteUserLoadingState());

    //data state variable to hold the response from the usecase
    final dataState = await _loginUserUseCase.call({
      'email': event.email,
      'password': event.password,
    });

    //checking if data state is success and data is not null

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteUserLoadedState(dataState.data!));
    }

    //checking if data state is error
    if (dataState is DataFailed) {
      emit(RemoteUserErrorState(dataState.message!));
    }
  }

//function to handle logout event
  void onLogout(RemoteUserLogoutEvent event, Emitter<RemoteUserState> emit) {
    _logoutUserUseCase.call(null);
    emit(RemoteUserLoggedOutState());
  }

//function to handle signup event
  void onSignup(
      RemoteUserRegisterEvent event, Emitter<RemoteUserState> emit) async {
    //emit loading state
    emit(RemoteUserLoadingState());

    //final datastate
    final datastate = await _signupUserUsecase.call({
      'fullName': event.fullName,
      'email': event.email,
      'password': event.password,
    });

    //check for success
    if (datastate is DataSuccess && datastate.data != null) {
      emit(RemoteUserLoadedState(datastate.data!));
    }

    //check for fail
    if (datastate is DataFailed) {
      emit(RemoteUserErrorState(datastate.message!));
    }
  }

}
