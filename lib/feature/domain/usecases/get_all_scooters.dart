import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/scooter_repo.dart';

class GetAllScooters extends UseCase<List<ScooterEntity>, GetAllScooterParams> {
  final ScooterRepo _scooterRepo;

  GetAllScooters(this._scooterRepo);

  Future<Either<Failure, List<ScooterEntity>>> call(
      GetAllScooterParams params) async {
    return await _scooterRepo.getAllScooters();
  }
}

class GetAllScooterParams extends Equatable {
  @override
  List<Object> get props => [];

  GetAllScooterParams();
}
