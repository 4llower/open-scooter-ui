import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/top_up_balance.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final GetUserCached getUser;
  final TopUpBalance topUp;
  bool toggleTopUp = false;
  int selectedPrice = -1;
  List<CreditCardEntity> cards = [];
  BalanceCubit({required this.getUser, required this.topUp})
      : super(BalanceEmpty());

  void loadUser() async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());

    final failureOrUser = await getUser(GetUserCachedParams());

    failureOrUser.fold(
        (_) => throw UnimplementedError(
            '[Failure] BalanceCubit getUser from cache'),
        (resp) => {
              cards = resp.balance.cards,
              toggleTopUp
                  ? emit(BalanceTopUp(user: resp))
                  : emit(BalanceLoaded(user: resp))
            });
  }

  void topUpBalance() async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());

    final failureOrUser = await topUp(TopUpParams(
        amount: 0,
        balance: BalanceEntity(amount: 0, cards: [], unit: "222"),
        card: cards[0]));
    failureOrUser.fold(
        (_) => throw UnimplementedError('[Failure] BalanceCubit topUpBalance'),
        (resp) => emit(BalanceLoaded(user: resp)));
  }

  void topUpForm() async {
    toggleTopUp = !toggleTopUp;
    loadUser();
  }
}
