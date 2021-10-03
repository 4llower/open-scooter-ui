import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class GetUser extends UseCase<UserEntity, GetUserParams> {
  final UserRepo _userRepo;

  GetUser(this._userRepo);

  Future<Either<Failure, UserEntity>> call(GetUserParams params) async {
    return _userRepo.getUser(params.token);
  }
}

class GetUserParams extends Equatable {
  final String token;
  @override
  List<Object> get props => [];

  GetUserParams({required this.token});
}
