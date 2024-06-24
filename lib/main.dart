import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_code/my_app.dart';
import 'package:flutter_boilerplate_code/src/core/application/token_service.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/providers/provider_common.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'di_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initializing firebase for this project
  await Firebase.initializeApp();

  await di.init(); //initializing Dependency Injection

  //update auth-token from cache [to check user logged-in or not]
  var token = di.sl<IRepositoryCache>().fetchToken();
  di.sl<TokenService>().updateToken(token ?? ""); //update token will re-initialize wherever token was used

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );

  //licencing google fonts
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => di.sl<ProviderCommon>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProviderAccount>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProviderMerchandise>()),
          ChangeNotifierProvider(create: (context) => di.sl<ProviderGameEvents>()),
        ],
        child: const MyApp(),
      ),
    );
  });
}
