import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class GetTokenCached extends UseCase<String, GetTokenCachedParams> {
  final UserLocalRepo _userRepo;

  GetTokenCached(this._userRepo);

  Future<Either<Failure, String>> call(GetTokenCachedParams params) async {
    return _userRepo.getTokenCached();
  }
}

class GetTokenCachedParams {
  @override
  List<Object> get props => [];
}
