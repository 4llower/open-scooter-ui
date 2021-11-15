import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/balance_cubit/balance_state.dart';

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
          var cards =
              state.user.balance.cards.map((card) => _buildCard(card)).toList();
          var elements = <Widget>[];
          if (state is BalanceTopUp) {
            elements.add(Center(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        _buildPriceCard(5, state.user.balance.unit),
                        _buildPriceCard(10, state.user.balance.unit),
                        _buildPriceCard(15, state.user.balance.unit)
                      ],
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
                children: state.user.balance.cards
                    .map((c) => _buildPayMethod(c))
                    .toList(),
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
                          onPressed: () => {},
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
                              onPressed: () => {},
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
                              child: Expanded(
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
                              ))))))
            ],
          );
        }
        if (state is BalanceLoading) {
          return CircularProgressIndicator();
        }

        return Text("Balance error");
      },
    );
  }

  Widget _buildCard(CreditCardEntity card) {
    return Card(
        child: ListTile(
      title: Text(card.type),
      trailing: ElevatedButton(
        child: Icon(Icons.delete_outline),
        onPressed: () => {},
      ),
    ));
  }

  Widget _buildPayMethod(CreditCardEntity card) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: InkWell(
                child: Row(
                  children: [Icon(Icons.credit_card), Text(card.type)],
                ),
                onTap: () => {})));
  }

  Widget _buildPriceCard(int price, String unit) {
    return Expanded(
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
                child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$price",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Text("$unit")
                ],
              ),
              onTap: () => {},
            ))));
  }

  void _toogleTopUp(BuildContext context) {
    BlocProvider.of<BalanceCubit>(context)..topUpForm();
  }

  void _onPriceSelect(int ind) {}
}
