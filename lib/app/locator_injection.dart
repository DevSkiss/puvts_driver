import 'package:get_it/get_it.dart';
import 'package:puvts_driver/core/domain/repository/direction_repository.dart';
import 'package:puvts_driver/core/services/cached_services.dart';
import 'package:puvts_driver/features/login_signup/data/repository/passenger_repository_impl.dart';
import 'package:puvts_driver/features/login_signup/data/service/auth_service_api.dart';
import 'package:puvts_driver/features/login_signup/domain/bloc/login_signup_bloc.dart';
import 'package:puvts_driver/features/login_signup/domain/passenger_repository.dart';
import 'package:puvts_driver/features/maps/data/services/map_api_service.dart';
import 'package:puvts_driver/features/maps/domain/bloc/map_bloc.dart';
import 'package:puvts_driver/features/maps/domain/repositories/map_repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Blocs
  locator.registerFactory(
    () => LoginSignupBloc(),
  );

  locator.registerFactory(() => MapBloc());
  locator.registerLazySingleton<MapApiService>(() => MapApiServiceImpl());
  locator.registerLazySingleton<MapRepository>(() => MapRepostioryImpl());

  locator.registerLazySingleton(() => DirectionsRepository());

  // Services
  locator.registerLazySingleton<PassengerRepository>(
      () => PassengerRepositoryImpl());
  locator.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());
  locator.registerLazySingleton<CachedService>(() => CachedServiceImpl());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
