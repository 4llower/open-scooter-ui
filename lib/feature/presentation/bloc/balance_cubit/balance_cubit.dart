import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user.dart';
import 'package:open_scooter_ui/feature/domain/usecases/top_up_balance.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final GetUser getUser;
  final TopUpBalance topUp;
  String valueInput = "";
  double amount = 0;
  List<CreditCardEntity> cards = [];
  BalanceCubit({required this.getUser, required this.topUp})
      : super(BalanceEmpty());

  void loadUser(String token) async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());

    final failureOrUser = await getUser(GetUserParams(token: token));

    failureOrUser.fold(
        (_) => throw UnimplementedError('[Failure] BalanceCubit getUser'),
        (resp) =>
            {cards = resp.balance.cards, emit(BalanceLoaded(user: resp))});
  }

  void topUpBalance() async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());

    final failureOrUser = await topUp(TopUpParams(
        amount: amount,
        balance: BalanceEntity(amount: 0, cards: [], unit: "222"),
        card: cards[0]));
    failureOrUser.fold(
        (_) => throw UnimplementedError('[Failure] BalanceCubit topUpBalance'),
        (resp) => emit(BalanceLoaded(user: resp)));
  }

  void topUpForm() async {
    emit(BalanceTopUp());
  }

  void inputChanged(String input) async {
    valueInput = input;
    double hello = double.parse(input);
    amount = hello;
  }
}
