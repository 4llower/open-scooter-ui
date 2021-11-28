import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/forms/enter_card.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        if (state is BalanceEmpty) {
          return Text("No data");
        }
        if (state is BalanceLoaded) {
          var balanceAmount = state.user.balance.amount.toString();
          var balance = balanceAmount.length > 6
              ? balanceAmount.substring(0, 5)
              : balanceAmount;
          var cards = _buildCards(context, state.user.balance.cards);
          var elements = <Widget>[];
          if (state is BalanceTopUp) {
            elements.add(Center(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: _buildPriceCards(
                          context,
                          state.getPaymentPrices(),
                          state.user.balance.unit,
                          state.selectedPrice),
                    ))));
            elements.add(Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: Text(
                  "Payment method:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )));
            elements.add(Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildPayMethods(
                    context, state.user.balance.cards, state.selectedMethod),
              ),
            ));
            elements.add(Container(
                child: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minHeight: 30,
                            minWidth: 300,
                            maxHeight: 50,
                            maxWidth: 350),
                        child: ElevatedButton(
                          child: Text("Pay"),
                          onPressed: state.paymentReady
                              ? () => _doPayment(context)
                              : null,
                        )))));
          }
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Balance",
                    style: TextStyle(fontSize: 33),
                  )),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.all(8),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Wallet",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(children: [
                              Text(
                                balance,
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(state.user.balance.unit,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ]),
                            Row(
                                mainAxisAlignment: state is BalanceTopUp
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                children: [
                                  state is BalanceTopUp
                                      ? ElevatedButton(
                                          onPressed: () =>
                                              _toogleTopUp(context),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.arrow_drop_up),
                                              Text("Top-up for:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ))
                                      : ElevatedButton(
                                          onPressed: () =>
                                              _toogleTopUp(context),
                                          child: Text(
                                            "Top-up",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                ]),
                            ...elements
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                  // constraints:
                  //     const BoxConstraints(minHeight: 200, maxHeight: 300),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Card(
                              child: ListTile(
                            title: Text("Add new card"),
                            trailing: ElevatedButton(
                              child: Icon(Icons.control_point_outlined),
                              onPressed: () => _addCard(context),
                            ),
                          )),
                          ...cards
                        ],
                      ))),
              Container(
                  child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Card(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(8),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Price list",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("To unlock:"),
                                          Text(
                                            "1.00 BYN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Per minute:"),
                                          Text("0.30 BYN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pre minute (pause)"),
                                          Text("0.07 BYN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ))
                                ],
                              )))))
            ],
          );
        }
        if (state is BalanceLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Text("Balance error");
      },
    );
  }

  List<Widget> _buildCards(
      BuildContext context, List<CreditCardEntity> userCards) {
    List<Widget> cards = [];
    for (int i = 0; i < userCards.length; i++) {
      cards.add(Card(
          child: ListTile(
        title: Text(userCards[i].type),
        trailing: ElevatedButton(
          child: Icon(Icons.delete_outline),
          onPressed: () => _handleCreditCardRemoving(context, i),
        ),
      )));
    }
    return cards;
  }

  List<Widget> _buildPayMethods(
      BuildContext context, List<CreditCardEntity> cards, int selected) {
    List<Widget> methods = [];
    for (int i = 0; i < cards.length; i++) {
      methods.add(Card(
        color: i == selected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(Icons.credit_card),
          title: Text(cards[i].type),
          onTap: () => _handleMethodSelection(context, i),
        ),
      ));
    }
    return methods;
  }

  List<Widget> _buildPriceCards(
      BuildContext context, List<int> prices, String unit, int selected) {
    List<Widget> cards = [];
    for (int i = 0; i < prices.length; i++) {
      cards.add(Expanded(
          child: Card(
              color: i == selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background,
              clipBehavior: Clip.antiAlias,
              child: Container(
                  child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(prices[i].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    Text("$unit")
                  ],
                ),
                onTap: () => _handlePriceSelection(context, i),
              )))));
    }
    return cards;
  }

  void _toogleTopUp(BuildContext context) {
    if (BlocProvider.of<BalanceCubit>(context).cards.length == 0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          //TODO: add alert dialog message from config
          title: const Text('Top-up'),
          content: const Text(
              'You don\'t have payment methods to top-up your balance. Add at least one credit card and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    BlocProvider.of<BalanceCubit>(context)..topUpForm();
  }

  void _handlePriceSelection(BuildContext context, int selection) {
    BlocProvider.of<BalanceCubit>(context)..selectPrice(selection);
  }

  void _handleMethodSelection(BuildContext context, int selection) {
    BlocProvider.of<BalanceCubit>(context)..selectMethod(selection);
  }

  void _handleCreditCardRemoving(BuildContext context, int selection) {
    BlocProvider.of<BalanceCubit>(context)..removeCard(selection);
  }

  void _doPayment(BuildContext context) {
    BlocProvider.of<BalanceCubit>(context)..execPayment();
  }

  void _addCard(BuildContext context) async {
    var input = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EnterCard()));
    BlocProvider.of<BalanceCubit>(context)..addCard(input);
  }
}
