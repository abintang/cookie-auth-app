import 'package:cookie_auth_app/data/repository/data_repository_impl.dart';
import 'package:cookie_auth_app/data/repository/login_repository_impl.dart';
import 'package:cookie_auth_app/domain/repository/data_repository.dart';
import 'package:cookie_auth_app/domain/repository/login_repository.dart';
import 'package:cookie_auth_app/domain/usecases/data_usecase.dart';
import 'package:cookie_auth_app/domain/usecases/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cookie_jar/cookie_jar.dart';

final GetIt getIt = GetIt.instance;
void configure(SharedPreferences sharedPreferences) {
  /// cookie jar
  getIt.registerLazySingleton<CookieJar>(() => CookieJar());

  /// Login DI
  getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(cookieJar: getIt<CookieJar>()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: getIt<LoginRepository>()));

  /// data DI
  getIt.registerLazySingleton<DataRepository>(
      () => DataRepositoryImpl(cookieJar: getIt<CookieJar>()));
  getIt.registerLazySingleton<DataUseCase>(
      () => DataUseCase(dataRepository: getIt<DataRepository>()));
}
