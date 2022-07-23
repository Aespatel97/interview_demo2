import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smam_tddclean/core/network/network_info.dart';
import 'package:smam_tddclean/features/firebase_auth/data/datasource/firebase_auth_data_source.dart';
import 'package:smam_tddclean/features/firebase_auth/data/repository/firebase_auth_repository_impl.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/repository/firebase_auth_repository.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/usecases/get_firebase_auth.dart';
import 'package:smam_tddclean/features/firebase_auth/domain/usecases/register_usecase.dart';
import 'package:smam_tddclean/features/firebase_auth/presentation/bloc/register_bloc/register_bloc.dart';

import 'features/firebase_auth/presentation/bloc/login_bloc/firebase_authentication_bloc.dart';
import 'features/lazy_load_api_call/data/datasource/lazy_load_api_call_data_source.dart';
import 'features/lazy_load_api_call/data/repository/lazy_load_api_call_repository_impl.dart';
import 'features/lazy_load_api_call/domain/repository/lazy_load_api_call_repository.dart';
import 'features/lazy_load_api_call/domain/usercase/lazy_load_api_call_usecase.dart';
import 'features/lazy_load_api_call/presentation/bloc/lazy_load_api_bloc.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  ///Firebase auth Demo
  sl.registerFactory(
    () => FirebaseAuthenticationBloc(getFirebaseAuthentication: sl()),
  );
  sl.registerFactory(
    () => RegisterBloc(sl()),
  );

  sl.registerLazySingleton(() => GetFirebaseAuthentication(sl()));
  sl.registerLazySingleton(() => GetRegister(sl()));
  sl.registerLazySingleton<FirebaseAuthenticationRepository>(
    () => FirebaseAuthenticationRepositoryImpl(
      firebaseAuthenticationDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerFactory(() => LazyLoadApiBloc(testName: sl()));

  sl.registerLazySingleton(() => LazyLoadUseCases(sl()));
  sl.registerLazySingleton<LazyLoadApiRepository>(() =>
      LazyLoadApiRepositoryImpl(getApiCallDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<LazyLoadApiDataSource>(
      () => LazyLoadApiDataSourceImpl());

  sl.registerLazySingleton<FirebaseAuthenticationDataSource>(
    () => FirebaseAuthenticationDataSourceImpl(),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => Connectivity());
}

void initFeatures() {}
