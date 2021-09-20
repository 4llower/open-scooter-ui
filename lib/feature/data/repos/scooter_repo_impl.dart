import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/feature/data/datasources/scooter_remote_data_source.dart';
import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/scooter_repo.dart';

class ScooterRepoImpl implements ScooterRepo {
  final ScooterRemoteDataSource scooterRemoteDataSource;

  ScooterRepoImpl({required this.scooterRemoteDataSource});

  Future<Either<Failure, List<ScooterEntity>>> getAllScooters() async {
    return Right(await scooterRemoteDataSource.getAllScooters());
  }
}
