import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_boilerplate_code/src/config/config_api.dart';
import 'package:flutter_boilerplate_code/src/core/application/api_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/application/firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/application/token_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/repositories/cache_repository_impl.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_cache_repository.dart';
import 'package:flutter_boilerplate_code/src/core/domain/interfaces/interface_firebase_interceptor.dart';
import 'package:flutter_boilerplate_code/src/features/account/data/repositories/repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/account/domain/i_repository_account.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/repositories/repository_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/domain/i_repository_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/home/presentation/providers/provider_common.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/repositories/repository_cart.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/data/repositories/repository_merchandise.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_cart.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/domain/i_repository_merchandise.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //using dependency-injection
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //interceptors
  sl.registerLazySingleton<IApiInterceptor>(() => ApiInterceptor(baseUrl: ConfigApi.baseUrl));

  ///CHANGE SERVER HERE
  sl.registerLazySingleton<IFirebaseInterceptor>(
    () => FirebaseInterceptor(
      auth: FirebaseAuth.instance,
      db: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance,
    ),
  );

  ///REPOSITORIES
  //#region Repositories
  sl.registerLazySingleton<IRepositoryCache>(
    () => RepositoryCacheImpl(
      sharedPreference: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryAccount>(
    () => RepositoryAccount(
      firebaseInterceptor: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryMerchandise>(
    () => RepositoryMerchandise(
      firebaseInterceptor: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryCart>(
    () => RepositoryCart(
      repositoryCache: sl(),
    ),
  );
  sl.registerLazySingleton<IRepositoryGameEvents>(
    () => RepositoryGameEvents(
      firebaseInterceptor: sl(),
    ),
  );
  //#endregion

  ///USE-CASES

  ///END of USE-CASES

  ///PROVIDERS
  //region Providers
  sl.registerFactory(
    () => ProviderCommon(),
  );
  sl.registerFactory(
    () => ProviderAccount(),
  );
  sl.registerFactory(
    () => ProviderMerchandise(),
  );
  sl.registerFactory(
        () => ProviderGameEvents(),
  );

  ///services
  sl.registerSingleton(NavigationService()); //to initialize navigator-key for app-runtime
  sl.registerSingleton(TokenService()); //token service to store token app-runtime
  //logger
  sl.registerLazySingleton(
    () => Logger(
      printer: PrettyPrinter(
        colors: false,
      ),
    ),
  );
}
