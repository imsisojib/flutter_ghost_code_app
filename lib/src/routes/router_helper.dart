import 'package:fluro/fluro.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_account_information.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_account_settings.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_login.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_login_by_email.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_signup.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/screens/screen_signup_complete.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/screens/screen_buy_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/screens/screen_purchased_tickets.dart';
import 'package:flutter_boilerplate_code/src/features/errors/presentation/screens/screen_error.dart';
import 'package:flutter_boilerplate_code/src/features/game/presentation/screens/screen_game.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/screens/screen_home.dart';
import 'package:flutter_boilerplate_code/src/features/locations/presentation/screens/screen_locations.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/screens/screen_merchandise.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/screens/screen_my_orders.dart';
import 'package:flutter_boilerplate_code/src/features/settings/presentation/screens/screen_payment_method.dart';
import 'package:flutter_boilerplate_code/src/features/settings/presentation/screens/screen_settings.dart';
import 'package:flutter_boilerplate_code/src/features/settings/presentation/screens/screen_share.dart';
import 'package:flutter_boilerplate_code/src/features/splash/presentation/screens/screen_splash.dart';
import 'package:flutter_boilerplate_code/src/features/tutorial/presentation/screens/screen_tutorial.dart';
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
  static final Handler _loginByEmailScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenLoginByEmail();
  });
  static final Handler _signUpScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenSignup();
  });
  static final Handler _signUpCompleteScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenSignupComplete();
  });

  ///ACCOUNT
  static final Handler _accountSettingsScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenAccountSettings();
  });
  static final Handler _accountInformationScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenAccountInformation();
  });


  ///MERCHANDISE
  static final Handler _merchandiseScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenMerchandise();
  });
  static final Handler _myOrdersScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenMyOrders();
  });

  ///BUY-TICKETS
  static final Handler _buyTicketsScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenBuyTickets();
  });
  static final Handler _purchasedTicketsScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenPurchasedTickets();
  });


  ///LOCATIONS
  static final Handler _locationScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenLocations();
  });
  ///TUTORIAL
  static final Handler _tutorialScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenTutorial();
  });
  ///TUTORIAL
  static final Handler _gameScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenGame();
  });
  ///SETTINGS
  static final Handler _settingsScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenSettings();
  });
  static final Handler _paymentScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenPaymentMethod();
  });
  static final Handler _shareScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenShare();
  });


  static final Handler _notFoundHandler =
  Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen, handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.splashScreen, handler: _splashScreenHandler, transitionType: TransitionType.fadeIn);

    ///AUTH
    router.define(Routes.loginScreen, handler: _loginScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.loginByEmailScreen, handler: _loginByEmailScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.signupByEmailScreen, handler: _signUpScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.signupCompleteScreen, handler: _signUpCompleteScreenHandler, transitionType: TransitionType.fadeIn);

    ///ACCOUNT
    router.define(Routes.accountSettingsScreen, handler: _accountSettingsScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.accountInformationScreen, handler: _accountInformationScreenHandler, transitionType: TransitionType.fadeIn);

    ///MERCHANDISE
    router.define(Routes.merchandiseScreen, handler: _merchandiseScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ordersScreen, handler: _myOrdersScreenHandler, transitionType: TransitionType.fadeIn);

    ///BUY-TICKETS
    router.define(Routes.buyTicketsScreen, handler: _buyTicketsScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.purchasedTicketsScreen, handler: _purchasedTicketsScreenHandler, transitionType: TransitionType.fadeIn);
    ///LOCATIONS
    router.define(Routes.locationScreen, handler: _locationScreenHandler, transitionType: TransitionType.fadeIn);
    ///TUTORIAL
    router.define(Routes.tutorialScreen, handler: _tutorialScreenHandler, transitionType: TransitionType.fadeIn);
    ///GAME
    router.define(Routes.gameScreenHandler, handler: _gameScreenHandler, transitionType: TransitionType.fadeIn);
    ///SETTINGS
    router.define(Routes.settingsScreen, handler: _settingsScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.paymentMethodScreen, handler: _paymentScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.shareScreen, handler: _shareScreenHandler, transitionType: TransitionType.fadeIn);
  }

}