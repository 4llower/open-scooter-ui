import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/usecases/add_new_card.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/remove_credit_card.dart';
import 'package:open_scooter_ui/feature/domain/usecases/save_user_cached.dart';
import 'package:open_scooter_ui/feature/domain/usecases/top_up_balance.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final GetUserCached getUser;
  final TopUpBalance topUp;
  final SaveUserCached saveUserCached;
  final AddNewCard addNewCard;
  final RemoveCreditCard removeCreditCard;
  bool toggleTopUp = false;
  int selectedPrice = 0;
  int selectedMethod = 0;
  List<CreditCardEntity> cards = [];
  BalanceCubit(
      {required this.getUser,
      required this.topUp,
      required this.saveUserCached,
      required this.addNewCard,
      required this.removeCreditCard})
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
                  ? emit(BalanceTopUp(
                      user: resp,
                      selectedPrice: selectedPrice,
                      selectedMethod: selectedMethod))
                  : emit(BalanceLoaded(user: resp))
            });
  }

  void topUpForm() async {
    toggleTopUp = !toggleTopUp;
    loadUser();
  }

  void selectPrice(int selection) async {
    if (selectedPrice == selection) return;
    selectedPrice = selection;
    loadUser();
  }

  void selectMethod(int selection) async {
    if (selectedMethod == selection) return;
    selectedMethod = selection;
    loadUser();
  }

  void execPayment() async {
    if (state is BalanceLoading) return;

    emit(BalanceLoading());
    Either<Failure, UserEntity> failureOrPayment;
    var doPayment = (resp) async => {
          failureOrPayment = await topUp(TopUpParams(
              amount: BalanceTopUp.paymentPrices[selectedPrice].toDouble(),
              user: resp,
              card: cards[selectedMethod])),
          failureOrPayment.fold(
              (_) => throw UnimplementedError(
                  '[Failure] BalanceCubit topUpBalance'),
              (resp) async => {
                    saveUserCached(SaveUserCachedParams(user: resp)),
                    emit(BalanceLoaded(user: resp))
                  })
        };

    final failureOrUser = await getUser(GetUserCachedParams());
    failureOrUser.fold(
        (_) => throw UnimplementedError('[Failure] BalanceCubit getUserCached'),
        (resp) => doPayment(resp));
  }

  void addCard(Map<String, String> input) async {
    var cardInfo = AddNewCardParams(
        cardHolderName: input["CARD_HOLDER"],
        cardNumber: input["CARD_NUMBER"],
        cvvCode: input["CARD_CVV"],
        expiryDate: input["CARD_EXPIRY_DATE"]);
    emit(BalanceLoading());
    final failureOrUser = await addNewCard(cardInfo);
    failureOrUser.fold(
        (l) => throw UnimplementedError('[Failure] BalanceCubit addNewCard'),
        (r) => {
              saveUserCached(SaveUserCachedParams(user: r)),
              cards = r.balance.cards,
              emit(BalanceLoaded(user: r))
            });
  }

  void removeCard(int selectedCard) async {
    emit(BalanceLoading());
    final failureOrUser = await removeCreditCard(
        RemoveCreditCardParams(creditCard: cards[selectedCard]));
    failureOrUser.fold(
        (l) =>
            throw UnimplementedError('[Failure] BalanceCubit removeCreditCard'),
        (r) => {
              saveUserCached(SaveUserCachedParams(user: r)),
              cards = r.balance.cards,
              emit(BalanceLoaded(user: r))
            });
  }
}
