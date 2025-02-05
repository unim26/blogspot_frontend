import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/core/usecases/usecase.dart';
import 'package:blogspot/features/auth/domain/repositories/otpRespository/otp_repository.dart';

class SendOtpUsecase implements UseCase<DataState<bool>, String> {
  final OtpRepository _otpRepository;

  SendOtpUsecase(this._otpRepository);

  @override
  Future<DataState<bool>> call(String params) {
    return _otpRepository.sendOtp(params);
  }
}
