import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:open_scooter_ui/feature/data/datasources/scooter_remote_data_source.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_local_data_source.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_remote_data_source.dart';
import 'package:open_scooter_ui/feature/data/repos/scooter_repo_impl.dart';
import 'package:open_scooter_ui/feature/data/repos/user_repo_impl.dart';
import 'package:open_scooter_ui/feature/domain/repos/scooter_repo.dart';
import 'package:open_scooter_ui/feature/domain/usecases/add_new_card.dart';
import 'package:open_scooter_ui/feature/domain/usecases/enter_auth_code.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_token_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/remove_credit_card.dart';
import 'package:open_scooter_ui/feature/domain/usecases/save_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/send_sms.dart';
import 'package:open_scooter_ui/feature/domain/usecases/top_up_balance.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/domain/repos/user_repo.dart';
import 'feature/domain/usecases/get_all_scooters.dart';
import 'feature/domain/usecases/get_user.dart';
import 'feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory<ScooterCubit>(
    () => ScooterCubit(getAllScooters: sl()),
  );
  sl.registerFactory<UserCubit>(() => UserCubit(
      sendSMS: sl(),
      enterAuthCode: sl(),
      getUser: sl(),
      getTokenCached: sl(),
      saveUserCached: sl()));
  //TODO:replace singleton with factory for scanner
  sl.registerSingleton<ScannerCubit>(ScannerCubit());
  sl.registerFactory<BalanceCubit>(() => BalanceCubit(
      getUser: sl(),
      topUp: sl(),
      saveUserCached: sl(),
      addNewCard: sl(),
      removeCreditCard: sl()));
  // UseCases
  sl.registerLazySingleton(() => GetAllScooters(sl()));
  sl.registerLazySingleton(() => EnterAuthCode(sl()));
  sl.registerLazySingleton(() => SendSMS(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => TopUpBalance(sl()));
  sl.registerLazySingleton(() => GetUserCached(sl()));
  sl.registerLazySingleton(() => SaveUserCached(sl()));
  sl.registerLazySingleton(() => AddNewCard(sl()));
  sl.registerLazySingleton(() => RemoveCreditCard(sl()));
  sl.registerLazySingleton(() => GetTokenCached(sl()));

  // Repository
  sl.registerLazySingleton<ScooterRepo>(
      () => ScooterRepoImpl(scooterRemoteDataSource: sl()));
  sl.registerLazySingleton<UserRemoteRepo>(
      () => UserRemoteRepoImpl(userRemoteDataSource: sl()));
  sl.registerLazySingleton<UserLocalRepo>(
      () => UserLocalRepoImpl(userLocalDataSource: sl()));

  // Data source
  sl.registerLazySingleton<ScooterRemoteDataSource>(
    () => ScooterRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(futurePrefs: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<Future<SharedPreferences>>(
      () => SharedPreferences.getInstance());
}
