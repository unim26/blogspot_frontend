import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/core/usecases/usecase.dart';
import 'package:blogspot/features/auth/domain/repositories/passwordRepository/password_repository.dart';

class ForgotPasswordUsecase implements UseCase<DataState, Map<String, String>> {
  final PasswordRepository _passwordRepository;

  ForgotPasswordUsecase(this._passwordRepository);
  @override
  Future<DataState> call(Map<String, String> params) {
    return _passwordRepository.forgotPassword(
        params['email']!, params['password']!);
  }
}
