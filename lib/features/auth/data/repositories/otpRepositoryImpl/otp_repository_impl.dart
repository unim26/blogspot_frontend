import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/features/auth/domain/repositories/otpRespository/otp_repository.dart';
import 'package:dio/dio.dart';

import '../../data_sources/remote/user_api_service.dart';

class OtpRepositoryImpl implements OtpRepository {
  final UserApiService _userApiService;

  OtpRepositoryImpl(this._userApiService);

  //send otp method
  @override
  Future<DataState<bool>> sendOtp(String email) async {
    try {
      final httpresponse = await _userApiService.sendOtp(email);

      //check if staus is ok
      if (httpresponse.response.statusCode == 200) {
        return DataSuccess(true);
      } else {
        return DataFailed('Something went wrong, please try again');
      }
    } on DioException catch (e) {
      final error = e.response!.data['message'] ??
          'something went wrong, please try again';

      if (error == 'user-does-not-exist') {
        return DataFailed('You dont have account,please create one');
      } else {
        return DataFailed(error);
      }
    }
  }

  //verify otp method
  @override
  Future<DataState<bool>> verifyOtp(String email, String otp) async {
    try {
      final httpresponse = await _userApiService.verifyOtp(email, otp);

      if (httpresponse.response.statusCode == 200 &&
          httpresponse.response.data['message'] == 'Otp-verified') {
        return DataSuccess(true);
      } else {
        return DataFailed("otp verification failed");
      }
    } on DioException catch (e) {
      final error = e.response!.data['message'];

      if (error == 'invalid-otp') {
        return DataFailed('Invalid otp');
      } else {
        return DataFailed(error ?? 'something went wrong');
      }
    }
  }
}
