import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';

abstract class ScooterRepo {
  Future<Either<Failure, List<ScooterEntity>>> getAllScooters();
}
