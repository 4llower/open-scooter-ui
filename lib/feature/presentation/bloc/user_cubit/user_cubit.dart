import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/usecases/enter_auth_code.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_token_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user.dart';
import 'package:open_scooter_ui/feature/domain/usecases/save_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/send_sms.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SendSMS sendSMS;
  final EnterAuthCode enterAuthCode;
  final GetUser getUser;
  final SaveUserCached saveUserCached;
  final GetTokenCached getTokenCached;
  UserCubit(
      {required this.sendSMS,
      required this.enterAuthCode,
      required this.getUser,
      required this.getTokenCached,
      required this.saveUserCached})
      : super(UserLoading());

  void tryLoadUser() async {
    var token = await getTokenFromLocalStorage();
    if (token.length > 0) {
      final failureOrUser = await getUser(GetUserParams(token: token));
      failureOrUser.fold(
          (l) => throw UnimplementedError("[Failure] UserCubit getUser"),
          (r) => {
                saveUserCached(SaveUserCachedParams(user: r)),
                emit(UserLogin(user: r))
              });
    } else {
      emit(UserNotLogin());
    }
  }

  Future<String> getTokenFromLocalStorage() async {
    final failureOrToken = await getTokenCached(GetTokenCachedParams());
    String token = "";
    failureOrToken.fold((l) => {token = ""}, (r) => {token = r});
    return Future.value(token);
  }

  void updatePhone(String phone) async {
    emit(UserNotLogin());
    emit(UserPhoneInput(phone: phone));
  }

  void sendSMSCode() async {
    if (!(state is UserPhoneInput)) return;

    final phone = (state as UserPhoneInput).phone;

    emit(UserSendingSMS());

    final failureOrScooter = await sendSMS(SendSMSParams(phone: phone));

    failureOrScooter.fold(
        (_) => throw UnimplementedError(
            '[Failure] Send SMS Error catch not implemented'),
        (resp) => emit(UserSentSMS()));
  }

  void enterCode(String smsCode) async {
    if (state is UserLogin) return;

    final failureOrScooter =
        await enterAuthCode(EnterAuthCodeParams(smsCode: smsCode));

    failureOrScooter.fold(
        (_) => throw UnimplementedError(
            '[Failure] Enter Auth Error catch not implemented'),
        (user) => {
              saveUserCached(SaveUserCachedParams(user: user)),
              emit(UserLogin(user: user))
            });
  }
}
