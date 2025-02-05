import 'package:blogspot/core/usecases/usecase.dart';

import '../../repositories/userRepository/user_repository.dart';

class LogoutUserUseCase implements UseCase<void, void> {
  final UserRepository _userRepository;

  LogoutUserUseCase(this._userRepository);

  @override
  Future<void> call(void params) {
    return _userRepository.logout();
  }
}
