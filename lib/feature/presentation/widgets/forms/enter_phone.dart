import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_state.dart';

class EnterPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      print(state);
      return Container(
          padding: EdgeInsets.all(30.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [Text("Enter your phone")],
            ),
            TextField(onChanged: (hello) => print(hello))
          ]));
    });
  }
}
