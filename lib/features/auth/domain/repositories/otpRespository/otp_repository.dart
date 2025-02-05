

import '../../../../../core/resources/data_state.dart';

abstract class OtpRepository {


  //sent otp to user email
  Future<DataState<bool>> sendOtp(String email);

  //for otp verification
  Future<DataState<bool>> verifyOtp(String email, String otp);
}