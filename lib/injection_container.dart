import 'package:blogspot/core/utils/methods/validator.dart';
import 'package:blogspot/features/auth/data/repositories/otpRepositoryImpl/otp_repository_impl.dart';
import 'package:blogspot/features/auth/data/repositories/passwordRepositoryImpl/password_repository_impl.dart';
import 'package:blogspot/features/auth/data/repositories/userRepositoryImpl/user_repository_impl.dart';
import 'package:blogspot/features/auth/domain/repositories/otpRespository/otp_repository.dart';
import 'package:blogspot/features/auth/domain/repositories/passwordRepository/password_repository.dart';
import 'package:blogspot/features/auth/domain/repositories/userRepository/user_repository.dart';
import 'package:blogspot/features/auth/domain/usecases/password_usecase/forgot_password_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/user_usecase/logout_user_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/otp_usecase/send_otp_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/user_usecase/signup_user_usecase.dart';
import 'package:blogspot/features/auth/domain/usecases/otp_usecase/verify_otp_usecase.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_password_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/local_user_cubit.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/data_sources/remote/user_api_service.dart';
import 'features/auth/domain/usecases/user_usecase/login_user_usecase.dart';
import 'features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  //dio
  locator.registerSingleton<Dio>(Dio());

  //userapiservice
  locator.registerSingleton<UserApiService>(UserApiService(locator<Dio>()));

  //userrepository
  locator.registerSingleton<UserRepository>(
      UserRepositoryImpl(locator<UserApiService>()));

  //password repository
  locator.registerSingleton<PasswordRepository>(
      PasswordRepositoryImpl(locator<UserApiService>()));

  //otp repository
  locator.registerSingleton<OtpRepository>(
      OtpRepositoryImpl(locator<UserApiService>()));

  //loginuseruse case
  locator.registerSingleton<LoginUserUseCase>(
      LoginUserUseCase(locator<UserRepository>()));

  //create user sign up use case
  locator.registerSingleton<SignupUserUsecase>(
      SignupUserUsecase(locator<UserRepository>()));

  //logout user use case
  locator.registerSingleton<LogoutUserUseCase>(
      LogoutUserUseCase(locator<UserRepository>()));

  //otp

  //verify otp use case
  locator.registerSingleton<VerifyOtpUsecase>(
      VerifyOtpUsecase(locator<OtpRepository>()));

  //send otp use case
  locator.registerSingleton<SendOtpUsecase>(
      SendOtpUsecase(locator<OtpRepository>()));

  //forgot password usecase
  locator.registerSingleton<ForgotPasswordUsecase>(
      ForgotPasswordUsecase(locator<PasswordRepository>()));

  //remote user bloc
  locator.registerFactory<RemoteUserBloc>(() => RemoteUserBloc(
        locator<LoginUserUseCase>(),
        locator<LogoutUserUseCase>(),
        locator<SignupUserUsecase>(),
      ));

  //otp bloc
  locator.registerFactory<OtpBloc>(() => OtpBloc(
        locator<SendOtpUsecase>(),
        locator<VerifyOtpUsecase>(),
      ));

  //obscure password bloc
  locator.registerFactory(() => ObscurePasswordBloc());

  //validators
  locator.registerSingleton<Validator>(Validator());

  //local_user_cubit
  locator.registerSingleton<LocalUserCubit>(LocalUserCubit());
}
