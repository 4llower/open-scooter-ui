import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/status/ok.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class SendSMS extends UseCase<OkStatus, SendSMSParams> {
  final UserRemoteRepo _userRepo;

  SendSMS(this._userRepo);

  Future<Either<Failure, OkStatus>> call(SendSMSParams params) async {
    return await _userRepo.sendSMS(params.phone);
  }
}

class SendSMSParams extends Equatable {
  final String phone;

  SendSMSParams({required this.phone});
  @override
  List<Object> get props => [this.phone];
}
