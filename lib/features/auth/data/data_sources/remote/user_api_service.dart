import 'package:blogspot/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/user_model.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: userAPIBASEURL)
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  //api call to logining a user
  @POST("/login")
  Future<HttpResponse<UserModel>> login(@Body() Map<String, dynamic> body);

  //api call to register a user
  @POST("/signup")
  Future<HttpResponse<UserModel>> register(@Body() Map<String, dynamic> body);

  // @GET("/user")
  // Future<UserModel> getUser();

  //api call to send otp
  @GET("/sendotp")
  Future<HttpResponse> sendOtp(@Query('EMAIL') String email);

  //api call to verify otp
  @GET("/verifyotp")
  Future<HttpResponse> verifyOtp(
      @Query('EMAIL') String email, @Query('OTP') String otp);

  //api to forgot password
  @PATCH("/forgotpassword")
  Future<HttpResponse> forgotPassword(
      @Query('EMAIL') String email, @Query('WORD') String password);

  // @PUT("/user")
  // Future<UserModel> updateUser(@Body() Map<String, dynamic> body);

  // @DELETE("/logout")
  // Future<void> logout();
}
