import 'package:blogspot/core/resources/data_state.dart';
import 'package:blogspot/core/usecases/usecase.dart';
import 'package:blogspot/features/auth/domain/entities/user_entity.dart';
import 'package:blogspot/features/auth/domain/repositories/userRepository/user_repository.dart';

class LoginUserUseCase implements UseCase<DataState<UserEntity>, Map<String, String>> {
  final UserRepository _userRepository;

  LoginUserUseCase(this._userRepository);
  
  @override
  Future<DataState<UserEntity>> call(Map<String, String> params) {
    return  _userRepository.login(params['email']!, params['password']!);
  }

}
