import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final GetUser getUser;
  BalanceCubit({required this.getUser}) : super(BalanceEmpty());

  void loadUser(String phone) async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());

    final failureOrUser = await getUser(GetUserParams(phone: phone));

    failureOrUser.fold(
        (_) => throw UnimplementedError('[Failure] BalanceCubit getUser'),
        (resp) => emit(BalanceLoaded(user: resp)));
  }
}
