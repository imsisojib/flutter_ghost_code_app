import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_boilerplate_code/src/config/config_firebase.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/api_response.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';

class RepositoryAccount implements IRepositoryAccount {
  final IFirebaseInterceptor firebaseInterceptor;

  RepositoryAccount({
    required this.firebaseInterceptor,
  });

  @override
  Future<ApiResponse<UserCredential?>> createUserByEmailAndPassword(RequestBodySignup requestBody) async {
    ApiResponse<UserCredential?> response = ApiResponse();
    try {
      final credential = await firebaseInterceptor.getAuth().createUserWithEmailAndPassword(
            email: requestBody.email,
            password: requestBody.password,
          );

      response.message = "Signup successful";
      response.statusCode = 200;
      response.data = credential;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response.message = 'The password provided is too weak.';
        response.statusCode = 400;
      } else if (e.code == 'email-already-in-use') {
        response.message = 'The account already exists for that email.';
        response.statusCode = 400;
      }
    } catch (e) {
      response.statusCode = 500;
      response.message = "Something is went wrong.";
    }

    return response;
  }

  @override
  Future<ApiResponse> updateUserInfo(UserModel model) async {
    if (model.uid == null) {
      return ApiResponse(
        statusCode: 400,
        message: "Invalid user!",
      );
    }
    try {
      await firebaseInterceptor.getFirestore().collection(ConfigFirebase.tableUsers).doc(model.uid).set(
            model.toJson(),
            SetOptions(
              merge: true,
            ),
          );

      return ApiResponse(
        statusCode: 200,
        message: "User data updated successfully.",
      );
    } catch (e) {
      //something is went wrong
    }

    return ApiResponse(
      statusCode: 400,
      message: "Unable to update user data.",
    );
  }
}
