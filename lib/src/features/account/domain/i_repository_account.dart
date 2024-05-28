import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_login.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';

abstract class IRepositoryAccount{
  Future<ApiResponse<UserCredential?>> createUserByEmailAndPassword(RequestBodySignup requestBody);
  Future<ApiResponse<UserCredential?>> loginByEmailAndPassword(RequestBodyLogin requestBody);
  Future<ApiResponse> updateLoggedInUserData(Map<String, dynamic> json);
  Future<ApiResponse> fetchAvailableAvatars();
  Future<ApiResponse> fetchLoggedInUserProfile();
}