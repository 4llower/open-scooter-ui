import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/usecases/enter_auth_code.dart';
import 'package:open_scooter_ui/feature/domain/usecases/send_sms.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SendSMS sendSMS;
  final EnterAuthCode enterAuthCode;

  UserCubit({required this.sendSMS, required this.enterAuthCode})
      : super(UserNotLogin());

  void sendSMSCode(String phone) async {
    if (state is UserLogin) return;

    final failureOrScooter = await sendSMS(SendSMSParams(phone: phone));

    failureOrScooter.fold(
        (_) => throw UnimplementedError(
            '[Failure] Send SMS Error catch not implemented'),
        (resp) => emit(UserSendSMS()));
  }

  void enterCode(String smsCode) async {
    if (state is UserLogin) return;

    final failureOrScooter =
        await enterAuthCode(EnterAuthCodeParams(smsCode: smsCode));

    failureOrScooter.fold(
        (_) => throw UnimplementedError(
            '[Failure] Enter Auth Error catch not implemented'),
        (user) => emit(UserLogin(user: user)));
  }
}
