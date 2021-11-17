import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class GetUserCached extends UseCase<UserEntity, GetUserCachedParams> {
  final UserLocalRepo _userRepo;

  GetUserCached(this._userRepo);

  Future<Either<Failure, UserEntity>> call(GetUserCachedParams params) async {
    return _userRepo.getUserCached();
  }
}

class GetUserCachedParams extends Equatable {
  @override
  List<Object> get props => [];
}
