import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child:
        BlocBuilder<ScooterCubit, ScooterState>(builder: (context, state) {
      if (state is ScooterEmpty) {
        return Text('Empty');
      }

      if (state is ScooterLoading) {
        return CircularProgressIndicator();
      }

      if (state is ScooterLoaded) {
        return Text(state.scooterList[0].chargeLevel.toString());
      }

      return Text('Unexpected error');
    }));
  }
}
