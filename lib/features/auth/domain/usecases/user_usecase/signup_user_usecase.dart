import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/core/usecases/usecase.dart';
import 'package:blogspot/features/auth/domain/entities/user_entity.dart';

import '../../repositories/userRepository/user_repository.dart';

class SignupUserUsecase
    implements UseCase<DataState<UserEntity>, Map<String, String>> {
  final UserRepository _userRepository;

  SignupUserUsecase(this._userRepository);

  @override
  Future<DataState<UserEntity>> call(Map<String, String> params) {
    return _userRepository.register(
      params['fullName']!,
      params['email']!,
      params['password']!,
    );
  }
}
