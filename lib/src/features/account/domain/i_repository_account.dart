import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';

abstract class IRepositoryAccount{
  Future<ApiResponse<UserCredential?>> createUserByEmailAndPassword(RequestBodySignup requestBody);
  Future<ApiResponse> updateUserInfo(UserModel model);
}