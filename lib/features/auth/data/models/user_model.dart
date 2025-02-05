import 'package:blogspot/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  

  const UserModel({
    required String fullName,
    required String email,
    required String profileImage,
    required String id,
    required String token,
  }) : super(
          fullName: fullName,
          email: email,
          profileImage: profileImage,
          id: id,
          token: token,
        );

  

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserModel(
      fullName: user['fullName'],
      email: user['email'],
      profileImage: user['profileImage'],
      id: user['_id'],
      token: json['token'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'fullName': fullName,
  //     'email': email,
  //     'profileImage': profileImage,
  //     'id': id,
  //     'token': token,
  //   };
  // }
}
