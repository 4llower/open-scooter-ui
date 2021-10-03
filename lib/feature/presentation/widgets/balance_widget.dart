import 'package:dartz/dartz_unsafe.dart';
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
                  padding: EdgeInsets.only(left: 60, right: 60),
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
                                  Text("Balanse:"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "$balance",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () => {},
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
                  // child: ListView.builder(
                  //   padding: const EdgeInsets.all(8),
                  //   itemCount: state.user.balance.cards.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Container(
                  //       height: 50,
                  //       margin: EdgeInsets.all(3),
                  //       child: ListTile(

                  //       )
                  //     )
                  //   }
                  // ),
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
}
