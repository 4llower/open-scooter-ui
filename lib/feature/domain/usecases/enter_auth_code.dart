import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class EnterAuthCode extends UseCase<UserEntity, EnterAuthCodeParams> {
  final UserRemoteRepo _userRepo;

  EnterAuthCode(this._userRepo);

  Future<Either<Failure, UserEntity>> call(EnterAuthCodeParams params) async {
    return await _userRepo.auth(params.smsCode);
  }
}

class EnterAuthCodeParams extends Equatable {
  final String smsCode;

  EnterAuthCodeParams({required this.smsCode});
  @override
  List<Object> get props => [this.smsCode];
}
