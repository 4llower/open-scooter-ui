import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:open_scooter_ui/feature/data/datasources/scooter_remote_data_source.dart';
import 'package:open_scooter_ui/feature/data/repos/scooter_repo_impl.dart';
import 'package:open_scooter_ui/feature/domain/repos/scooter_repo.dart';

import 'feature/domain/usecases/get_all_scooters.dart';
import 'feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory<ScooterCubit>(
    () => ScooterCubit(getAllScooters: sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GetAllScooters(sl()));

  // Repository
  sl.registerLazySingleton<ScooterRepo>(
      () => ScooterRepoImpl(scooterRemoteDataSource: sl()));

  sl.registerLazySingleton<ScooterRemoteDataSource>(
    () => ScooterRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
