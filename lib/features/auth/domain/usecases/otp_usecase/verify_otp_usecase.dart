import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/core/usecases/usecase.dart';
import 'package:blogspot/features/auth/domain/repositories/otpRespository/otp_repository.dart';

class VerifyOtpUsecase
    implements UseCase<DataState<bool>, Map<String, dynamic>> {
  final OtpRepository _otpRepository;

  VerifyOtpUsecase(this._otpRepository);

  @override
  Future<DataState<bool>> call(Map<String, dynamic> params) {
    return _otpRepository.verifyOtp(params['email'], params['otp']);
  }
}
