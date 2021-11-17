import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class SaveUserCached extends UseCase<void, SaveUserCachedParams> {
  final UserLocalRepo _userLocalRepo;

  SaveUserCached(this._userLocalRepo);

  @override
  Future<Either<Failure, void>> call(SaveUserCachedParams params) async {
    return _userLocalRepo.saveUserInCache(params.user);
  }
}

class SaveUserCachedParams extends Equatable {
  final UserEntity user;

  SaveUserCachedParams({required this.user});

  @override
  List<Object> get props => [];
}
