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
    return Center(child: BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        if (state is BalanceEmpty) {
          return Text("No data");
        }
        if (state is BalanceLoaded) {
          var balance = state.user.balance.amount;
          var cards =
              state.user.balance.cards.map((card) => _buildCard(card)).toList();
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: const Icon(
                          Icons.account_balance_wallet,
                          size: 70,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text("Balance:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "$balance",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(state.user.balance.unit,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () => _topUpForm(context),
                                  child: Text(
                                    "Top up",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ))
                    ],
                  ),
                )),
              ),
              Expanded(
                  flex: 4,
                  child: ListView(
                    padding: const EdgeInsets.all(8),
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
                  ))
            ],
          );
        }
        if (state is BalanceLoading) {
          return CircularProgressIndicator();
        }
        if (state is BalanceTopUp) {
          return Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [Text("Enter the value")],
                    ),
                    TextField(
                        onChanged: (value) =>
                            _handleInputChange(context, value)),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => _topUpBalance(context),
                            child: Text("Top up"))
                      ],
                    )
                  ]));
        }

        return Text("Balance error");
      },
    ));
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

  void _handleInputChange(BuildContext context, String value) {
    BlocProvider.of<BalanceCubit>(context)..inputChanged(value);
  }

  void _topUpForm(BuildContext context) {
    BlocProvider.of<BalanceCubit>(context)..topUpForm();
  }

  void _topUpBalance(BuildContext context) {
    BlocProvider.of<BalanceCubit>(context)..topUpBalance();
  }
}
