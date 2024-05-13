import 'package:fluro/fluro.dart';
import 'package:flutter_boilerplate_code/src/features/auth/presentation/screens/screen_login.dart';
import 'package:flutter_boilerplate_code/src/features/errors/presentation/screens/screen_error.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/screens/screen_home.dart';
import 'package:flutter_boilerplate_code/src/features/splash/presentation/screens/screen_splash.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';


class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///MAIN-FLOW
  static final Handler _homeScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenHome();
  });

  ///SPLASH
  static final Handler _splashScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenSplash();
  });

  ///AUTH
  static final Handler _loginScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenLogin();
  });

  static final Handler _notFoundHandler =
  Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.splashScreen, handler: _splashScreenHandler, transitionType: TransitionType.fadeIn);

    ///AUTH]
    router.define(Routes.loginScreen, handler: _loginScreenHandler, transitionType: TransitionType.cupertino);
  }

}