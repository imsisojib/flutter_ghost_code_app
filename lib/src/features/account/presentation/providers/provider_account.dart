import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/data/models/empty.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/applications/usecase_create_user_by_email_password.dart';
import 'package:flutter_boilerplate_code/src/features/account/applications/usecase_fetch_available_avatars.dart';
import 'package:flutter_boilerplate_code/src/features/account/applications/usecase_fetch_loggedin_user_profile.dart';
import 'package:flutter_boilerplate_code/src/features/account/applications/usecase_signin_by_email_password.dart';
import 'package:flutter_boilerplate_code/src/features/account/applications/usecase_update_user_data.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/avatar.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/entities/user_model.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_login.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/requestbodys/requestbody_signup.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProviderAccount extends ChangeNotifier {
  //states
  ELoading? _loading;
  UserModel? _currentUser;
  List<Avatar> _availableAvatars = [];

  //getters
  ELoading? get loading => _loading;

  UserModel? get currentModel => _currentUser;

  List<Avatar> get availableAvatars => _availableAvatars;

  //setters
  set loading(ELoading? flag) {
    _loading = flag;
    notifyListeners();
  }

  //methods
  Future<void> createUserByEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    loading = ELoading.submitButtonLoading;
    RequestBodySignup requestBody = RequestBodySignup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    var result = await UseCaseCreateUserByEmailAndPassword(
      repositoryAccount: sl(),
    ).execute(requestBody);
    result.fold(
      (error) {
        Fluttertoast.showToast(
          msg: error.message,
        );
      },
      (success) {
        Fluttertoast.showToast(
          msg: success.message ?? "Success",
        );
        //save user data
        //save user data
        Map<String, dynamic> map = {};
        map[UserModel.keyUid] = success.data?.user?.uid;
        map[UserModel.keyEmail] = requestBody.email;
        map[UserModel.keyFirstName] = requestBody.firstName;
        map[UserModel.keyLastName] = requestBody.lastName;
        updateUserData(map);

        //navigate to complete-signup page
        Navigator.pushNamedAndRemoveUntil(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.signupCompleteScreen,
          (params) => false,
        );
      },
    );

    loading = null;
  }

  Future<void> updateUserData(Map<String, dynamic> data) async {
    var result = await UseCaseUpdateUserData(repositoryAccount: sl()).execute(data);
    result.fold(
      (error) {
        Fluttertoast.showToast(
          msg: error.message,
        );
      },
      (response) {
        Fluttertoast.showToast(
          msg: response,
        );
      },
    );
  }

  Future<void> completeSignup({
    required String displayName,
    int? age,
    String? gender,
    String? profilePic,
  }) async {
    loading = ELoading.submitButtonLoading;

    //save user data
    Map<String, dynamic> map = {};
    map[UserModel.keyUid] = sl<IFirebaseInterceptor>().getAuth().currentUser?.uid;
    map[UserModel.keyDisplayName] = displayName;
    map[UserModel.keyAge] = age;
    map[UserModel.keyGender] = gender;
    map[UserModel.keyProfilePic] = profilePic;

    var result = await UseCaseUpdateUserData(repositoryAccount: sl()).execute(map);
    result.fold(
      (error) {
        Fluttertoast.showToast(msg: "Unable to complete signup. Please try again later.");
      },
      (response) {
        Fluttertoast.showToast(msg: "Signup completed.");
        Navigator.pushNamedAndRemoveUntil(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.homeScreen,
          (params) => false,
        );
      },
    );
    loading = null;
  }

  Future<void> loginByEmailAndPassword({required String email, required String password}) async {
    loading = ELoading.submitButtonLoading;
    RequestBodyLogin requestBody = RequestBodyLogin(
      email: email,
      password: password,
    );
    var result = await UseCaseSignInByEmailAndPassword(repositoryAccount: sl()).execute(requestBody);
    result.fold(
      (error) {
        Fluttertoast.showToast(
          msg: error.message,
        );
      },
      (response) {
        Fluttertoast.showToast(msg: response.message ?? "");
        Navigator.pushNamedAndRemoveUntil(
          sl<NavigationService>().navigatorKey.currentContext!,
          Routes.homeScreen,
          (params) => false,
        );
      },
    );
    loading = null;
  }

  Future<void> logout() async {
    await sl<IFirebaseInterceptor>().getAuth().signOut();
    await sl<NavigationService>().navigatorKey.currentContext!.read<ProviderMerchandise>().clearCacheCart();
    Navigator.pushNamedAndRemoveUntil(
      sl<NavigationService>().navigatorKey.currentContext!,
      Routes.loginScreen,
      (route) => false,
    );
  }

  Future<void> fetchAvailableAvatars() async {
    loading = ELoading.fetchingData;
    var result = await UseCaseFetchAvailableAvatars(repositoryAccount: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _availableAvatars = response;
        notifyListeners();
      },
    );
    loading = null;
  }

  Future<void> fetchLoggedInUserProfile({
    bool forceUpdate = false,
    bool showLoading = true,
  }) async {
    if(_currentUser!=null && !forceUpdate) return;
    if(showLoading) loading = ELoading.fetchingData;

    var result = await UseCaseFetchLoggedInUserProfile(repositoryAccount: sl()).execute(Empty());
    result.fold(
      (error) {},
      (response) {
        _currentUser = response;
        notifyListeners();
      },
    );
    loading = null;
  }
}
