import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? id;
  final String? token;

  const UserEntity({
    this.fullName,
    this.email,
    this.profileImage,
    this.id,
    this.token,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        profileImage,
        id,
        token,
      ];
}
